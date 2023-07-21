#!/bin/bash
#SBATCH --job-name=myarrayjob
#SBATCH --output=/home/users/%u/out/myarrayjob.%j.out
#SBATCH --error=/home/users/%u/err/myarrayjob.%j.err
#SBATCH -p normal
#SBATCH --ntasks=1
#SBATCH --mem=16GB
#SBATCH --cpus-per-task=1
#SBATCH --array=1-2
ml load system imagemagick/7.0.7-2
ml load system tesseract/5.1.0
ml load system ghostscript/9.53.2
file=$(ls /farmshare/learning/data/pdfs/*.pdf | sed -n ${SLURM_ARRAY_TASK_ID}p)
./farmshare/learning/scripts/scripts/ocr/parallel_pdf.sh -in $file

