## Next Word Prediction
The capstone project of the Data Science Specialisation conducted by John Hopkins University on Coursera. 

- The original code is given in the `code` directory.
- The shiny app's source is given in the `Next_Word_Prediction` folder.  
- The pitch for the app is given in the `presentation` folder.


For the code, to reproduce it you need to download the data in to the `original` directory (URL is given in that directory) and then run the scripts in the following order:

- First `Partition.R` which create different samples for the training, validation and test data set from the full data as well as some initial cleaning.
- Next `Tokenisation.R` to tokenise our training set (a 10% sample), stem it and create n-gram models for n = 1,2,3 (Unigram, Bigram and Trigram).
- Then run `Create n-grams dataTable.R` to convert n-gram models to `data.table` format.
- Next run, `Kneser-Ney Implementation.R` to compute the smoothed probabilities for the 3 n-gram models using Kneser-Ney Algorithm
- Then use `getNextWords.R` for the functions to predict next possible words based on our language models.

The training, test and validation folders in the `code` directory are empty, and will be populated after running `Parition.R` (which can be run successfully after downloading original data)


Here's the link to the two html files:
- [App Pitch and Algorithm](https://adromine.github.io/Next-Word-Prediction/Presentation/NextWordPrediction-rpubs.html)
- [Milestone1](https://adromine.github.io/Next-Word-Prediction/First%20Milestone/Milestone1.html)