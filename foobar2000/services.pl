# Google Artist + Album
http://www.google.com/search?q=$replace($replace(%album artist%+%album%, ,+),'&','%26')&ie=utf-8

# Discogs Album
"https://www.discogs.com/search/?type=release&q=$replace(*,*,%album artist%+%album%)"

# RYM
"https://rateyourmusic.com/search?searchterm=$if($strstr($lower(%album artist%),various),%artist%,%album artist%)"

# Find cover with Album Art Downloader
".\scripts\AlbumArtDownloader\AlbumArt.exe" /ar "$if($meta(album artist),$meta(album artist,0),%artist%)" /al "%album%" /mn 300 /mx 3000 /path "$replace(%_path%,%_filename_ext%,)big.jpg"

# MusicHoarders Cover
https://covers.musichoarders.xyz/?theme=dark&artist=$replace($replace([%album artist%], ,'%20'),'&','%26')&album=$replace($replace([%album%], ,'%20'),'&','%26')

# Audacity
"..\Software\Audacity\audacity.exe" "%path%"

# Check for wasted bits in FLAC files
".\encoders\fbits_batch.cmd" "$directory_path(%path%)"
# fbits_batch.cmd contents:
    cd encoders
    @echo off
    setlocal enableextensions enabledelayedexpansion
    :start
    if .%1==. goto end

    if exist "%~1\*" (
    for /r "%~1" %%f in (*.flac) do (
        set "_p=%%~f"
        rem call :scan "%%~f"
        call :scan
    )
    ) else (
    for %%f in (%1) do (
        set "_p=%%~f"
        rem call :scan "%%~f"
        call :scan
    )
    )
    shift
    goto :start

    :scan
    for %%i in ("!_p!") do set ext=%%~xi
    set waste=32
    set wastesum=0
    set count=0
    if exist "!_p!" if ."!ext!"==.".flac" (
    for /F %%i in ('metaflac --show-bps "!_p!"') do set bps=%%i
    flac -acs "!_p!" | findstr wasted_bits > "%temp%\_flactmp.txt"
    for /F "tokens=2,3" %%i in (%temp%\_flactmp.txt) do (
        set bits=%%i
        set bits=!bits:~12!
        if not "%%j"=="type=CONSTANT" (
        if !bits! LSS !waste! set waste=!bits!
        set /A wastesum=!wastesum!+!bits!
        set /A count=!count!+1
        )
    )
    set /A usedbits=!bps!-!waste!
    set /A averagewaste=!wastesum!
    if .!count!==. set count=0
    if not !count!==0 set /A averagewaste=!wastesum!/!count!
    set /A averagebits=!bps!-!averagewaste!
    if !averagewaste!==0 (
    echo OK
    ) else (
        echo !_p!: !averagebits!/!bps! bps average, highest frame using !usedbits! bps, !waste! bits wasted.
    )
    )
    del /f/q "%temp%\_flactmp.txt" >nul: 2>&1
    goto :eof

    :end
    pause

# Google Artist + Track
https://www.google.com/search?q=$replace($replace(%artist%+%title%, ,+),'&','%26')&ie=utf-8

# RED release page
"C:\Program Files\Mozilla Firefox\firefox.exe" "https://redacted.ch/torrents.php?artistname=$if($meta(%album artist%),$replace($meta(album artist,0),& ,, ,+),%album artist%)&groupname=$replace("%album%",& ,, ,+)&order_by=snatched&order_way=desc&group_results=1&action=advanced&searchsubmit=1"

# Orphan Hardlink removal
powershell.exe -noexit -ExecutionPolicy Bypass -File "..\dev\radio-scripts\find-delete-broken-hardlinks-v2.ps1"

# MP3 Tag
"..\Software\MP3Tag\Mp3tag.exe" "%path%"

# Export Embeddedd Cover in album dir to big.ext (if size > 200KB or height > 700px) or thumb.ext - requires cover utils component by marc2003
".\encoders\metaflac.exe"  "--export-picture-to=$directory_path(%path%)\$if($or($greater(%front_cover_bytes%,200000),$greater(%front_cover_height%,700)),big,thumb).$if($strcmp(%front_cover_format%,JPEG),jpg,$lower(%front_cover_format%))" "%path%"