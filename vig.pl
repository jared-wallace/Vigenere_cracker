#!/bin/perl

my ($string1, $string2, $string3, $string4, $string5)='';

###############################################################################
#        Define our function for frequency analysis                           #
#        Parameters:    The string to be analyzed.                            #
#        Pre:           A string is the first argument.                       #
#        Post:          The frequency analysis has been printed.              #
###############################################################################
sub freq_analysis
{
    my $alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ ";
    my $count = 0;
    my $integer = 0;
    for my $c (split //, $alpha)
    {
        $count = () = $_[0] =~ /$c/g;
        print sprintf("%s - %3d (offset = -%d)\n", $c, $count, $integer);
        $integer++;
    }
}

###############################################################################
#        Define our string translation function                               #
#        Parameters:    The integer amount to shift the alphabet by and the   #
#                       ciphertext string to translate.                       #
#        Pre:           The first argument is an integer between 0 and -27,   #
#                       and the second is a string.                           #
#        Returns:       The translated plaintext.                             #
###############################################################################
sub translate
{
    my $alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ ";
    my $translate = substr($alpha, $_[0], 27) . substr($alpha, 0, 27+$_[0]);
    my $result = $_[1];
    eval "\$result =~ tr/$alpha/$translate/";
    return $result;
}

###############################################################################
#        Drecyption function                                                  #
#        Parameters:    The five integer values representing the key.         #
#                       For example, if the key letter is 'B',                #
#                       the corresponding integer value is '-1'.              #
#        Pre:           5 integer arguments with values between 0 and -27     #
#                       have been passed in.                                  #
#        Returns:       The decrypted text string.                            #
###############################################################################
sub decrypt
{
    $string1 = translate($_[0], $string1);
    $string2 = translate($_[1], $string2);
    $string3 = translate($_[2], $string3);
    $string4 = translate($_[3], $string4);
    $string5 = translate($_[4], $string5);

    my $plaintext = "";
    for (my $i = 0; $i < 168; $i++)
    {
        $plaintext .= substr($string1, $i, 1);
        $plaintext .= substr($string2, $i, 1);
        $plaintext .= substr($string3, $i, 1);
        $plaintext .= substr($string4, $i, 1);
        $plaintext .= substr($string5, $i, 1);
    }
    return $plaintext;
}

###############################################################################
#        Main function                                                        #
###############################################################################


# Read in the cipher text and place it in a string variable
my $filename = 'cipher.txt';
open(my $fh, '<', $filename)
  or die "Could not open file '$filename' $!";
my $cipher = <$fh>;

# Split up our text into the 5 constituent strings
for (my $i = 0; $i < 837; $i+=5)
{
    $string1 .= substr($cipher, $i, 1);
    $string2 .= substr($cipher, $i+1, 1);
    $string3 .= substr($cipher, $i+2, 1);
    $string4 .= substr($cipher, $i+3, 1);
    $string5 .= substr($cipher, $i+4, 1);
}
freq_analysis($string1);
print decrypt(0,0,0,0,0);
