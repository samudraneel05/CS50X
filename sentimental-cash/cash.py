# Python program to do the equivalent of cash
from cs50 import get_float


# Main function
def main():
    # Ask how much the customer is owed
    amount = get_amount()
    coins = 0
    # Start from base unit, cents
    cents = amount/0.01
    # Find quarters
    while cents >= 25:
        cents -= 25
        coins += 1
    # Find dimes
    while cents >= 10:
        cents -= 10
        coins += 1
    # Find nickels
    while cents >= 5:
        cents -= 5
        coins += 1
    # Total number of coins
    coins = cents + coins
    print(round(coins))


# Helper function to ensure valid input
def get_amount():
    while True:
        amount = get_float("Change owed: ")
        if amount > 0:
            break
    return amount


main()