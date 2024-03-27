// NOT actually perl, only for display formatting reasons

// SCRIPT
    // ARTIST: Find "feat" and move artist to ARTIST field

        // one-liner
        $if($strstr($lower([%title%]),'('with),$puts(featuring,'('with)$puts(matchpos,$strstr($lower([%title%]),'('with)))$if($strstr($lower([%title%]),feat),$puts(featuring,feat)$puts(matchpos,$strstr($lower([%title%]),feat)))$if($strstr($lower([%title%]),feat.),$puts(featuring,feat.)$puts(matchpos,$strstr($lower([%title%]),feat.)))$if($strstr($lower([%title%]),'('feat.),$puts(featuring,'('feat.)$puts(matchpos,$strstr($lower([%title%]),'('feat.)))$if($strstr($lower([%title%]),featuring),$puts(featuring,featuring)$puts(matchpos,$strstr($lower([%title%]),featuring)))$if($strstr($lower([%title%]),'('featuring),$puts(featuring,'('featuring)$puts(matchpos,$strstr($lower([%title%]),'('featuring)))$if($get(matchpos),[%artist%;]$trim($replace($replace($substr(%title%,$get(matchpos),$len(%title%)),')',),$get(featuring),)),[%artist%])

        // main code
        $if($strstr($lower([%title%]),'('with),$puts(featuring,'('with)
        $puts(matchpos,$strstr($lower([%title%]),'('with))
        )
        $if($strstr($lower([%title%]),feat),$puts(featuring,feat)
        $puts(matchpos,$strstr($lower([%title%]),feat))
        )
        $if($strstr($lower([%title%]),feat.),$puts(featuring,feat.)
        $puts(matchpos,$strstr($lower([%title%]),feat.))
        )
        $if($strstr($lower([%title%]),'('feat.),$puts(featuring,'('feat.)
        $puts(matchpos,$strstr($lower([%title%]),'('feat.))
        )
        $if($strstr($lower([%title%]),featuring),$puts(featuring,featuring)
        $puts(matchpos,$strstr($lower([%title%]),featuring))
        )
        $if($strstr($lower([%title%]),'('featuring),$puts(featuring,'('featuring)
        $puts(matchpos,$strstr($lower([%title%]),'('featuring))
        )

        $if($get(matchpos),
        [%artist%;]
        $trim(
            $replace(
                $replace(
                    $substr(%title%,$get(matchpos),$len(%title%)),')',)
                    ,$get(featuring),
                    )
                    ),
        [%artist%]
        )

    // TITLE: Find "feat" and remove artist from TITLE

        // one-liner
        $if($strstr($lower([%title%]),'('with),$puts(featuring,'('with)$puts(matchpos,$strstr($lower([%title%]),'('with)))$if($strstr($lower([%title%]),feat),$puts(featuring,feat)$puts(matchpos,$strstr($lower([%title%]),feat)))$if($strstr($lower([%title%]),feat.),$puts(featuring,feat.)$puts(matchpos,$strstr($lower([%title%]),feat.)))$if($strstr($lower([%title%]),'('feat.),$puts(featuring,'('feat.)$puts(matchpos,$strstr($lower([%title%]),'('feat.)))$if($strstr($lower([%title%]),featuring),$puts(featuring,featuring)$puts(matchpos,$strstr($lower([%title%]),featuring)))$if($strstr($lower([%title%]),'('featuring),$puts(featuring,'('featuring)$puts(matchpos,$strstr($lower([%title%]),'('featuring)))$if($get(matchpos),$trim($substr(%title%,0,$sub($get(matchpos),1))),[%title%])

        // main code
        $if($strstr($lower([%title%]),'('with),$puts(featuring,'('with)
        $puts(matchpos,$strstr($lower([%title%]),'('with))
        )
        $if($strstr($lower([%title%]),feat),$puts(featuring,feat)
        $puts(matchpos,$strstr($lower([%title%]),feat))
        )
        $if($strstr($lower([%title%]),feat.),$puts(featuring,feat.)
        $puts(matchpos,$strstr($lower([%title%]),feat.))
        )
        $if($strstr($lower([%title%]),'('feat.),$puts(featuring,'('feat.)
        $puts(matchpos,$strstr($lower([%title%]),'('feat.))
        )
        $if($strstr($lower([%title%]),featuring),$puts(featuring,featuring)
        $puts(matchpos,$strstr($lower([%title%]),featuring))
        )
        $if($strstr($lower([%title%]),'('featuring),$puts(featuring,'('featuring)
        $puts(matchpos,$strstr($lower([%title%]),'('featuring))
        )

        $if($get(matchpos),
        $trim(
            $substr(%title%,0,$sub($get(matchpos),1))
            ),
        [%title%]
        )

    // PLAYLIST: Add Jungle / modern funk playlist if applicable
        // jungle
            // one-liner
                $if($strstr($lower(%genre%),jungle),$if($not($or($strstr($lower(%genre%),hardcore),$strstr($lower(%EXCLUDE%),jungle))),$if($not($strstr($lower(%PLAYLIST%),jungle)),[%PLAYLIST%; ]Jungle,[%PLAYLIST%])),$if($strstr($lower(%PLAYLIST%),jungle),$replace([%PLAYLIST%],Jungle, ),[%PLAYLIST%]))
            // main code
                $if($strstr($lower(%genre%),jungle),
                    $if($not($or(
                                $strstr($lower(%genre%),hardcore),
                                $strstr($lower(%EXCLUDE%),jungle)
                                )
                            ),
                        $if($not($strstr($lower(%PLAYLIST%),jungle)),
                            [%PLAYLIST%; ]Jungle,
                            [%PLAYLIST%]
                            )
                    ),
                    $if($strstr($lower(%PLAYLIST%),jungle),
                        $replace([%PLAYLIST%],Jungle, ),
                        [%PLAYLIST%]
                    )
                )
        // modern funk
            // one-liner
                $if($strstr($lower(%genre%),modern funk),$if($not($strstr($lower(%PLAYLIST%),modern funk)),[%PLAYLIST%; ]Modern Funk,[%PLAYLIST%]),$if($and($strstr($lower(%PLAYLIST%),modern funk),$not($strstr($lower(%genre%),funk))),$replace([%PLAYLIST%],Modern Funk, ),[%PLAYLIST%]))
            // main code
                $if($strstr($lower(%genre%),modern funk),
                    $if($not($strstr($lower(%PLAYLIST%),modern funk)),
                        [%PLAYLIST%; ]Modern Funk,[%PLAYLIST%]),
                        $if($and($strstr($lower(%PLAYLIST%),modern funk),$not($strstr($lower(%genre%),funk))),
                            $replace([%PLAYLIST%],Modern Funk, ),
                            [%PLAYLIST%]
                        )
                    )

        // chiptune
            // one-liner
                $if($strstr($lower(%genre%),chiptune),$if($not($strstr($lower(%PLAYLIST%),chiptune)),[%PLAYLIST%; ]Chiptune,[%PLAYLIST%]),$if($strstr($lower(%PLAYLIST%),chiptune),$replace([%PLAYLIST%],Chiptune,),[%PLAYLIST%]))
            // main code
                $if($strstr($lower(%genre%),chiptune),
                    $if($not($strstr($lower(%PLAYLIST%),chiptune)),
                        [%PLAYLIST%; ]Chiptune,
                        [%PLAYLIST%]
                    ),
                    $if($strstr($lower(%PLAYLIST%),chiptune),
                        $replace([%PLAYLIST%],Chiptune,),
                        [%PLAYLIST%]
                    )
                )
        // EXCLUDE from playlists
            // one-liner
                $if($strstr($lower([%genre%]),drumfunk),$if($not($strstr($lower([%EXCLUDE%]),funk)),$caps2([%EXCLUDE%;]Funk),$caps2([%EXCLUDE%])),$caps2([%EXCLUDE%]))
            // main code
                $if($strstr($lower([%genre%]),drumfunk),
                    $if($not($strstr($lower([%EXCLUDE%]),funk)),
                        $caps2([%EXCLUDE%;]Funk),
                        $caps2([%EXCLUDE%])
                    ),                        
                    $caps2([%EXCLUDE%])
                )

        // ALL playlists (not used / does not work currently)

            $puts(pls,
                $if($strstr($lower(%genre%),jungle),
                    $if($not($strstr($lower(%PLAYLIST%),jungle)),
                        [%PLAYLIST%; ]Jungle,
                        [%PLAYLIST%]
                    ),
                    $if($strstr($lower(%PLAYLIST%),jungle),
                        $replace([%PLAYLIST%],Jungle,),
                        [%PLAYLIST%]
                    )
                )
            )
            $puts(pls,
            $if($strstr($lower(%genre%),modern funk),
                $if($not($strstr($lower($get(pls)),modern funk)),
                    $get(pls)';' Modern Funk,),
                    $if($and($strstr($lower($get(pls)),modern funk),$not($strstr($lower(%genre%),funk))),
                        $replace($get(pls),Modern Funk,),
                    )
            )
            
            $if($strstr($lower(%genre%),chiptune),
                $if($not($strstr($lower($get(pls)),chiptune)),
                    [$get(pls)]Chiptune,
                ),
                $if($strstr($lower($get(pls)),chiptune),
                    $replace($get(pls),Chiptune,),
                )
            )
            )

            $trim($ifequal($strstr($get(pls),';'),0,$replace($get(pls),';',),$get(pls)))      
   
    // YEAR: tag from ORIGINAL RELEASE DATE if possible, otherwise from RECORDING DATE, otherwise from DATE
        // main code
            $if(%ORIGINAL RELEASE DATE%,$cut(%ORIGINAL RELEASE DATE%,4),$if(%RECORDING DATE%,$cut(%RECORDING DATE%,4),$cut([%date%],4)))

        // main code
            $if(%ORIGINAL RELEASE DATE%,
                $cut(%ORIGINAL RELEASE DATE%,4),
                $if(%RECORDING DATE%,
                    $cut(%RECORDING DATE%,4),
                    $cut([%date%],4)
                )
            )

// COLUMNS CHECK
    // TITLE column check
        $if(%title%,
            $if($or(
                    $strstr($lower(%title%),'feat '),
                    $strstr($lower(%title%),'feat.'),
                    $strstr($lower(%title%),'featuring'),
                    $strstr($lower(%title%),'featuring'),
                    $strstr($lower(%title%),'ft.'),
                    $strstr($lower(%title%),'(ft'),
                    $ifgreater(
                        $len($replace($lower(%title%),remix,)),
                        $sub($len(%title%),5)
                    )
                    ),
                $puts(kill,1),
                $if($or(
                        $strstr($lower(%title%),' with ')
                        $strstr($lower(%title%),' ft ')
                    ),
                    $puts(warning,1)
                )
            ),
            $puts(missing,1)
        )
            $if($get(missing),
                $rgb(222,33,71)MISSING,
                $if($get(kill),
                    $rgb(222,33,71)[%title%],
                    $if($get(warning),
                        $rgb(255,155,0)[%title%],
                        [%title%]
                    )
                )
            )

    // GENRE COLUMN check
        // MISSING if no genre / red color if modern funk but no playlist or exclude / yellow if only one genre

        $if($not([%genre%]),
        $puts(missing,1)
        )

        $if($and(
            $strstr($lower(%genre%),funk),
            $not($strstr($lower(%genre%),neurofunk)),
            $greater([%year%],1980),
            $not($strstr($lower(%PLAYLIST%),funk)),
            $not($strstr($lower(%EXCLUDE%),funk))
            ),
            $puts(kill,1)
        )

        $if($and(
            $strstr($lower([%genre%]),chiptune),
            $not($strstr($lower([%PLAYLIST%]),chiptune))
            ),
            $puts(kill,1)
        )

        $if($and(
            $strstr($lower([%genre%]),jungle),
            $not($strstr($lower([%PLAYLIST%]),jungle)),
            $not($strstr($lower([%EXCLUDE%]),jungle))
            ),
            $puts(kill,1)
        )

        $if($not($meta(genre,1)),
        $puts(warning,1)
        )

        $if($or($get(missing),$get(kill),$get(warning)),
            $if($get(missing),
                $rgb(222,33,71)MISSING,
                $if($get(kill),
                    $rgb(222,33,71)[%genre%],
                    $if($get(warning),
                        $rgb(236,163,64)[%genre%]
                    )
                )
            ),
        [%genre%]
        )
    // YEAR COLUMN check
        $if($meta(year),
            $if(%ORIGINAL RELEASE DATE%,
                $ifequal($meta(year),$left(%ORIGINAL RELEASE DATE%,4),
                    $meta(year),
                    $rgb(222,33,71)WRONG!
                ),
                $meta(year)
            ),
            $rgb(222,33,71)MISSING
        )

    // ARTIST COLUMN check
        // color titles with "feat" and more than one "&"

        $if($strchr([%artist%],&),
            $ifequal($strchr([%artist%],&),$strrchr([%artist%],&),
            ,
            $puts(warning,1)
            )
        )

        $ifgreater($strstr($lower([%artist%]),feat),0,
            $puts(kill,1),
        )

        $if($and(
                $greater($meta_num(artist),1),$not($strchr([%artist%],&))
            ),
            $puts(kill,1),
        )


        $if($get(kill),
            $rgb(222,33,71)[%artist%],
            $if($get(warning),
                $rgb(249,213,6)[%artist%],
                [%artist%]
            )
        )
    

    // ALBUM column check

        $if([%album%],
            $if($or(
                    $strstr($lower([%album%]),remaster),
                    $strstr($lower([%album%]),cd0),
                    $strstr($lower([%album%]),cd1),
                    $strstr($lower([%album%]),cd2),
                    $strstr($lower([%album%]),cd3),
                    $strstr($lower([%album%]),cd4),
                    $strstr($lower([%album%]),cd5),
                    $strstr($lower([%album%]),cd6),
                    $strstr($lower([%album%]),cd7),
                    $strstr($lower([%album%]),cd8),
                    $strstr($lower([%album%]),cd9),
                    $strstr($lower([%album%]),cd10),
                    $strstr($lower([%album%]),disc),
                    $strstr($lower([%album%]),disk),
                    $strstr($lower([%album%]),reissue),
                    $strstr($lower([%album%]),reissue),
                    $strstr($lower([%album%]),'['),
                    $strstr($lower([%album%]),']'),
                    $strstr($lower([%album%]),'('),
                    $strstr($lower([%album%]),')'),
                    $strstr($lower([%album%]),'{'),
                    $strstr($lower([%album%]),'}')
                ),
                $rgb(222,33,71)[%album%],
                [%album%]
            ),
            $rgb(222,33,71)MISSING
        )

        $if($not([%genre%]),
            $puts(missing,1)
        )

        $if($and(
            $strstr($lower(%genre%),funk),
            $not($strstr($lower(%genre%),neurofunk)),
            $greater([%year%],1980),
            $not($strstr($lower(%PLAYLIST%),funk)),
            $not($strstr($lower(%EXCLUDE%),funk))
            ),
            $puts(kill,1)
        )

        $if($and(
            $strstr($lower(%genre%),chiptune),
            $not($strstr($lower(%PLAYLIST%),chiptune))
            ),
            $puts(kill,1)
        )

        $if($not($meta(genre,1)),
            $puts(warning,1)
        )

        $if($or(
            $get(missing),$get(kill),$get(warning)),
            $if($get(missing),
                $rgb(222,33,71)MISSING,
                $if($get(kill),
                    $rgb(222,33,71)[%genre%],
                    $if($get(warning),
                        $rgb(236,163,64)[%genre%]
                    )
                )
            ),
            [%genre%]
        )

    // COVER COLUMN check

        $puts(size,[%front_cover_size%])
        $puts(bytes,[%front_cover_bytes%])
        $puts(format,[%front_cover_format%])
        $puts(height,[%front_cover_height%])
        $puts(width,[%front_cover_width%])

        $puts(coverres,
        $ifequal($mod([%front_cover_height%],[%front_cover_width%]),0,
            [%front_cover_width%]px,[%front_cover_width%]x[%front_cover_height%])
        )

        $puts(coverstatus,
            $ifgreater(1,$len($get(size)),
                $rgb(222,33,71)MISSING,
                $ifgreater(500,$max($get(height),$get(width)),
                    $rgb(222,33,71)$get(coverres)
                    $rgb(),
                    $get(coverres)
                )
            )

            $ifgreater($get(bytes),300000,
                ' | '$rgb(222,33,71)$get(size)
                $rgb(),
                $if($and(
                        $greater($get(bytes),200000),
                        $greater($max($get(height),$get(width)),600)
                    ),
                    '| '$rgb(249,213,6)$get(size)
                    $rgb(),
                    $if($get(size),
                        '| '$get(size)
                    )
                )
            )

            $ifequal($stricmp($get(format),JPEG),1,
            ,
            $rgb(255,249,0)$get(format)$rgb()
            )
        )

        $get(coverstatus)

    // FORMAT check

        $puts(format,
        $puts(DLM,'-')$puts(BRC,)$puts(KHZ,)$puts(BPS,)$puts(BTR,k)$puts(WST,1)$puts(CHN,$ifgreater($info(channels),2,$get(DLM)$info(channels)Ch,$ifequal($info(channels),1,$get(DLM)Mono,)))$puts(VBQ,$replace($info(bitrate_nominal),32,Q-2,45,Q-1,48,Q-1,64,Q0,80,Q1,96,Q2,112,Q3,128,Q4,160,Q5,192,Q6,224,Q7,227,Q7,256,Q8,320,Q9,500,Q10))$puts(BRS,$if($greater(%samplerate%,199000),,$if($and($strcmp(%samplerate%,44100),$strcmp($info(bitspersample),16),$strcmp($get(WST),0)),,$get(DLM)$info(bitspersample)$get(BPS)$get(DLM)$div(%samplerate%,1000)$get(KHZ))))$puts(EXT,$upper($if($or($stricmp($ext(%filename_ext%),aif),$stricmp($ext(%filename_ext%),aiff)),AIFF,$if($or($stricmp($ext(%filename_ext%),mid),$stricmp($ext(%filename_ext%),midi),$stricmp($ext(%filename_ext%),kar),$stricmp($ext(%filename_ext%),rmi)),MIDI,$ext(%filename_ext%)))))$puts(CDC,$replace($upper($replace($lower(%codec%),monkey''s audio,APE,wavpack,WVC,musepack,MPC)),' (FLOATING-POINT)',,IMA ADPCM,ADPCM,PCM,$get(EXT)))$puts(CPR,$upper($replace($lower($info(codec_profile)),quality ,q,'',,braindead,q8,insane,q7,xtreme,q1,standard,q5,radio,q4,thumb,q3,telephone,q2,unstable'/'experimental,UST,vbr ,))$get(VBQ))$puts(LSY,$get(CDC)$if($stricmp($get(CPR),CBR),$get(DLM)%bitrate%$get(BTR),$if($info(codec_profile),$get(DLM)$get(CPR),$if($info(bitrate_nominal),$get(DLM)$get(VBQ),))))$puts(LSL,$get(CDC)$get(BRS))$puts(FMT,$if($stricmp($info(encoding),lossy),$get(LSY),$if($stricmp($info(encoding),lossless),$get(LSL),$get(EXT))))$insert($get(BRC),$get(FMT)$get(CHN),1)
        )

        $if($stricmp(%codec%,FLAC),
            $ifequal(%__bitspersample%,16,
                $ifgreater(%samplerate%,48000,
                    $get(EXT) %__bitspersample%/$left(%samplerate%,2),
                    $get(EXT)
                ),
                $if([%WASTED BITS%],
                    $get(EXT) %__bitspersample%/$left(%samplerate%,2) '('padded')',
                    $rgb(222,33,71)$get(EXT) %__bitspersample%/$left(%samplerate%,2)
                )
            ),
            $rgb(222,33,71)$get(format)
        )

    // ALL CHECKS COLUMN
        // TITLE column check
            $if(%title%,
                $if($or(
                        $strstr($lower(%title%),'feat '),
                        $strstr($lower(%title%),'feat.'),
                        $strstr($lower(%title%),'featuring'),
                        $strstr($lower(%title%),'featuring'),
                        $strstr($lower(%title%),'ft.'),
                        $strstr($lower(%title%),'(ft'),
                        $greater(
                            $sub($len(%title%),5),
                            $len($replace($lower(%title%),remix,))
                        )
                    ),
                    $puts(kill,$add($get(kill),1)),
                    $if($or(
                            $strstr($lower(%title%),' with ')
                            $strstr($lower(%title%),' ft ')
                        ),
                        $puts(warning,$add($get(warning),1))
                    )
                ),
                $puts(kill,$add($get(kill),1))
            )

        // FRONT COVER CHECK

            $puts(size,[%front_cover_size%])
            $puts(bytes,[%front_cover_bytes%])
            $puts(format,[%front_cover_format%])
            $puts(height,[%front_cover_height%])
            $puts(width,[%front_cover_width%])

            $puts(coverres,
            $ifequal($mod([%front_cover_height%],[%front_cover_width%]),0,
            [%front_cover_width%]px,[%front_cover_width%]x[%front_cover_width%])
            )

            $ifgreater(1,$len($get(size)),
            $puts(kill,$add($get(kill),1)),
            $ifgreater(500,$max($get(height),$get(width)),
            $puts(kill,$add($get(kill),1)),
            )
            )

            $ifgreater($get(bytes),300000,
            $puts(kill,$add($get(kill),1)),
            )


            $if($and($greater($get(bytes),200000),
            $greater($max($get(height),$get(width)),600)
            ),
            $puts(warning,$add($get(warning),1)),
            )


            $ifequal($stricmp($get(format),JPEG),1,
            ,
            $puts(kill,$add($get(kill),1))
            )

        // YEAR TAG CHECK

            $if($meta(year),
                $if(%ORIGINAL RELEASE DATE%,
                    $ifequal($meta(year),$left(%ORIGINAL RELEASE DATE%,4),
                        ,
                        $puts(kill,$add($get(kill),1))
                    ),
                ),
                $puts(kill,$add($get(kill),1))
            )

        // ReplayGain CHECK

            $puts(status,$if([%replaygain_track_gain%],OK))
            $if($get(status)=OK,
            ,
            $puts(kill,$add($get(kill),1))
            )

        // Featured Artists CHECK

            $ifgreater($strstr($lower([%title%]),feat),0,
            $puts(kill,$add($get(kill),1)),
            )

            $if($strchr([%artist%],&),
            $ifequal($strchr([%artist%],&),$strrchr([%artist%],&),
            ,
            $puts(warning,$add($get(warning),1))
            )
            )

            $if($and($greater($meta_num(artist),1),$not($strchr([%artist%],&))
            ),
            $puts(kill,$add($get(kill),1)),
            )

        // GENRES CHECK

            $if($not([%genre%]),
            $puts(kill,$add($get(kill),1))
            )

            $if($and(
                $strstr($lower(%genre%),funk),
                $not($strstr($lower(%genre%),neurofunk)),
                $greater([%year%],1980),
                $not($strstr($lower(%PLAYLIST%),funk)),
                $not($strstr($lower(%EXCLUDE%),funk))
                ),
                $puts(kill,$add($get(kill),1))
            )

            $if($and(
                    $strstr($lower(%genre%),jungle),
                    $not($strstr($lower(%PLAYLIST%),jungle)),
                    $not($strstr($lower(%EXCLUDE%),jungle))
                    ),
                $puts(kill,$add($get(kill),1))
            )

            $if($not($meta(genre,1)),
            $puts(warning,$add($get(warning),1))
            )

        // FORMAT CHECK

            $if([%codec%]=FLAC,
            $ifequal(%__bitspersample%,16,
            ,
            $if($not([%WASTED BITS%]),
            $puts(warning,$add($get(warning),1))
            )
            ),
            $puts(kill,$add($get(kill),1))
            )

        // ALBUM CHECK
            $if($not([%album%]),
            $puts(kill,$add($get(kill),1))
            )

        // EXECUTE

            $ifgreater($get(kill),0,
            $rgb(222,33,71)$get(kill) CHECK'('S')' KO,
            $rgb(0,166,0)OK
            )

            $rgb()

            $ifgreater($get(warning),0,
            $rgb(249,213,6)$get(warning)⚠️,
            )

            $if($strstr($lower(%path%),tagged)>0,
            $if(%PROCESSED%,
            $rgb(0,166,0)
            ' | Tagged',
            $rgb(249,213,6)
            ' | Tagged')
            )
