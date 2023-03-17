#!/bin/bash

cd /mnt/r/Radio/everything-except-OST
find . -links 2 -type f > /mnt/r/Radio/reports/report-unassigned-songs.txt