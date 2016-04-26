# Now create corpus of training sample, tokenise and stem it.

require(quanteda)
train <- corpus(textfile("Train/*.txt"))

# Tokenise our corpus, removing puntuation, numbers,
# hyphens (combining compound words into single word),
# and twitter symbols like @#
tokens <- tokenize(x = toLower(train),
                   removePunct = TRUE,
                   removeTwitter = TRUE,
                   removeNumbers = TRUE,
                   removeHyphens = TRUE,
                   verbose = TRUE)
				   


# Deal with profanity, remove them essentially from the corpus				   
profane <- readLines("Profanity/google bad words.txt")

# tokenising list of bad words since without it, 
# the next step hangs up the computer for some reason
profanity <- tokenize(profane,
                      removePunct = TRUE,
                      removeSeparators = TRUE,
                      removeHyphens = TRUE,
                      simplify = TRUE)

save(profanity,file = "profanityTokens.Rdata") # save for later use
# load("profanityTokens.Rdata") # if not loaded

tokenNoProf <- removeFeatures(tokens,profanity) # remove profane words
# Instead of removing we could have also replaced them with some placeholder
# like BADWORD or PROFANITY or #@!*& (grawlix), how to do is described ahead


# stem all tokens before creating frequency matrix to save effort later
# when creating different n-gram models, and stemming time after time
# also, stemming during creation of n-gram models, first combines words
# into grams, and then applies stemming, which results in stemming being applied
# to the last word in the gram only, for example "players_charmfully_winning"
# would be first created in n-gram model and then when stemming is applied to it, it would
# only apply on winning, not on players or charmfully.
# this is prevented by applying stemming on existing tokens before hand

stemTokens <- wordstem(tokenNoProf,language = "english")

# Create n-grams for n = 2,3
bigram <- ngrams(stemTokens,n = 2)
trigram <- ngrams(stemTokens,n = 3)

# Create frequency matrix for unigram, bigram and trigram
dfm1 <- dfm(stemTokens,toLower = FALSE) # since already lowered before
dfm2 <- dfm(bigram,toLower = FALSE)
dfm3 <- dfm(trigram,toLower = FALSE)


# trim the DFMs for count less than 2, essentially reducing
# file size from hundreds of MBs to less than 50MB for each.
dfmr1 <- trim(dfm1,2)
dfmr2 <- trim(dfm2,2)
dfmr3 <- trim(dfm3,2)

# save them before doing anything else!
save(dfmr1,dfmr2,dfmr3,file = "Reduced DFMs.Rdata")


###---------------------------------------###
###----profanity-placeholder-text---------###
###---------------------------------------###

# In case a placeholder was desired, first create a dictionary of profanity
# ProfanityDict <- dictionary(x = list(Profanity = profane)) 
# change list heading `Profanity` to any placeholder text
# Now supply this ProfanityDict as the `thesaurus` argument to `dfm` command
# Example
# dfm2 <- dfm(bigram,thesaurus = ProfanityDict) and so on
# Need to however stem profanity list first.
