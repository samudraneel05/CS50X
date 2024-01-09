# Python program to do the equivalent of readability
from cs50 import get_string


# Main function that receives values and performs calculations
def main():
    text = get_string("Text: ")
    letters = count_letters(text)
    words = count_words(text)+1
    sentences = count_sentences(text)
    # Reading grade calculation
    l = (letters / words) * 100.0
    s = (sentences / words) * 100.0
    grade = 0
    grade = 0.0588 * l - 0.296 * s - 15.8
    # If Grade greater or equal to 16
    if (grade >= 16):
        print("Grade 16+\n")
    # Grade lesser than 1
    elif (grade < 1):
        print("Before Grade 1\n")
    # Grade in between 1 and 16
    else:
        print("Grade ", + round(grade, 0))


# Function to calculate number of letters
def count_letters(input):
    let = 0
    for i in range(len(input)):
        if (input[i].isalpha()):
            let += 1
    return let


# Function to calculate number of words
def count_words(input):
    wor = 0
    for j in range(len(input)):
        if (input[j].isspace()):
            wor += 1
    return wor


# Function to calculatr number of sentences
def count_sentences(input):
    sen = 0
    for k in range(len(input)):
        if ((input[k] == '.') or (input[k] == '!') or (input[k] == '?')):
            sen += 1
    return sen


main()