Next Word Prediction
========================================================
author: Enelen Brinshaw
date: 
autosize: true


Word Prediction App
========================================================

An app that takes as input a string and predicts possible next words ([stemmed](https://en.wikipedia.org/wiki/Stemming) words are predicted).

The user can select upto 50 words for prediction.

<p style="text-align:center;">
<img src = "screenshot.JPG" alt="App Screenshot">
</p>

Model Creation
=======================================================
- A 10% sample was taken from a [text corpus](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip) consisting of data from twitter, news and blogs.
- The text was cleaned to remove non-ASCII characters
- Sample was then tokenised and stemmed using the `quanteda` package, removing numbers, spaces, punctuations, hypens, twitter symbols and profanity using this [list of bad words used by Google](http://fffff.at/googles-official-list-of-bad-words/)
- 3 n-gram models (n = 1,2,3) were created, again using `quanteda`.
- The 3 n-gram models were converted to 3 different `data.tables`, with each word of the n-gram in its own column (which were keyed for faster access) and a column for the count of the n-gram in the data. This helped speed up the later process as well as save memory.
- Kneser-Ney smoothing was then used to assign probabilities to the different n-grams. More details about this alogrithm can be found [here](http://www.foldl.me/2014/kneser-ney-smoothing/) and [here](https://west.uni-koblenz.de/sites/default/files/BachelorArbeit_MartinKoerner.pdf)


App functioning
========================================================

The app works in the following manner:
- Takes an input from the user, tokenises and stems it in the same manner used earlier, and then retrieves the last two words.
- The last two words are used to search for matching trigrams, and if any found, the most probable ones are returned (depending upon user's desire)
- If no predictions are found in the trigram model, or not enough predictions (depending upon user's request) are found, then we search for matches in the bigram model in the same manner.
- At last, the unigram model is used, which does nothing but returns the required number of words randomly from the 50 most probably words in the unigram model. The randomness was introduced to create some variety in the predictions of unigram model.


App performance and future
=======================================================




```r
require(rbenchmark)
benchmark(nextWord("I am going to the"))[,2:5]
```

```
  replications elapsed relative user.self
1          100    0.71        1      0.62
```
As can be seen, the app performs near instantaneously when run locally. When run on the Shiny server, the network latency can slow the process.

In future, the performance can be improved by:
- Adding data from books, movie subtitles, etc.
- Building parts-of-speech models


