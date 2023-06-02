#!/bin/bash
#SBATCH --job-name=pdf
#SBATCH --output=/home/users/%u/out/pdf.%j.out
#SBATCH --error=/home/users/%u/err/pdf.%j.err
#SBATCH -p hns
#SBATCH --array=0-16:2
#SBATCH -n 16

ml load system imagemagick/7.0.7-2
ml load system tesseract/5.1.0
ml load system ghostscript/9.53.2
file=$(ls /home/users/$USER/corpora/pdfTest/*.pdf | sed -n ${SLURM_ARRAY_TASK_ID}p)

for i in {0..2}; do
	srun -n 1 ./large_parallel_pdf.sh -in $file &
done

wait
