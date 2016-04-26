# Convert to data.table format the 3 n-grams

require(quanteda)

# load quanteda DFMs for n-grams (1-3)
load("Reduced DFMs.Rdata")
# loaded as dfmr1,dfmr2,dfmr3

# reduce them to named vectors gram1,2,3
gram1 <- colSums(dfmr1)
gram2 <- colSums(dfmr2)
gram3 <- colSums(dfmr3)

# clean these to remove words with only _ (there are some somehow)
gram1 <- gram1[-grep("^[^a-z]",names(gram1),perl = TRUE)]
gram2 <- gram2[-grep("^[^a-z]",names(gram2),perl = TRUE)]
gram3 <- gram3[-grep("^[^a-z]",names(gram3),perl = TRUE)]

# now to create data.tables

require(data.table)

# For unigrams
ngram1 <- data.table(w1=names(gram1),Count = gram1)

# For bigrams 
     # first separate words (they are concatenated by '_')
bgramWords <- strsplit(names(gram2),"_",fixed = TRUE)
fw <- sapply(bgramWords,'[[',1)
sw <- sapply(bgramWords,'[[',2)
ngram2 <- data.table(wo1=fw,wo2=sw,Count = gram2)


# For trigrams
     # first separate words (separated by '_')
triwords <- strsplit(names(gram3),"_",fixed = TRUE)
fw <- sapply(triwords,'[[',1)
sw <- sapply(triwords,'[[',2)
tw <- sapply(triwords,'[[',3)
ngram3 <- data.table(wor1 = fw, wor2 = sw, wor3 = tw, Count = gram3)

# Set keys for faster searching
setkey(ngram1,w1)
setkey(ngram2,wo1,wo2)
setkey(ngram3,wor1,wor2,wor3)

save(ngram1,ngram2,ngram3, file = "n-grams DT Reduced.Rdata")

# Data.Tables not only speed up the probability and smoothing calculation
# by orders of magnitude (I am assuming orders of magnitudes, because the alternatives
# never finished computing, whereas the data.table versions computed within 10 seconds on
# my 10% sample
# Also the data.tables take less memory. The 3 n-gram models combined take 35-40MB, whereas
# the named vectors took 40 MB for each n-gram! I believe this is possibly due to the fact
# that we have separated words, and now need not store the concatenator '_' for each gram
# removing millions of '_' storage. 
# Or mabye data.table is just better at storing.
