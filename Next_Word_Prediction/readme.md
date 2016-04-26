<style> pre, code{
      color: #DA2727;
      
      font-size: 0.94em; /* 0.94 = 0.88 + (1.00 - 0.88) / 2 */
      border-radius:3px;
      background-color: #F8F8F8;
      border: 1px solid #CCC;
    }
</style>

## Word prediction: Model Building

A 10% sample was first collected from the combined corpus of news, blogs and twitter [data](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip) provided to us. 

The sample was first cleaned to remove all non-ASCII characters such as the emoticons.

The sample was then tokenised using the `quanteda` pacakge, removing numbers, spaces, punctuations, hyphens, and twitter symbols (@#). Then all the bad words were removed 
using the a good list of bad words by Google found [here](http://fffff.at/googles-official-list-of-bad-words/).

The tokenised words were then stemmed to reduce the different forms of any given word to their root form for better prediction. The stemmed tokens were then used to create three n-gram models for n = 1,2,3 (unigram, bigram and trigrams). Words with frequency of one were removed, since most of them were misspellings, or very unique words, or cliches. The n-gram models were again created using the `quanteda` package. 

Once the n-gram models were created, they were converted to a `data.table` format, where the different words had their own columns. So, for a trigam `i_am_going`, the table had three columns, one that stored the first word `i`, another column for the second word `am`, a third column with the last word `going` (actually go after stemming), and the last column for the count of the trigram. Similar tables were created for the bigram and the unigram. The word columns were set as `key` to speed up the searching. The conversion of these n-gram models to the data.table format brought exceptional speed improvements in the later processing, and also lead to somehow smaller memory usage for the data. 

`Kneser-Ney Algorithm` was then used to calculate the probability of every word sequence in our sample. The resulting n-gram models were then saved for use in this app.

## App functioning
The app loads the n-gram models created above, and for any given text input, retrieves the last two words of the string. Based on the two words, the app tries to find if any matching trigrams can be found starting with those two words, and if they are found, it returns the most probable next words (the number returned depends on the user). 

If no match is found in the trigram (or the number of matches is less than what was requested by the user), then the app searches in the bigram model and returns the required number of words (the number of requested words if no words were found in the trigram model, or the number of words required if trigram model had some matches, for example, if the user requested 5 predictions, and only 3 matches were found in the trigram model, then teh remaining 2 would be provided using the bigram model). 

If no words are found in the bigram model as well, or if they are less than the number required by the user, the app goes to the unigram model, and out of the 50 most probable words, randomly selects the required number of words and returns them, rather than returning the same words all the time to improve prediction. 

The words predicted are stemmed words, and might sometimes look mispelt (lucky as lucki).

