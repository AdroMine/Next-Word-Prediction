# Take as input any string, and get next words as output

# Get last two words of any string after tokenising and stemming the words
getlast2words <- function(str){
     words <- tokenize(x = toLower(str),
                       removePunct = TRUE,
                       removeTwitter = TRUE,
                       removeNumbers = TRUE,
                       removeHyphens = TRUE)
     wordstem(rev(rev(words[[1]])[1:2]),language = "english")
}

# Get the next words, main function that will be used, calls other functions
nextWord <- function(str,n = 5){
     words <- getlast2words(str)
     w1 <- words[1]
     w2 <- words[2]
	 # got the last two words
     pwords <- triWords(w1,w2,n) 
     # triwords searches in trigram for next words
     # if no word found in triwords then recurses to bigram.
     pwords
}

# search in trigram and return required number or words
triWords <- function(w1,w2,n = 5){
     # get words from trigram
     pwords <- ngram3[.(w1,w2)][order(-Prob)]
     if(any(is.na(pwords))) # if no words in trigram go to bigram
          return(biWords(w2,n))
     if(nrow(pwords)>n) # if words found, and as many as required
          return(pwords[1:n,wor3])
     # not enough words, so search for some from bigram too
     count <- nrow(pwords)
     bwords <- biWords(w2,n)[1:(n-count)]
     return(c(pwords[,wor3],bwords))
}

# search for words in bigram, same as trigram function
biWords <- function(w1,n = 5){
     pwords <- ngram2[w1][order(-Prob)]
     if(any(is.na(pwords)))
          return(uniWords(n))
     if(nrow(pwords)>n)
          return(pwords[1:n,wo2])
     # not enough words, so send some unigram words as well
     count <- nrow(pwords)
     unWords <- uniWords(n)[1:(n-count)]
     return(c(pwords[,wo2],unWords))
}

# use the unigram, rather than sending the same words all the time
# send random words from the top fifty.
uniWords <- function(n = 5){
     sample(unigram[,w1],size = n)
}

