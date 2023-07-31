# PDF to Text Conversion

This repo provides a shell script for the conversion of pdf files to plain-text for the purposes of higher-level text processing. This implementation utilizes the job array functionality of slurm to process all files in parallel. 
The *large parallel* implementation utilizes slurm stepped arrays for very large corpora that would require more than 1000 steps. The primary difference is to change the "n" value in the sbatch script to your number of files, to also change it in the "array" option, and to add the step size to this option as well. Basically, you can package n number of scripts to be sent to a single node, thus limiting the individual jobs sent to the scheduler. In the sample *large parallel* sbatch file, I indicated 16 files with steps of 2. So instead of 1 file being sent to one of 16 total nodes, 2 files will be sent to one of 8 total nodes. 

## File Overview

[parallel_pdf_convert.sh](parallel_pdf_convert.sh) utilizes imagemagick, tesseract, and ghostscript to OCR pdf files. Should also work on tiffs with light tweaking.

[parallel_pdf.sbatch](parallel_pdf.sbatch) invokes the shell script and runs as a slurm array. 

## Usage Instructions

### Connecting to Farmshare

To connect to Farmshare
```
ssh yourSUNetID@rice.stanford.edu
```
in your terminal program of choice. 

### Downloading the Scripts

Now that we're on Farmshare, let's move to the learning environment for this lesson:
```bash
ls /farmshare/learning/scripts/scripts/ocr
```
You can check out the files with ```ls```.

### Running the Script

We should be ready. 

```
sbatch parallel_pdf.sbatch
```
to run the shell script. The script will take your pdfs, convert them to .tiff files, then convert those .tiff files to plain text. It will create /tiff and /ocr directories inside the directory with your pdfs and send the .tiff and 
.txt files there respectively. You may or may not need the .tiff files, but the .txt files can be used as inputs for just about any of the text processing sub-repos you find here. 
