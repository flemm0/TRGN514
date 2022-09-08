# Setting working directory
setwd("~/Desktop/TRGN514/RStuff/Week3")

#### Installation
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("Biostrings")

browseVignettes("Biostrings")

# Biostrings is an R package for analyzing and manipulating strings, it creates special objects for DNA, RNA, or Amino Acid strings which are treated differently than regular strings/characters in R, and they have associated methods with them.


# Load library
library("Biostrings")

# Create a random DNA sequence, right now the datatype is character
seq <- "AT-A-CAGCACGGAG--TTG"
type(seq)

# Convert to DNAString object
dnastring <- DNAString(seq)
dnastring

head(dnastring)
tail(dnastring)



# You can also read in fasta or fastq files. Biostrings will convert them into DNAStrings automatically.
# Below prints a tiny fastq file that I made up
system("cat ~/Desktop/TRGN514/RStuff/Week3/random.fastq")

#### Reading in fastq file with readDNAStringSet()
random_fastq <- readDNAStringSet("~/Desktop/TRGN514/RStuff/Week3/random.fastq", format="fastq")
random_fastq



## Counting and Tabulating

# alphabetFrequency() tells you the proportion of each nucleotide in the DNAString
# Can be useful for finding GC content
alphabetFrequency(random_fastq, baseOnly=TRUE, as.prob=TRUE)

# View the frequency of nucleotide combinations
dinucleotideFrequency(random_fastq)
trinucleotideFrequency(random_fastq)


## Sequence Transformation

reverse(random_fastq)

complement(random_fastq)

reverseComplement(random_fastq)

# Translate DNA into amino acid sequence
translate(random_fastq)


# Biostrings also allows you to store multiple sequences as a set
dna1 = "GGTTACTAC"
dna2 = "TCACAAGTA"
dna3 = "-CAGAAGTA"
dna4 = "AAAAAAAAA"

set = DNAStringSet(c(dna1, dna2, dna3, dna4))
set

# Reverse complement of the whole set
reverseComplement(set)

alphabetFrequency(set, baseOnly=TRUE, as.prob=TRUE)



## String Matching and Alignments

pattern <- "AATTAATTAATTAATTAATTAATT"
subject <- "AA-TAACTAATTGTTTAATTCATT"

pa <- pairwiseAlignment(pattern=pattern, subject=subject)
pa
# Print summary statistics on the alignment
summary(pa)
mismatchTable(pa)


# Search for specific pattern in a DNAString
vmatchPattern(pattern=DNAString("AAT"), subject=pattern)
