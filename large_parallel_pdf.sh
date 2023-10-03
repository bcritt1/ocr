#!/bin/bash

DIR=/farmshare/learning/data/pdfs/
FILES=/farmshare/learning/data/pdfs/*.pdf
OUT=/scratch/users/$USER/outputs/ocr/
for f in $FILES;
do
  	tiff=${f%.*}.tiff
        convert -density 400 $f -depth 8 -strip -background white -alpha off $tiff
        ocr=${f%.*}_ocr
        tesseract $tiff $ocr
done
randnum="$RANDOM"
mkdir $DIR/"${randnum}_ocr"
mkdir $DIR/"${randnum}_tiff"
mv $DIR/*_ocr.txt $DIR/${randnum}"_ocr"
mv $DIR/*.tiff $DIR/${randnum}"_tiff"
