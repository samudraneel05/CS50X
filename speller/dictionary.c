// Implements a dictionary's functionality
#include <stdio.h>
#include <ctype.h>
#include <stdbool.h>
#include <string.h>
#include <strings.h>
#include <stdlib.h>
#include "dictionary.h"

// Represents a node in a hash table
typedef struct node
{
    char word[LENGTH + 1];
    struct node *next;
}
node;

// TODO: Choose number of buckets in hash table
const unsigned int N = 100000;

// Hash table
node *table[N];

// Dictionary word count
int dict_wordno = 0;

// Returns true if word is in dictionary, else false
bool check(const char *word)
{
    int hash_index = hash(word);
    node *search = table[hash_index];
    while (search != NULL)
    {
        if (strcasecmp(search->word, word) == 0)
        {
            return true;
        }
        search = search->next;
    }
    return false;
}

// Hashes word to a number
unsigned int hash(const char *word)
{
    int sum = 0;
    for (int i = 0; i < strlen(word); i++)
    {
        sum += tolower(word[i]);
    }
    return sum % N;
}

// Loads dictionary into memory, returning true if successful, else false
bool load(const char *dictionary)
{
    //Open the dictionary file
    FILE *file = fopen(dictionary, "r");
    if (file != NULL)
    {
        char dict_word[LENGTH + 1];
        // Loop through each word in the dictionary
        while (fscanf(file, "%s", dict_word) != EOF)
        {
            // Initializing a node
            node *n = malloc(sizeof(node));
            if (n == NULL)
            {
                return false;
            }
            // Copies the dictionary word into a node
            strcpy(n->word, dict_word);
            // Assigns next pointer as NULL
            n->next = NULL;
            // Calls upon the hash function
            int hash_index = hash(dict_word);
            // If word is to enter a new linked list in the table
            if (table[hash_index] == NULL)
            {
                table[hash_index] = n;
            }
            // If word is to be added to an existing linked list in the table
            else
            {
                n->next = table[hash_index];
                table[hash_index] = n;
            }
            dict_wordno ++;
        }
        fclose(file);
        return true;
    }

    else
    {
        return false;
    }
}

// Returns number of words in dictionary if loaded, else 0 if not yet loaded
unsigned int size(void)
{
    return dict_wordno;
}

// Unloads dictionary from memory, returning true if successful, else false
bool unload(void)
{
    // Iterate over hash table and free nodes in each linked list
    for (int i = 0; i < N; i++)
    {
        // Assign node to the first element of first linked list
        node *search = table[i];
        // Loop through linked list to find end
        while (search != NULL)
        {
            node *tmp = search;
            search = search->next;
            free(tmp);
        }
        if (search == NULL && i == N - 1)
        {
            return true;
        }
    }
    return false;
}
