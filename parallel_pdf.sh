#!/bin/bash

# Adapted from Andrew Aklaghi's script here: https://programminghistorian.org/en/lessons/OCR-and-Machine-Translation

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

mkdir -p $OUT"/ocr"
mkdir -p $OUT"/tiff"
mv $DIR/*_ocr.txt $OUT/ocr
mv $DIR/*.tiff $OUT/tiff
