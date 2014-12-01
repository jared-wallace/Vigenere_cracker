#!/usr/bin/python

from string import *


def freq(string):
    alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ "
    for i in alpha:
        print i,
        print ' ',
        print string.count(i),
        print ' ',
        print "%f" % (string.count(i) / 167.0)


# This function performs a substitution trannslation
# of a given string.
def shift(string, amount):
    intab = "ABCDEFGHIJKLMNOPQRSTUVWXYZ "
    outtab = rotate(amount)
    # transtab allows translating a string based
    # on a defined relationship (intab, outtab)
    transtab = maketrans(intab, outtab)
    return string.translate(transtab)


# This function "rotates" a string by the specified amount
def rotate(amount):
    rotated = "ABCDEFGHIJKLMNOPQRSTUVWXYZ "
    return rotated[amount:] + rotated[:amount]


# Open our cipher text and store it into a string
cipher_text = open('cipher.txt', 'r').read()
# Create our 5 seperate strings
string0 = []
string1 = []
string2 = []
string3 = []
string4 = []
# Populate our strings
try:
    for i in range(0,837,5):
        string0.append(cipher_text[i])
        string1.append(cipher_text[i+1])
        string2.append(cipher_text[i+2])
        string3.append(cipher_text[i+3])
        string4.append(cipher_text[i+4])
except:
    # just ignore the out of range stuff
    pass

# For frequency analysis, change the string passed
# to the function "freq"
freq(''.join(string0))

# When you are ready to decrypt, use the shift function.
# Pass in the string to be decrypted, and the amount of the shift.
#
# For example, if the key letter is H, pass in the string and the number
# '-7', since the H advanced the plaintext character by 7.

result0 = shift(''.join(string0), -19)  # T
result1 = shift(''.join(string1), -7)   # H
result2 = shift(''.join(string2), -23)  # X
result3 = shift(''.join(string3), -6)   # G
result4 = shift(''.join(string4), -21)  # V

# Now we merge the 5 different decrypted strings together
final = ""
for i in range(0,168):
    final += result0[i:i+1]
    final += result1[i:i+1]
    final += result2[i:i+1]
    final += result3[i:i+1]
    final += result4[i:i+1]

#print final
