// NOT actually perl, only for display formatting reasons

// SCRIPT
    // TRACKNUMBER: check format and fix if necessary (output: 2 digits with leading zero if applicable)
        // one-liner
        $trim($if([%tracknumber%],$iflonger([%tracknumber%],2,$if($puts(truncate_position,$strchr([%tracknumber%],/)),$cut([%tracknumber%],$sub($get(truncate_position),1)),[%tracknumber%]),[%tracknumber%])))
        // main code
            $trim(
                $if([%tracknumber%],
                    $iflonger([%tracknumber%],2,
                    $if($puts(truncate_position,$strchr([%tracknumber%],/)),
                    $cut([%tracknumber%],$sub($get(truncate_position),1)),
                    [%tracknumber%]
                    ),
                    [%tracknumber%]
                    )
                )
            )

    // GENRE: add missing genres, fix stuff...
        // ELECTRONIC: add if missing
            // one-liner
                $if($not($strstr($lower(%genre%),electronic)),$if($or($strstr($lower(%genre%),house),$strstr($lower(%genre%),drum & bass),$strstr($lower(%genre%),jungle),$strstr($lower(%genre%),techno),$strstr($lower(%genre%),synthwave),$strstr($lower(%genre%),edm),$strstr($lower(%genre%),breakbeat),$strstr($lower(%genre%),breaks),$strstr($lower(%genre%),uk garage),$strstr($lower(%genre%),speed garage),$strstr($lower(%genre%),chiptune),$strstr($lower(%genre%),idm),$strstr($lower(%genre%),glitch hop),$strstr($lower(%genre%),dubstep),$strstr($lower(%genre%),brostep),$strstr($lower(%genre%),uk bass),$strstr($lower(%genre%),bass music)),[%genre%]; Electronic,[%genre%]),[%genre%])
            // main code
                $if($not($strstr($lower(%genre%),electronic)),
                    $if(
                        $or(
                            $strstr($lower(%genre%),house),
                            $strstr($lower(%genre%),drum & bass),
                            $strstr($lower(%genre%),jungle),
                            $strstr($lower(%genre%),techno),
                            $strstr($lower(%genre%),synthwave),
                            $strstr($lower(%genre%),edm),
                            $strstr($lower(%genre%),breakbeat),
                            $strstr($lower(%genre%),breaks),
                            $strstr($lower(%genre%),uk garage),
                            $strstr($lower(%genre%),speed garage),
                            $strstr($lower(%genre%),chiptune),
                            $strstr($lower(%genre%),idm),
                            $strstr($lower(%genre%),glitch hop),
                            $strstr($lower(%genre%),dubstep),
                            $strstr($lower(%genre%),brostep),
                            $strstr($lower(%genre%),uk bass),
                            $strstr($lower(%genre%),bass music)
                        ),
                        [%genre%]; Electronic,
                        [%genre%]
                    ),
                    [%genre%]
                )
        // JAZZ: add if missing
            // one-liner
                $ifgreater($add($stricmp($meta(genre,0),jazz),$stricmp($meta(genre,1),jazz),$stricmp($meta(genre,2),jazz),$stricmp($meta(genre,3),jazz),$stricmp($meta(genre,4),jazz),$stricmp($meta(genre,5),jazz),$stricmp($meta(genre,6),jazz),$stricmp($meta(genre,7),jazz),$stricmp($meta(genre,8),jazz),$stricmp($meta(genre,9),jazz),$stricmp($meta(genre,10),jazz),$stricmp($meta(genre,11),jazz),$stricmp($meta(genre,12),jazz),$stricmp($meta(genre,13),jazz),$stricmp($meta(genre,14),jazz),$stricmp($meta(genre,15),jazz)),0,[%genre%],$if($or($strstr($lower(%genre%),contemporary jazz),$strstr($lower(%genre%),spiritual jazz),$strstr($lower(%genre%),nu jazz),$strstr($lower(%genre%),electro jazz),$strstr($lower(%genre%),afro jazz),$strstr($lower(%genre%),hard bop),$strstr($lower(%genre%),bebop),$strstr($lower(%genre%),post bop),$strstr($lower(%genre%),free jazz),$strstr($lower(%genre%),japanese jazz),$strstr($lower(%genre%),gypsy jazz),$strstr($lower(%genre%),jazz manouche),$strstr($lower(%genre%),jazz fusion),$strstr($lower(%genre%),afro cuban jazz),$strstr($lower(%genre%),south african jazz),$strstr($lower(%genre%),latin jazz)),[%genre%]; Jazz,[%genre%]))
            // main code
                $ifgreater($add(
                        $stricmp($meta(genre,0),jazz),
                        $stricmp($meta(genre,1),jazz),
                        $stricmp($meta(genre,2),jazz),
                        $stricmp($meta(genre,3),jazz),
                        $stricmp($meta(genre,4),jazz),
                        $stricmp($meta(genre,5),jazz),
                        $stricmp($meta(genre,6),jazz),
                        $stricmp($meta(genre,7),jazz),
                        $stricmp($meta(genre,8),jazz),
                        $stricmp($meta(genre,9),jazz),
                        $stricmp($meta(genre,10),jazz),
                        $stricmp($meta(genre,11),jazz),
                        $stricmp($meta(genre,12),jazz),
                        $stricmp($meta(genre,13),jazz),
                        $stricmp($meta(genre,14),jazz),
                        $stricmp($meta(genre,15),jazz)
                    ),
                    0,
                    [%genre%],
                    $if(
                        $or(
                            $strstr($lower(%genre%),contemporary jazz),
                            $strstr($lower(%genre%),spiritual jazz),
                            $strstr($lower(%genre%),nu jazz),
                            $strstr($lower(%genre%),electro jazz),
                            $strstr($lower(%genre%),afro jazz),
                            $strstr($lower(%genre%),hard bop),
                            $strstr($lower(%genre%),bebop),
                            $strstr($lower(%genre%),post bop),
                            $strstr($lower(%genre%),free jazz),
                            $strstr($lower(%genre%),japanese jazz),
                            $strstr($lower(%genre%),gypsy jazz),
                            $strstr($lower(%genre%),jazz manouche),
                            $strstr($lower(%genre%),jazz fusion),
                            $strstr($lower(%genre%),afro cuban jazz),
                            $strstr($lower(%genre%),south african jazz),
                            $strstr($lower(%genre%),latin jazz)
                        ),
                        [%genre%]; Jazz,
                        [%genre%]
                    )
                )

        // HOUSE: add if missing
            // one-liner
                $ifgreater($add($stricmp($meta(genre,0),house),$stricmp($meta(genre,1),house),$stricmp($meta(genre,2),house),$stricmp($meta(genre,3),house),$stricmp($meta(genre,4),house),$stricmp($meta(genre,5),house),$stricmp($meta(genre,6),house),$stricmp($meta(genre,7),house),$stricmp($meta(genre,8),house),$stricmp($meta(genre,9),house),$stricmp($meta(genre,10),house),$stricmp($meta(genre,11),house),$stricmp($meta(genre,12),house),$stricmp($meta(genre,13),house),$stricmp($meta(genre,14),house),$stricmp($meta(genre,15),house)),0,[%genre%],$if($or($strstr($lower(%genre%),deep house),$strstr($lower(%genre%),jazzy house),$strstr($lower(%genre%),disco house),$strstr($lower(%genre%),french house),$strstr($lower(%genre%),afro house),$strstr($lower(%genre%),tech house),$strstr($lower(%genre%),tribal house),$strstr($lower(%genre%),funky house),$strstr($lower(%genre%),progressive house),$strstr($lower(%genre%),melodic house)),[%genre%]; House,[%genre%]))
            // main code
                $ifgreater($add(
                        $stricmp($meta(genre,0),house),
                        $stricmp($meta(genre,1),house),
                        $stricmp($meta(genre,2),house),
                        $stricmp($meta(genre,3),house),
                        $stricmp($meta(genre,4),house),
                        $stricmp($meta(genre,5),house),
                        $stricmp($meta(genre,6),house),
                        $stricmp($meta(genre,7),house),
                        $stricmp($meta(genre,8),house),
                        $stricmp($meta(genre,9),house),
                        $stricmp($meta(genre,10),house),
                        $stricmp($meta(genre,11),house),
                        $stricmp($meta(genre,12),house),
                        $stricmp($meta(genre,13),house),
                        $stricmp($meta(genre,14),house),
                        $stricmp($meta(genre,15),house)
                    ),
                    0,
                    [%genre%],
                    $if(
                        $or(
                            $strstr($lower(%genre%),deep house),
                            $strstr($lower(%genre%),jazzy house),
                            $strstr($lower(%genre%),disco house),
                            $strstr($lower(%genre%),french house),
                            $strstr($lower(%genre%),afro house),
                            $strstr($lower(%genre%),tech house),
                            $strstr($lower(%genre%),tribal house),
                            $strstr($lower(%genre%),funky house),
                            $strstr($lower(%genre%),progressive house),
                            $strstr($lower(%genre%),melodic house)
                        ),
                        [%genre%]; House,
                        [%genre%]
                    )
                )

    // ARTIST: Find "feat" and move artist to ARTIST field

        // one-liner
        $if($strstr($lower([%title%]),'('ft.),$puts(featuring,'('ft.)$puts(matchpos,$strstr($lower([%title%]),'('ft.)))$if($strstr($lower([%title%]),'('with),$puts(featuring,'('with)$puts(matchpos,$strstr($lower([%title%]),'('with)))$if($strstr($lower([%title%]),feat),$puts(featuring,feat)$puts(matchpos,$strstr($lower([%title%]),feat)))$if($strstr($lower([%title%]),feat.),$puts(featuring,feat.)$puts(matchpos,$strstr($lower([%title%]),feat.)))$if($strstr($lower([%title%]),'('feat.),$puts(featuring,'('feat.)$puts(matchpos,$strstr($lower([%title%]),'('feat.)))$if($strstr($lower([%title%]),featuring),$puts(featuring,featuring)$puts(matchpos,$strstr($lower([%title%]),featuring)))$if($strstr($lower([%title%]),'('featuring),$puts(featuring,'('featuring)$puts(matchpos,$strstr($lower([%title%]),'('featuring)))$if($get(matchpos),[%artist%;]$trim($replace($replace($substr(%title%,$get(matchpos),$len(%title%)),')',),$get(featuring),)),[%artist%])

        // main code
        $if($strstr($lower([%title%]),'('ft.),$puts(featuring,'('ft.)
        $puts(matchpos,$strstr($lower([%title%]),'('ft.))
        )
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
        $if($strstr($lower([%title%]),'('ft.),$puts(featuring,'('ft.)$puts(matchpos,$strstr($lower([%title%]),'('ft.)))$if($strstr($lower([%title%]),'('with),$puts(featuring,'('with)$puts(matchpos,$strstr($lower([%title%]),'('with)))$if($strstr($lower([%title%]),feat),$puts(featuring,feat)$puts(matchpos,$strstr($lower([%title%]),feat)))$if($strstr($lower([%title%]),feat.),$puts(featuring,feat.)$puts(matchpos,$strstr($lower([%title%]),feat.)))$if($strstr($lower([%title%]),'('feat.),$puts(featuring,'('feat.)$puts(matchpos,$strstr($lower([%title%]),'('feat.)))$if($strstr($lower([%title%]),featuring),$puts(featuring,featuring)$puts(matchpos,$strstr($lower([%title%]),featuring)))$if($strstr($lower([%title%]),'('featuring),$puts(featuring,'('featuring)$puts(matchpos,$strstr($lower([%title%]),'('featuring)))$if($get(matchpos),$trim($substr(%title%,0,$sub($get(matchpos),1))),[%title%])

        // main code
        $if($strstr($lower([%title%]),'('ft.),$puts(featuring,'('ft.)
        $puts(matchpos,$strstr($lower([%title%]),'('ft.))
        )
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
            // funk in general
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
            // modern funk
                // one-liner
                    $if($strstr($lower([%genre%]),mellow funk),$if($not($strstr($lower([%EXCLUDE%]),modern funk)),$caps2([%EXCLUDE%;]Modern Funk),$caps2([%EXCLUDE%])),$caps2([%EXCLUDE%]))
                // main code
                    $if($strstr($lower([%genre%]),mellow funk),
                        $if($not($strstr($lower([%EXCLUDE%]),modern funk)),
                            $caps2([%EXCLUDE%;]Modern Funk),
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
    // TRACKNUMBER column


    // TITLE column check
        $if($meta(title),
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
        // MISSING if no genre
            $if($not([%genre%]),
            $puts(missing,1)
            )

        // check for duplicate genre value (case-insensitive)
            $if($or(
                // compare genre 1 to genres 2-11
                $if($meta(genre,0),
                    $or(
                        $stricmp($meta(genre,0),$meta(genre,1)),
                        $stricmp($meta(genre,0),$meta(genre,2)),
                        $stricmp($meta(genre,0),$meta(genre,3)),
                        $stricmp($meta(genre,0),$meta(genre,4)),
                        $stricmp($meta(genre,0),$meta(genre,5)),
                        $stricmp($meta(genre,0),$meta(genre,6)),
                        $stricmp($meta(genre,0),$meta(genre,7)),
                        $stricmp($meta(genre,0),$meta(genre,8)),
                        $stricmp($meta(genre,0),$meta(genre,9)),
                        $stricmp($meta(genre,0),$meta(genre,10))
                    )
                ),
                // compare genre 2 to genres 3-11
                $if($meta(genre,1),
                    $or(
                        $stricmp($meta(genre,1),$meta(genre,2)),
                        $stricmp($meta(genre,1),$meta(genre,3)),
                        $stricmp($meta(genre,1),$meta(genre,4)),
                        $stricmp($meta(genre,1),$meta(genre,5)),
                        $stricmp($meta(genre,1),$meta(genre,6)),
                        $stricmp($meta(genre,1),$meta(genre,7)),
                        $stricmp($meta(genre,1),$meta(genre,8)),
                        $stricmp($meta(genre,1),$meta(genre,9)),
                        $stricmp($meta(genre,1),$meta(genre,10))
                    )
                ),
                // genre 3 vs genres 4-11
                $if($meta(genre,2),
                    $or(
                        $stricmp($meta(genre,2),$meta(genre,3)),
                        $stricmp($meta(genre,2),$meta(genre,4)),
                        $stricmp($meta(genre,2),$meta(genre,5)),
                        $stricmp($meta(genre,2),$meta(genre,6)),
                        $stricmp($meta(genre,2),$meta(genre,7)),
                        $stricmp($meta(genre,2),$meta(genre,8)),
                        $stricmp($meta(genre,2),$meta(genre,9)),
                        $stricmp($meta(genre,2),$meta(genre,10))
                    )
                ),
                // genre 4
                $if($meta(genre,3),
                    $or(
                        $stricmp($meta(genre,3),$meta(genre,4)),
                        $stricmp($meta(genre,3),$meta(genre,5)),
                        $stricmp($meta(genre,3),$meta(genre,6)),
                        $stricmp($meta(genre,3),$meta(genre,7)),
                        $stricmp($meta(genre,3),$meta(genre,8)),
                        $stricmp($meta(genre,3),$meta(genre,9)),
                        $stricmp($meta(genre,3),$meta(genre,10))
                    )
                ),
                // genre 5
                $if($meta(genre,4),
                    $or(
                    $stricmp($meta(genre,4),$meta(genre,5)),
                    $stricmp($meta(genre,4),$meta(genre,6)),
                    $stricmp($meta(genre,4),$meta(genre,7)),
                    $stricmp($meta(genre,4),$meta(genre,8)),
                    $stricmp($meta(genre,4),$meta(genre,9)),
                    $stricmp($meta(genre,4),$meta(genre,10))
                    )
                ),
                // genre 6
                $if($meta(genre,5),
                    $or(
                        $stricmp($meta(genre,5),$meta(genre,6)),
                        $stricmp($meta(genre,5),$meta(genre,7)),
                        $stricmp($meta(genre,5),$meta(genre,8)),
                        $stricmp($meta(genre,5),$meta(genre,9)),
                        $stricmp($meta(genre,5),$meta(genre,10))
                    )
                ),
                // genre 7
                $if($meta(genre,6),
                    $or(
                        $stricmp($meta(genre,6),$meta(genre,7)),
                        $stricmp($meta(genre,6),$meta(genre,8)),
                        $stricmp($meta(genre,6),$meta(genre,9)),
                        $stricmp($meta(genre,6),$meta(genre,10))
                    )
                ),
                // genre 8
                $if($meta(genre,7),
                    $or(
                        $stricmp($meta(genre,7),$meta(genre,8)),
                        $stricmp($meta(genre,7),$meta(genre,9)),
                        $stricmp($meta(genre,7),$meta(genre,10))
                    )
                ),
                // genre 9
                $if($meta(genre,8),
                    $or(
                    $stricmp($meta(genre,8),$meta(genre,9)),
                    $stricmp($meta(genre,8),$meta(genre,10))
                    )
                ),
                // genre 10
                $if($meta(genre,9),
                    $or(
                        $stricmp($meta(genre,9),$meta(genre,10))
                    )
                )
                ),
            $puts(kill,1)
            )

        // red color if modern funk/chiptune/jungle but no playlist or exclude 
            $if($and(
                $strstr($lower(%genre%),funk),
                $not($strstr($lower(%genre%),neurofunk)),
                $greater([%year%],1995),
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
                $not($and(
                    $strstr($lower([%PLAYLIST%]),drum),
                    $strstr($lower([%PLAYLIST%]),bass)
                )),
                $not($strstr($lower([%EXCLUDE%]),jungle))
                ),
                $puts(kill,1)
            )
        // check for weird chars
            $if($or(
                $strchr([%genre%],'.'),
                $strchr([%genre%],':'),
                $strchr([%genre%],'+'),
                $strchr([%genre%],'='),
                $strchr([%genre%],'!'),
                $strchr([%genre%],'?'),
                $strchr([%genre%],'/'),
                $strchr([%genre%],'\'),
                $strchr([%genre%],'$'),
                $strchr([%genre%],'^'),
                $strchr([%genre%],'*'),
                $strchr([%genre%],'('),
                $strchr([%genre%],')'),
                $strchr([%genre%],'['),
                $strchr([%genre%],']'),
                $strchr([%genre%],'{'),
                $strstr([%genre%],'  '),
                $strstr([%genre%],'   '),
                $strstr([%genre%],'    '),
                $strchr([%genre%],'}')
                ),
                $puts(kill,1)
            )

        // warning if single genre
            $if($not($meta(genre,1)),
            $puts(warning,1)
            )

        // execute script
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
    // DATE COLUMN (check if multi-value, if <4 char and if >10 chars)
        $if([%date%],
            $ifgreater($meta_num(date),1,
                $rgb(222,33,71)[%date%],
                $iflonger([%date%],10,
                    $rgb(222,33,71)[%date%],
                    $iflonger(0000,$len([%date%]),
                        $rgb(222,33,71)[%date%],
                        [%date%]
                    )
                )
            ),
        $rgb(222,33,71)MISSING
        )
        
    // YEAR COLUMN check
        // multiply YEAR by 1 ==> if equals 0 then YEAR is not a number
        $if($meta(year),
            $if($and($longer($meta(year),123),$longer(12345,$meta(year)),$greater($meta(year),1)),
                    $if(%ORIGINAL RELEASE DATE%,
                        $ifequal($meta(year),$left(%ORIGINAL RELEASE DATE%,4),
                            $meta(year),
                            $if(%RECORDING DATE%,
                                $ifequal($meta(year),$left(%RECORDING DATE%,4),
                                    $meta(year),
                                    $rgb(222,33,71)WRONG!
                                ),
                            $rgb(222,33,71)WRONG!
                            )
                        ),
                        $meta(year)
                    ),
                $rgb(222,33,71)WRONG!
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
                    $strstr($lower([%album%]),'{'),
                    $strstr($lower([%album%]),'}')
                ),
                $rgb(222,33,71)[%album%],
                $if($or(
                    $strstr($lower([%album%]),'('),
                    $strstr($lower([%album%]),')')
                    ),
                    $rgb(249,213,6)[%album%],
                    [%album%]
                    )
                ),
            $rgb(222,33,71)MISSING
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

    // PATH column
        $if($strstr(%path%,\Music\),
            $if( 
                $or(
                $strstr(%path%,\HEYLISTEN\),
                $strstr(%path%,\LIKED\)
                ),
                $puts(path_string_color,$rgb(249,213,6)),
                $if($or(
                    $strstr(%path%,\WIPREWORK\),
                    $strstr(%path%,\NOGENRE\)
                    ),
                    $puts(path_string_color,$rgb(222,33,71)),
                    $puts(path_string_color,$rgb(50,130,180))
                    $puts(path_string,Selected)
                )
            )
            )

        $if($or(
            $strstr(%path%,\everything-OGG\),
            $strstr(%path%,\Uploads\)
            ),
            $puts(path_string_color,$rgb(14,171,49))
        )
        $if($or(
            $strstr(%path%,R:\Radio\),
            $strstr(%path%,\M-tags\ssd\)
            ),
            $puts(path_string_color,$rgb(255,0,200))
        )

        $if($and(
            $strstr(%path%,R:\Radio\),
            $not($strstr(%path%,R:\Radio\everything\))
            ),
            $puts(path_string_color,$rgb(0,250,200))
        )
        $if($and(
            $strstr(%path%,D:\Radio\)
            ),
            $puts(path_string_color,$rgb(50,130,180))
        )

        $if($strstr(%path%,\M-tags\ssd\),
        $puts(path_string,SSD-MTAG)
        )
        $if($strstr(%path%,\HEYLISTEN\),
        $puts(path_string,HEYLISTEN)
        )
        $if($strstr(%path%,\LIKED\),
        $puts(path_string,LIKED)
        )
        $if($strstr(%path%,\WIPREWORK\),
        $puts(path_string,WIP)
        )
        $if($strstr(%path%,\NOGENRE\),
        $puts(path_string,NO GENRE)
        )
        $if($strstr(%path%,\everything-OGG\),
        $puts(path_string,OGG Radio)
        )
        $if($strstr(%path%,\Radio\everything\),
        $puts(path_string,ALL)
        )
        $if($strstr(%path%,\Radio\everything-except-OST\),
        $puts(path_string,ALL/No OST)
        )
        $if($strstr(%path%,\new\),
        $puts(path_string,New)
        )
        $if($strstr(%path%,\best new music\),
        $puts(path_string,Best new music)
        )
        $if($strstr(%path%,\genre-based\),
        $puts(path_string,Genre-based)
        )
        $if($strstr(%path%,\region-based\),
        $puts(path_string,Uploads)
        )
        $if($strstr(%path%,\soundtracks\),
        $puts(path_string,Soundtracks)
        )

        $get(path_string_color)$cut(%path%,1): $get(path_string)

    // ALL CHECKS COLUMN
        // TITLE column check
            $if($meta(title),
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

            $if($and($meta(year),$longer($meta(year),123),$longer(12345,$meta(year)),$greater($meta(year),1)),
                    $if(%ORIGINAL RELEASE DATE%,
                        $ifequal($meta(year),$left(%ORIGINAL RELEASE DATE%,4),
                            ,
                            $if(%RECORDING DATE%,
                                $ifequal($meta(year),$left(%RECORDING DATE%,4),
                                    ,
                                    $puts(kill,$add($get(kill),1))
                                ),
                            $puts(kill,$add($get(kill),1))
                            )
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
             $if($or(
                // compare genre 1 to genres 2-11
                $if($meta(genre,0),
                    $or(
                        $stricmp($meta(genre,0),$meta(genre,1)),
                        $stricmp($meta(genre,0),$meta(genre,2)),
                        $stricmp($meta(genre,0),$meta(genre,3)),
                        $stricmp($meta(genre,0),$meta(genre,4)),
                        $stricmp($meta(genre,0),$meta(genre,5)),
                        $stricmp($meta(genre,0),$meta(genre,6)),
                        $stricmp($meta(genre,0),$meta(genre,7)),
                        $stricmp($meta(genre,0),$meta(genre,8)),
                        $stricmp($meta(genre,0),$meta(genre,9)),
                        $stricmp($meta(genre,0),$meta(genre,10))
                    )
                ),
                // compare genre 2 to genres 3-11
                $if($meta(genre,1),
                    $or(
                        $stricmp($meta(genre,1),$meta(genre,2)),
                        $stricmp($meta(genre,1),$meta(genre,3)),
                        $stricmp($meta(genre,1),$meta(genre,4)),
                        $stricmp($meta(genre,1),$meta(genre,5)),
                        $stricmp($meta(genre,1),$meta(genre,6)),
                        $stricmp($meta(genre,1),$meta(genre,7)),
                        $stricmp($meta(genre,1),$meta(genre,8)),
                        $stricmp($meta(genre,1),$meta(genre,9)),
                        $stricmp($meta(genre,1),$meta(genre,10))
                    )
                ),
                // genre 3 vs genres 4-11
                $if($meta(genre,2),
                    $or(
                        $stricmp($meta(genre,2),$meta(genre,3)),
                        $stricmp($meta(genre,2),$meta(genre,4)),
                        $stricmp($meta(genre,2),$meta(genre,5)),
                        $stricmp($meta(genre,2),$meta(genre,6)),
                        $stricmp($meta(genre,2),$meta(genre,7)),
                        $stricmp($meta(genre,2),$meta(genre,8)),
                        $stricmp($meta(genre,2),$meta(genre,9)),
                        $stricmp($meta(genre,2),$meta(genre,10))
                    )
                ),
                // genre 4
                $if($meta(genre,3),
                    $or(
                        $stricmp($meta(genre,3),$meta(genre,4)),
                        $stricmp($meta(genre,3),$meta(genre,5)),
                        $stricmp($meta(genre,3),$meta(genre,6)),
                        $stricmp($meta(genre,3),$meta(genre,7)),
                        $stricmp($meta(genre,3),$meta(genre,8)),
                        $stricmp($meta(genre,3),$meta(genre,9)),
                        $stricmp($meta(genre,3),$meta(genre,10))
                    )
                ),
                // genre 5
                $if($meta(genre,4),
                    $or(
                    $stricmp($meta(genre,4),$meta(genre,5)),
                    $stricmp($meta(genre,4),$meta(genre,6)),
                    $stricmp($meta(genre,4),$meta(genre,7)),
                    $stricmp($meta(genre,4),$meta(genre,8)),
                    $stricmp($meta(genre,4),$meta(genre,9)),
                    $stricmp($meta(genre,4),$meta(genre,10))
                    )
                ),
                // genre 6
                $if($meta(genre,5),
                    $or(
                        $stricmp($meta(genre,5),$meta(genre,6)),
                        $stricmp($meta(genre,5),$meta(genre,7)),
                        $stricmp($meta(genre,5),$meta(genre,8)),
                        $stricmp($meta(genre,5),$meta(genre,9)),
                        $stricmp($meta(genre,5),$meta(genre,10))
                    )
                ),
                // genre 7
                $if($meta(genre,6),
                    $or(
                        $stricmp($meta(genre,6),$meta(genre,7)),
                        $stricmp($meta(genre,6),$meta(genre,8)),
                        $stricmp($meta(genre,6),$meta(genre,9)),
                        $stricmp($meta(genre,6),$meta(genre,10))
                    )
                ),
                // genre 8
                $if($meta(genre,7),
                    $or(
                        $stricmp($meta(genre,7),$meta(genre,8)),
                        $stricmp($meta(genre,7),$meta(genre,9)),
                        $stricmp($meta(genre,7),$meta(genre,10))
                    )
                ),
                // genre 9
                $if($meta(genre,8),
                    $or(
                    $stricmp($meta(genre,8),$meta(genre,9)),
                    $stricmp($meta(genre,8),$meta(genre,10))
                    )
                ),
                // genre 10
                $if($meta(genre,9),
                    $or(
                        $stricmp($meta(genre,9),$meta(genre,10))
                    )
                )
                ),
            $puts(kill,$add($get(kill),1))
            )

            $if($not([%genre%]),
            $puts(kill,$add($get(kill),1))
            )

            $if($and(
                $strstr($lower(%genre%),funk),
                $not($strstr($lower(%genre%),neurofunk)),
                $greater([%year%],1995),
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

        // ALBUM CHECK (incomplete)
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
            $if($and(
                %PROCESSED%,
                $not($strstr($lower(%path%),tagged))
                ),
                $rgb(0,166,0)
                ' | Checked'
            )