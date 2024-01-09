#include <cs50.h>
#include <stdio.h>

int main(void)
{
    int height;
    do
    {
        height = get_int("Please enter the height of the pyramid to be built: ");
    }
    while (height < 1 || height > 8);

// To generate rows
    for (int row = 0; row < height; row++)
    {
        // To generate gaps or spaces
        for (int space = height - row - 1; space > 0; space--)
        {
            printf(" ");
        }
        // To generate the hash symbols in left oriented pyramid
        for (int left_hash = 0; left_hash < row + 1; left_hash++)
        {
            printf("#");
        }
        // To generate the gap in between the two pyramids
        printf("  ");
        // To generate the hash symbols in right oriented pyramid
        for (int right_hash = 0; right_hash < row + 1; right_hash++)
        {
            printf("#");
        }
        printf("\n");
    }
}