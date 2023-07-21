#!/bin/bash
#SBATCH --job-name=pdf
#SBATCH --output=/home/%u/out/pdf.%j.out
#SBATCH --error=/home/%u/err/pdf.%j.err
#SBATCH -p normal
#SBATCH --array=0-16:2
#SBATCH -n 16

ml load system imagemagick/7.0.7-2
ml load system tesseract/5.1.0
ml load system ghostscript/9.53.2
file=$(ls /farmshare/learning/data/pdfs/*.pdf | sed -n ${SLURM_ARRAY_TASK_ID}p)

for i in {0..2}; do
	srun -n 1 ./farmshare/learning/scripts/scripts/ocr/large_parallel_pdf.sh -in $file &
done

wait
