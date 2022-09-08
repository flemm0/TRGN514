#Setting working directory
setwd("~/Desktop/TRGN514/RStuff/Week3")

####Installation
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("Biostrings")

browseVignettes("Biostrings")



#Biostrings is an R package for analyzing and manipulating strings, it creates special objects for DNA, RNA, or Amino Acid strings which are treated differently than regular strings/characters in R, and they have associated methods with them.

library("Biostrings")

#You can print the possible letters for a nucleotide or amino acid
DNA_ALPHABET

AA_ALPHABET


#Create a random DNA sequence, right now the datatype is character
seq <- "AT-A-CAGCACGGAG--TTG"
type(seq)


#To convert the character to a DNAString object, use DNAString() function
dnastring <- DNAString(seq)
dnastring

head(dnastring)
tail(dnastring)


#You can also read in fasta or fastq files. Biostrings will convert them into DNAStrings automatically
#Below prints a tiny fastq file that I made up
system("cat ~/Desktop/TRGN514/RStuff/Week3/random.fastq")
####Reading in fastq file with readDNAStringSet()
random_fastq <- readDNAStringSet("~/Desktop/TRGN514/RStuff/Week3/random.fastq", format="fastq")
random_fastq



##Counting and Tabulating

#alphabetFrequency() tells you the proportion of each nucleotide in the DNAString
alphabetFrequency(random_fastq)

#You can pass in arguments so that it tells you proportions
#Can be useful for finding GC content
alphabetFrequency(random_fastq, baseOnly=TRUE, as.prob=TRUE)

#View the frequency of dinucleotide combinations
dinucleotideFrequency(random_fastq)



##Sequence Transformation

reverse(random_fastq)

complement(random_fastq)

reverseComplement(random_fastq)

#Translate DNA into amino acid sequence
translate(random_fastq)


#Biostring also allows you to store multiple sequences as a set
dna1 = "GGTTACTAC"
dna2 = "TCACAAGTA"
dna3 = "-CAGAAGTA"
dna4 = "AAAAAAAAA"

set = DNAStringSet(c(dna1, dna2, dna3, dna4))
set
#Access the first sequence of the set with [[]] brackets
set[[1]]

#Reverse complement of the whole set
reverseComplement(set)

alphabetFrequency(set, baseOnly=TRUE, as.prob=TRUE)



##String Matching and Alignments

pattern <- "AATTAATTAATTAATTAATTAATT"
subject <- "AA-TAACTAATTGTTTAATTCATT"

pa <- pairwiseAlignment(pattern=pattern, subject=subject)
pa
summary(pa)
mismatchTable(pa)



vmatchPattern(pattern=DNAString("AAT"), subject=pattern)
