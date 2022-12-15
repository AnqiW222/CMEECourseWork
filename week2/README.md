# CMEE Coursework - week 2:

This README file contains details about the scripts from in-classwork and practicals for the second week.

## Description
More information about the python scripts and programs for coursework in **Biological Computing in Python I** section can be found in the Computing Chapter of the book [The Mulitilingual Quantitative Biologist](https://mhasoba.github.io/TheMulQuaBio/notebooks/05-Python_I.html)

## Language

Python

## Dependencies
For some scripts (e.g. debugme.py) in this directory requires [pdb](https://docs.python.org/3/library/pdb.html), it can be installed by:

```bash
pip3 install pdb
```

For the python program (e.g. align_seqs.py) in this directory requires [pandas](https://pandas.pydata.org) installation is required by:

```bash
pip3 install --update pip
pip3 install pandas
```

_The installation commands are used for MacOS, may varied with the different operating system._

## Individual Practicals -- Python scripts

#### align_seqs.py
<font size=2>**Summary:** Find the best alignment for two specific DNA sequences such that they have as many bases matching as possible.<br />
**Input:** n/a <br />
**Dependencies:** pandas, sys, io <br />
**Output:** Result saves to */results/align_seqs_results.txt*.<br />
**Running Instructions:** 
```bash
python3 align_seqs.py 
```
</font>

#### basic_csv.py:
<font size=2>**Summary:** Using the csv package. <br />
**Input:** n/a <br />
**Dependencies:** csv <br />
**Output:** Result prints to terminal <br />
**Running Instructions:** 
```bash
python3 basic_csv.py 
```
</font>


#### basic_io1.py:
<font size=2>**Summary:** Example of importing and exporting data in python; Prints lines from a file. <br />
**Input:** n/a <br />
**Output:** Result prints in terminal. <br />
**Running Instructions:** 
```bash
python3 basic_io1.py 
```
</font>

#### basic_io2.py:
<font size=2>**Summary:** Save data to a file.<br />
**Input:** n/a <br />
**Output:** Result saves to */sandbox/test.txt*. <br />
**Running Instructions:** 
```bash
python3 basic_io2.py 
```
</font>

#### basic_io3:
<font size=2>**Summary:** Store/save an object for later use. <br />
**Input:** 1 n/a <br />
**Dependencies:** pickle <br />
**Output:** Result saves to */sandbox/testp.p*. <br />
**Running Instructions:** 
```bash
python3 basic_io3.py 
```
</font>

#### boilerplate.py:
<font size=2>**Summary:** Template for python programs.<br />
**Input:** n/a <br />
**Dependencies:** sys <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
python3 boilerplate.py 
```
</font>

#### cfexercises1.py:
<font size=2>**Summary:** Introducion of conditionals and functions. <br />
**Input:** n/a <br />
**Dependencies:** sys <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
python3 cfexercises1.py 
```
</font>

#### cfexercises2.py:
<font size=2>**Summary:** Examples of loops and conditionals combined. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
python3 cfexercises2.py 
```
</font>

#### control_flow.py:
<font size=2>**Summary:** Create various functions which analyse numbers using control flow tools. <br />
**Input:** n/a <br />
**Dependencies:** sys <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
python3 control_flow.py 
```
</font>

#### debugme.py:
<font size=2>**Summary:** Example of buggy function for debugging.<br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
python3 debugme.py 
```
</font>

#### dictionary.py:
<font size=2>**Summary:** Populate a dictionary derived from taxa so that it maps order names to sets of taxa. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
python3 dictionary.py 
```
</font>

#### lc1.py:
<font size=2>**Summary:** Using list comprehensions and loops to make lists from bird data. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
python3 lc1.py 
```
</font>

#### lc2.py:
<font size=2>**Summary:** Use list comprehensions and loops to make lists from rainfall data. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
python3 lc2.py 
```
</font>

#### loops.py:
<font size=2>**Summary:** Examples of for and while loops. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
python3 loops.py 
```
</font>

#### MyExampleScript.py:
<font size=2>**Summary:** Learning to run python scripts. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
python3 MyExampleScript.py 
```
</font>

#### oaks_debugme.py:
<font size=2>**Summary:** Understand and debug Oaks_debugme.py; write and modify doctests appropriately. <br />
**Input:** n/a <br />
**Dependencies:** csv, sys, doctest <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
python3 oaks_dubugme.py 
```
</font>

#### oaks.py:
<font size=2>**Summary:** Examples of comprehensions. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
python3 oaks.py 
```
</font>

#### scope.py:
<font size=2>**Summary:** Examples of variable scope and global variables. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
python3 scope.py 
```
</font>

#### sysargv.py:
<font size=2>**Summary:** Explains sys.argv in a practical way. <br />
**Input:** Various Arguments <br />
**Dependencies:** sys <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
python3 sysargv.py 
```
</font>

#### test_control_flow.py:
<font size=2>**Summary:** Introduction of unit testing, contains simple tests for each function embedded in the docstring; functions which exemplify the use of control statements. <br />
**Input:** n/a <br />
**Dependencies:** sys, doctest <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:**
```bash
python3 test_control_flow.py -v 
```
</font>

#### tuple.py:
<font size=2>**Summary:** Print out items from a tuple. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:**
```bash 
python3 tuple.py 
```
</font>

#### using_name.py:
<font size=2>**Summary:** Example of use of __name__=='__main__' and using_name <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
python3 using_name.py 
```
</font>

## Groupwork Practicals -- 02_Booming_Bonobos
Cover 3 groupwork practicals:
1. [Align DNA sequences](https://mhasoba.github.io/TheMulQuaBio/notebooks/05-Python_I.html#groupwork-practical-on-align-dna-sequences)
2. [Align DNA sequences2](https://mhasoba.github.io/TheMulQuaBio/notebooks/05-Python_I.html#groupwork-practical-on-align-dna-sequences-2)
3. [Missing oaks problem](https://mhasoba.github.io/TheMulQuaBio/notebooks/05-Python_I.html#groupwork-practical-on-missing-oaks-problem) 

#### align_seqs_fasta.py:
<font size=2>**Summary:** Take two sequences from two fasta files given as arguments, compare alignments of the sequences and print the alignment that gives the most base matches to a new file called *best_match.txt*. <br />
**Input:** n/a <br />
**Output:** Result saves to */results/best_match.txt*.<br />
**Running Instructions:** 
```bash
python3 align_seqs_fasta.py
```
</font>

#### align_seqs_better.py
<font size=2>**Summary:** Save the best alignment of two DNA sequences, taking any two fasta sequences to be aligned as input. <br />
**Input:** Files from */data/fasta/***.fasta* <br />
**Output:** Result saves to */results/align_seqs_better*.<br />
**Running Instructions:** 
```bash
python3 align_seqs_better.py ../data/fasta/407228326.fasta ../data/fasta/407228412.fasta
```
</font>

#### oaks_debugme_groupwork.py
<font size=2>**Summary:** This prints species names for trees from an external .CSV file and searches for Oak trees (Quercus spp.). The Oak trees are then written to an output file in the results directory called *JustOaksData.csv* <br />
**Input:** n/a <br />
**Output:** Result saves to */results/JustOaksData.csv*.<br />
**Running Instructions:** 
```bash
python3 oaks_debugme_groupwork.py 
```
</font>


## Author & Contact

<font size=2>**Name:** ANQI WANG<br />
**Email:** aw222@ic.ac.uk</font>