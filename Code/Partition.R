# load original data set, create a sample of training, validation and test sets.

## Load original data
twitter <- readLines("original/en_US.twitter.txt.bz2")
blogs <- readLines("original/en_US.blogs.txt.bz2")
news <- readLines("original/en_US.news.txt.bz2")

## Clean data of non-ASCII characters
twitter <- iconv(twitter,to = "ASCII",sub = "")
blogs <- iconv(blogs,to = "ASCII",sub = "")
news <- iconv(news,to = "ASCII",sub = "")


#------------------------------#
#---sample for training data---#
#------------------------------#

set.seed(1234) #for reproducibility
sizeSample <- 0.1 #only taking 10% of the data.

ts <- sample(length(twitter),length(twitter)*sizeSample)
twitSample <- twitter[ts]

ns <- sample(length(news),length(news)*sizeSample)
newsSample <- news[ns]

bs <- sample(length(blogs),length(blogs)*sizeSample)
blSample <- blogs[bs]

# save training data
writeLines(twitSample,"Train/twitter.txt")
writeLines(newsSample,"Train/news.txt")
writeLines(blSample,"Train/blogs.txt")


# rest of the data to create samples for testing and validation so that
# nothing common with training data in them
twitheldOut <- twitter[-ts]
newsHeldOut <- news[-ns]
blogsHeldOut <- blogs[-bs]


#------------------------------#
#--sample for validation data--#
#------------------------------#

set.seed(2345)
l <- length(twitheldOut)
ts <- sample(l,l*sizeSample/2)
twitValidation <- twitheldOut[ts]

l <- length(newsHeldOut)
ns <- sample(l,l*sizeSample/2)
newsValidation <- newsHeldOut[ns]

l <- length(blogsHeldOut)
bs <- sample(l,l*sizeSample/2)
blogsValidation <- blogsHeldOut[bs]

# save validation data
writeLines(twitValidation,"Validation/twitter.txt")
writeLines(newsValidation,"Validation/news.txt")
writeLines(blogsValidation,"Validation/blogs.txt")


# Data Left = Original- training - validation
twitheldOut <- twitheldOut[-ts]
newsHeldOut <- newsHeldOut[-ns]
blogsHeldOut <- blogsHeldOut[-bs]


#------------------------------#
#---sample for testing data----#
#------------------------------#

# test data
set.seed(4567)
l <- length(twitheldOut)
ts <- sample(l,l*sizeSample/2)
twitTest <- twitheldOut[ts]

l <- length(newsHeldOut)
ns <- sample(l,l*sizeSample/2)
newsTest <- newsHeldOut[ns]

l <- length(blogsHeldOut)
bs <- sample(l,l*sizeSample/2)
blogsTest <- blogsHeldOut[bs]

# saving test
writeLines(twitTest,"Test/twitter.txt")
writeLines(newsTest,"Test/news.txt")
writeLines(blogsTest,"Test/blogs.txt")