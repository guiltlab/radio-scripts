#!/bin/bash

cd /mnt/r/Radio/
cd everything
find . -links 1 -type f -not \( -name "*.jpg" -o -name "*.png" \) | tee /mnt/r/Radio/reports/report-everything.txt
echo "report for everything generated"
sleep 10
cd ../everything-except-OST/
find . -links 1 -type f | tee /mnt/r/Radio/reports/report-everything-except-OST.txt
echo "report for everything-except-OST generated"
sleep 10
cd ../genre-based/
find . -links 1 -type f | tee /mnt/r/Radio/reports/report-genre-based.txt
echo "report for genre-based generated"
sleep 10
cd ../region-based/
find . -links 1 -type f | tee /mnt/r/Radio/reports/report-region-based.txt
echo "report for region-based generated"
sleep 10
cd ../soundtracks/
find . -links 1 -type f | tee /mnt/r/Radio/reports/report-soundtracks.txt
echo "report for soundtracks generated"
sleep 10
cd ../decades/
find . -links 1 -type f | tee /mnt/r/Radio/reports/report-decades.txt
echo "report for decades generated"
sleep 10
cd ../new/
find . -links 1 -type f | tee /mnt/r/Radio/reports/report-new.txt
echo "report for new music generated"