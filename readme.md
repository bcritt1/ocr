# PDF to Text Conversion

This repo provides a shell script for the conversion of pdf files to plain-text for the purposes of higher-level text processing. This implementation utilizes the job array functionality of slurm to process all files in parallel. 
The *large parallel* implementation utilizes slurm stepped arrays for very large corpora that would require more than 1000 steps. The primary difference is to change the "n" value in the sbatch script to your number of files, to also change it in the "array" option, and to add the step size to this option as well. Basically, you can package n number of scripts to be sent to a single node, thus limiting the individual jobs sent to the scheduler. In the sample *large parallel* sbatch file, I indicated 16 files with steps of 2. So instead of 1 file being sent to one of 16 total nodes, 2 files will be sent to one of 8 total nodes. 

## File Overview

[parallel_pdf_convert.sh](parallel_pdf_convert.sh) utilizes imagemagick, tesseract, and ghostscript to OCR pdf files. Should also work on tiffs with light tweaking.

[parallel_pdf.sbatch](parallel_pdf.sbatch) invokes the shell script and runs as a slurm array. 

## Usage Instructions

### Moving Files

Before logging on to Farmshare, we'll want to get our corpus files in place. To do this we'll use a program called rsync. There are other options and more detail you can check out in our [docs](https://www.sherlock.stanford.edu/docs/storage/data-transfer/). Rsync, among other things, allows us to move files from a local system to a remote system. To use it, we
```bash
rsync -Ra /path/to/local/files SUNetID@rice.stanford.edu:/farmshare/learning/data/pdfs/
```

You'll need to change the path to local files (you can enter the terminal at the file location and ```pwd``` for this information) and SUNet ID before running. What the command does is run rsync on the local files we indicate, login to a remote machine with our credentials, and place the files at the location we indicate after the colon.

### Connecting to Farmshare

To connect to Farmshare
```
ssh yourSUNetID@rice.stanford.edu
```
in your terminal program of choice. 

### Downloading the Scripts

Now that we're on Farmshare, we can confirm our files made it here safely:
```bash
ls /farmshare/learning/data/pdfs/
```

will display the files that we transferred. If you don't see anything, there was likely an issue with the transfer.

Next, we need to get the files from this github repo:
```bash
git clone https://github.com/bcritt1/ocr.git
```

This will create a directory in your home space on Farmshare called "ocr" with all the files in this repository.

Because of the way this script is set up, we need to move our scripts into the directory with our pdfs.
```bash
mv ./ocr/* /farmshare/learning/scripts/
```

### Running the Script

We should be ready. Move into the pdf folder
```bash
cd /farmshare/learning/scripts/ocr/
```
and
```
sbatch pdf_convert.sbatch
```
to run the shell script. The script will take your pdfs, convert them to .tiff files, then convert those .tiff files to plain text. It will create /tiff and /ocr directories inside the directory with your pdfs and send the .tiff and 
.txt files there respectively. You may or may not need the .tiff files, but the .txt files can be used as inputs for just about any of the text processing sub-repos you find here. 
