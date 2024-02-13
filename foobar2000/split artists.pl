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
                $if($strstr($lower(%genre%),jungle),$if($not($strstr($lower(%PLAYLIST%),jungle)),[%PLAYLIST%; ]Jungle,[%PLAYLIST%]),$if($strstr($lower(%PLAYLIST%),jungle),$replace([%PLAYLIST%],Jungle,),[%PLAYLIST%]))
            // main code
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
        // modern funk
            // one-liner
                $if($and($strstr($lower(%genre%),modern funk),$not($strstr($lower(%PLAYLIST%),modern funk))),[%PLAYLIST%; ]Modern Funk,[%PLAYLIST%])
            // main code
                $if($and(
                        $strstr($lower(%genre%),modern funk),$not($strstr($lower(%PLAYLIST%),modern funk))
                    ),
                    [%PLAYLIST%; ]Modern Funk,
                    [%PLAYLIST%]
                )

    // Add YEAR tag from ORIGINAL RELEASE DATE if possible, otherwise from DATE
    $if(%ORIGINAL RELEASE DATE%,$cut(%ORIGINAL RELEASE DATE%,4),$cut(%date%,4))

// COLUMNS CHECK
    // GENRE COLUMN check
        // MISSING if no genre / red color if modern funk but no playlist or exclude / yellow if only one genre

        $if($not([%genre%]),
        $puts(missing,1)
        )

        $if($and(
            $strstr($lower(%genre%),funk),
            $greater([%year%],1980),
            $not($strstr($lower(%PLAYLIST%),funk)),
            $not($strstr($lower(%EXCLUDE%),funk))
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
    // GENRE COLUMN check
        $if($not([%genre%]),
            $puts(missing,1)
        )

        $if($and(
            $strstr($lower(%genre%),funk),
            $greater([%year%],1980),
            $not($strstr($lower(%PLAYLIST%),funk)),
            $not($strstr($lower(%EXCLUDE%),funk))
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

    // ALL CHECKS COLUMN

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
                $greater([%year%],1980),
                $not($strstr($lower(%PLAYLIST%),funk)),
                $not($strstr($lower(%EXCLUDE%),funk))
                ),
                $puts(kill,$add($get(kill),1))
            )

            $if($and(
                    $strstr($lower(%genre%),jungle),
                    $not($strstr($lower(%PLAYLIST%),jungle))
                    ),
                $puts(kill,$add($get(kill),1))
            )

            $if($not($meta(genre,1)),
            $puts(warning,1)
            )

        // FORMAT CHECK

            $if([%codec%]=FLAC,
            $ifequal(%__bitspersample%,16,
            ,
            $puts(warning,$add($get(warning),1))
            ),
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
