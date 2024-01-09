# Python program to do the equivalent of credit
from cs50 import get_string


# Main function that inputs a valid card number and matches it
def main():
    cardno = get_string("Number: ")
    no_of_digits = len(cardno)
    if validity_check(cardno) == False:
        print("INVALID")
    else:
        if no_of_digits == 15 and (cardno[0:2] == "34" or cardno[0:2] == "37"):
            print("AMEX")
        elif no_of_digits == 16 and (int(cardno[0:2]) >= 51 and int(cardno[0:2]) <= 55):
            print("MASTERCARD")
        elif (no_of_digits == 13 or no_of_digits == 16) and (cardno[0:1] == "4"):
            print("VISA")


# Helper function that operates Luhn's Algorithm on given card number
def validity_check(number):
    index = 0
    sum_of_even_numbers = 0
    sum_of_odd_numbers = 0
    for digit in number:
        index += 1
        digit = int(digit)
        if (len(number) - index) % 2 == 0:
            # Even numbers: Add to total
            sum_of_even_numbers += digit
        else:
            # Odd number: Multiply by 2, sum product's individual digits, add to total
            digit *= 2
            if digit > 9:
                digit = int(str(digit)[0:1]) + int(str(digit)[1:2])
            sum_of_odd_numbers += digit

    if (sum_of_even_numbers + sum_of_odd_numbers) % 10 == 0:
        return True
    else:
        return False


main()