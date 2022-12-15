# CMEE Coursework - week 1:

This README file contains details about the scripts from in-classwork and practicals for the first week.

## Description
More information about the shell scripts for coursework in **shell scripting** and scientific documents with **LaTeX** section can be found in the Computing Chapter of the book [The Mulitilingual Quantitative Biologist](https://mhasoba.github.io/TheMulQuaBio/notebooks/01-Unix.html)

## Language

Bash

## Dependencies

For some scripts (e.g. tiff2png.sh) in this directory requires [imagemagick](https://imagemagick.org/index.php), it can be installed by:

```bash
brew install imagemagick
```

For the scientific document editing, [LaTeX](https://www.latex-project.org/) installation is required by:

```bash
sudo perl install-tl -gui text
```

_The installation commands are used for MacOS, may varied with the different operating system._

## UNIX and LINUX

#### UnixPrac1.txt

<font size=2>**Summary:** Contains commands which manipulate the FASTA files.<br />
**Input:** */data/FASTA/***.fasta*<br />
**Output:** Results prints to terminal.<br />
**Running Instructions:** Or open the file, copy and paste the command into terminal<br />
```bash
bash UnixPrac1.txt
``` 
</font>


## Shell Scripting

#### boilerplate.sh:
<font size=2>**Summary:** Simple boilerplate for shell scripts.<br />
**Input:** n/a <br />
**Output:** Results prints to terminal.<br />
**Running Instructions:** 
```bash
bash boilerplate.sh
```
</font>


#### ConcatenateTwoFiles.sh:
<font size=2>**Summary:** Concatenates the contents of two files.<br />
**Input:** Two files to be concatenated followed by the new name of the output file which the script creates.<br />
**Output:** Concatenated file in results.<br />
**Running Instructions:** (valid *.txt filename)<br />
```bash
bash ConcatenateTwoFiles.sh
``` 
</font>

#### CountLines.sh:
<font size=2>**Summary:** Counts and displays the number of lines in a file.<br />
**Input:** */data/test.txt* <br />
**Output:** Results print to terminal.<br />
**Running Instructions:** valid *.txt filename
```bash
bash CountLines.sh
``` 
</font>

#### csvtospace.sh:
<font size=2>**Summary:** Substitutes the commas in a file with spaces.<br />
**Input:** 1 comma delimited file.<br />
**Output:** .txt version of the input file, saved into results.<br />
**Running Instructions:** Or any valid */data/Temperatures/***.csv*
```bash
bash csvtospace.sh ../data/Temperatures/1800.csv
``` 
</font>

#### MyExampleScript.sh:
<font size=2>**Summary:** Introduction to the $USER variable.<br />
**Input:** n/a<br />
**Output:** A welcome message prints out Hello $User(user name). to terminal.<br />
**Running Instructions:** 
```bash
bash MyExampleScript.sh
```
</font>

#### tabtocsv.sh:
<font size=2>**Summary:** Substitutes the tabs in a file for commas.<br />
**Input:** 1 File with tab separated values.<br />
**Output:** csv version of file in Results(separate to original).<br />
**Running Instructions:** vaild *.txt filename
```bash
bash tabtocsv.sh 
```
</font>

#### tiff2png.sh:
<font size=2>**Summary:** Converts .tiff files in directory where it is run to .png format and create a new file.<br />
**Dependencies:** imagemagick<br />
**Input:** n/a <br />
**Output:** .png versions of the files into the current directory<br />
**Running Instructions:** valid .tiff filename
```bash
bash tiff2png.sh
```
</font>


#### variables.sh
<font size=2>**Summary:** Illustrates the different types of shell variables.<br />
**Input:** (OPTIONAL) two random arguments (strings/numbers etc.) <br />
**Output:** Results prints to terminal <br />
**Running Instructions:** 
```bash
bash variables.sh (arg1 arg2)
```
</font>

## Scientific Documents with LaTeX

#### FirstExample.tex:
<font size=2>**Summary:** Example LaTeX code document<br />
**Running Instructions:** Source code only, ***Not to be run***. Used as an argument when CompileLaTeX.sh is called.<br /><br /></font>

#### FirstBiblio.bib:
<font size=2>**Summary:** Bibliography for example LaTeX document<br />
**Running Instructions:** Source code only, ***Not to be run***. Used as reference section when the FirstExample.tex code is compiled.<br /><br /></font>

#### CompileLaTeX.sh:
<font size=2>**Summary:** Compiles LaTeX with bibtex.<br />
**Input:** One argument, a latex source code file.<br />
**Output:** Produces the pdf of the latex source code and opens the pdf.<br />
**Running Instructions:** 
```bash
bash CompileLaTeX.sh FirstExample.tex
```
</font>


## Author & Contact

<font size=2>**Name:** ANQI WANG<br />
**Email:** aw222@ic.ac.uk</font>