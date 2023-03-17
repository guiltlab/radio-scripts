:: this script exectues sox -n stats on every file selected in foobar2000, by using the Run Service option
:: this is useful to detect bit padding, if a file is really 24 bit it will show 24/24, if it's padded with zeroes it will show 16/16
:: Run Service Path: "C:\path\soxpadding.bat" "%path%"
sox %1 -n stats
pause