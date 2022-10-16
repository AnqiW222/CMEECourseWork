# CMEE Coursework - week 1:

This README file contains details about the scripts from in-classwork and practicals for the first week.

## Description
More information about the shell scripts for coursework in **shell scripting** and scientific documents with **LaTeX** section can be found in the Computing Chapter of the book [The Mulitilingual Quantitative Biologist](https://mhasoba.github.io/TheMulQuaBio/intro.html)

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
**Input:** FASTA files from data.<br />
**Output:** Results prints to terminal.<br />
**Running Instructions:** bash UnixPrac1.txt (Or open the file, copy and paste the command into terminal)<br /><br /></font>


## Shell Scripting

#### boilerplate.sh:
<font size=2>**Summary:** Simple boilerplate for shell scripts.<br />
**Input:** n/a <br />
**Output:** Results prints to terminal.<br />
**Running Instructions:** bash boilerplate.sh <br /><br /></font>


#### ConcatenateTwoFiles.sh:
<font size=2>**Summary:** Concatenates the contents of two files.<br />
**Input:** Two files to be concatenated followed by the new name of the output file which the script creates.<br />
**Output:** Concatenated file in results.<br />
**Running Instructions:** bash ConcatenateTwoFiles.sh (valid *.txt filename)<br /><br /></font>

#### CountLines.sh:
<font size=2>**Summary:** Counts and displays the number of lines in a file.<br />
**Input:** 1 File (e.g. test.txt in data).<br />
**Output:** Results print to terminal.<br />
**Running Instructions:** bash CountLines.sh (valid *.txt filename)</font>

#### csvtospace.sh:
<font size=2>**Summary:** Substitutes the commas in a file with spaces.<br />
**Input:** 1 comma delimited file.<br />
**Output:** .txt version of the input file, saved into results.<br />
**Running Instructions:** bash csvtospace.sh ../data/Temperatures/1800.csv (Or any valid *.csv filename from ../data/Temperatures/)<br /><br /></font>

#### MyExampleScript.sh:
<font size=2>**Summary:** Introduction to the $USER variable.<br />
**Input:** n/a<br />
**Output:** A welcome message prints out Hello $User(user name). to terminal.<br />
**Running Instructions:** bash MyExampleScript.sh<br /><br /></font>

#### tabtocsv.sh:
<font size=2>**Summary:** Substitutes the tabs in a file for commas.<br />
**Input:** 1 File with tab separated values.<br />
**Output:** csv version of file in Results(separate to original).<br />
**Running Instructions:** bash tabtocsv.sh (vaild *.txt filename)<br /><br /></font>

#### tiff2png.sh:
<font size=2>**Summary:** Converts .tiff files in directory where it is run to .png format and create a new file.<br />
**Input:** n/a <br />
**Output:** .png versions of the files into the current directory<br />
**Running Instructions:** bash tiff2png.sh (valid .tiff filename)<br />
**Dependencies:** imagemagick<br /><br /></font>

#### variables.sh
<font size=2>**Summary:** Illustrates the different types of shell variables.<br />
**Input:** (OPTIONAL) two random arguments (strings/numbers etc.). <br />
**Output:** Results prints to terminal <br />
**Running Instructions:** bash variables.sh arg1 arg2 OR bash variables.sh.<br /><br /></font>

## Scientific Documents with LaTeX

#### FirstBiblio.bib:
<font size=2>**Summary:** Bibliography for example LaTeX document<br />
**Running Instructions:** Not to be run. Source code only. Is referenced when the FirstExample.tex code is compiled.<br /><br /></font>

#### FirstExample.tex:
<font size=2>**Summary:** Example LaTeX code document<br />
**Running Instructions:** Not to be run. Source code only. Is used as an argument when CompileLaTeX.sh is called.<br /><br /></font>

#### CompileLaTeX.sh:
<font size=2>**Summary:** Compiles LaTeX with bibtex.<br />
**Input:** One argument, a latex source code file.<br />
**Output:** Produces the pdf of the latex source code and opens the pdf.<br />
**Running Instructions:** bash CompileLaTeX.sh FirstExample.tex<br /><br /></font>

## Author & Contact

<font size=2>**Name:** ANQI WANG<br />
**Email:** aw222@ic.ac.uk</font>