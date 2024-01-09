# Python program to do the equivalent of mario-less
from cs50 import get_int


# Main function that does the looping
def main():
    height = get_height()
    for row in range(height):
        print(" " * (height-row-1), end="")
        print("#" * (row+1))


# Helper function which checks for valid input
def get_height():
    while True:
        height = get_int("Height: ")
        if height > 0 and height < 9:
            break
    return height


main()
