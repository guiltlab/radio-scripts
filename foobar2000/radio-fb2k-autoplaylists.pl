// fb2k autoplaylist queries - not Perl, only .pl for formatting purposes

    // new music & best of decades

        // best new music
            %path% HAS R:\Radio 
            AND (
                %date% HAS 2024 OR %date% HAS 2023 OR (%date% HAS 2022 AND (%added% DURING LAST 16 WEEKS OR RECENT HAS yes))
            ) 
            AND NOT (
                (%genre% HAS soundtrack OR %genre% HAS game) AND "$meta_num(GENRE)" LESS 3
            ) 
            AND NOT (
                %genre% HAS soundtrack AND (%genre% HAS anim OR %genre% HAS cover OR %genre% HAS 8 bit OR %genre% HAS 16 bit) 
                AND 
                "$meta_num(GENRE)" LESS 4
            )

        // 2023 best tracks
            %path% HAS R:\Radio 
            AND 
            %date% HAS 2023 
            AND NOT (
                (%genre% HAS soundtrack OR %genre% HAS game) AND "$meta_num(GENRE)" LESS 3
            ) 
            AND NOT (
                %genre% HAS soundtrack 
                AND (
                    %genre% HAS anim OR %genre% HAS cover OR %genre% HAS 8 bit OR %genre% HAS 16 bit) AND "$meta_num(GENRE)" LESS 4
            )

        // 1960s best of
            %path% HAS R:\Radio 
            AND 
            %year% BEFORE 1970 
            AND 
            %year% AFTER 1959 
            AND NOT 
            %genre% HAS game 
            AND NOT 
            CHECKYEAR HAS wrong
            
        // 1990s best of
            %path% HAS R:\Radio 
            AND 
            %year% BEFORE 2000 
            AND 
            %year% AFTER 1989 
            AND NOT 
            %genre% HAS game 
            AND NOT 
            CHECKYEAR HAS wrong

    // blues & desert blues
        // blues
            %path% HAS R:\Radio 
            AND 
            %genre% HAS blues 
            AND NOT 
            %genre% HAS heavy 
            AND NOT 
            PLAYLIST HAS "not blues" 
            AND NOT 
            %genre% HAS desert 
            AND NOT 
            PLAYLIST HAS country 
            AND NOT 
            %genre% HAS africa 
            AND NOT 
            PLAYLIST HAS soul 
            AND NOT 
            EXCLUDE HAS blues

        // desert blues
            %path% HAS R:\Radio 
            AND 
            %genre% HAS desert blues

    // electronic
        // house
            %path% HAS D:\Radio\everything\ AND (
                %genre% HAS idm 
                OR (
                    %genre% HAS breakbeat 
                    AND NOT (%genre% HAS house OR %genre% HAS beats)
                ) 
                OR 
                %genre% HAS gqom 
                OR 
                %genre% HAS club freestyle 
                OR 
                %genre% HAS breaks 
                OR 
                %genre% HAS breakcore 
                OR 
                %genre% HAS techno 
                OR 
                %genre% HAS hardtek 
                OR 
                %genre% HAS tech house 
                OR 
                %genre% HAS "electro house" 
                OR (
                    %genre% HAS "uk garage" AND NOT %genre% HAS drum bass
                ) OR (
                    %genre% HAS "uk bass" AND NOT %genre% HAS drum bass
                ) OR (
                    %genre% HAS progressive AND (%genre% HAS house OR %genre% HAS trance)
                ) OR (
                    (%genre% HAS hardcore OR %genre% HAS acid OR %genre% HAS hard) 
                    AND 
                    %genre% HAS electro
                )
            ) 
            AND NOT 
            %genre% HAS hip hop 
            AND NOT 
            %genre% HAS "acid jazz" 
            AND NOT 
            %genre% HAS "acid rock" 
            AND NOT 
            %genre% HAS swing 
            AND NOT 
            %genre% HAS downtempo 
            AND NOT 
            %genre% HAS ambient 
            AND NOT 
            PLAYLIST HAS not idm 
            AND NOT 
            %genre% HAS trip hop 
            AND NOT 
            PLAYLIST HAS jungle 
            AND NOT 
            genre HAS drum bass 
            AND NOT (
                PLAYLIST HAS house AND NOT PLAYLIST HAS techno
            )

    // country & bluegrass
        %path% HAS R:\Radio 
        AND (
            %genre% HAS country 
            OR 
            %genre% HAS bluegrass
        )

    // funky flavors

        // funky general playlist
            %path% HAS R:\Radio 
            AND (
                %genre% HAS funk 
                OR 
                %genre% HAS electro swing 
                OR (
                    %genre% HAS afrobeat 
                    AND NOT (
                        %genre% HAS afrobeats 
                        AND NOT 
                        %genre% HAS funk
                    )
                )
            ) 
            AND NOT 
            %genre% HAS neurofunk 
            AND NOT 
            %genre% HAS g-funk 
            AND NOT 
            genre IS drumfunk 
            AND NOT 
            %genre% HAS downtempo

        // afrobeat
            %path% HAS R:\Radio 
            AND (
                %genre% HAS afrobeat 
                AND NOT (
                    %genre% HAS afrobeats 
                    AND NOT %genre% IS afrobeat
                )
            )

        // disco & nu disco
            %path% HAS R:\Radio 
            AND 
            %genre% HAS disco 
            AND NOT 
            LAYLIST HAS "not disco"

        // cumbia, calypso, salsa, funana, latin funk et al.
            %path% HAS R:\Radio 
            AND (
                %genre% HAS cumbia 
                OR 
                %genre% HAS calypso 
                OR 
                %genre% HAS funana 
                OR 
                %genre% HAS rumba 
                OR 
                %genre% HAS salsa 
                OR 
                PLAYLIST HAS latin music 
                OR (
                    %genre% HAS "latin funk" 
                    AND NOT 
                    %genre% HAS latin jazz 
                    AND NOT 
                    %genre% HAS "afro funk" 
                    AND NOT 
                    %genre% HAS afrobeat
                    )
                ) 
            AND NOT 
            PLAYLIST HAS latin jazz

            // electrofunk / future funk
                %path% HAS R:\Radio 
                AND (
                    %genre% HAS electro funk 
                    OR 
                    %genre% HAS future funk
                ) 
                AND NOT 
                %genre% HAS house 
                AND NOT 
                %genre% HAS neuro 
                AND NOT 
                genre IS drumfunk 
                AND NOT 
                PLAYLIST HAS pop 
                AND NOT 
                %genre% HAS experimental 
                AND NOT 
                %date% BEFORE 1990 
                AND NOT 
                EXCLUDE HAS electro funk

            // modern funk
                %path% HAS R:\Radio 
                AND 
                %PLAYLIST% HAS modern funk 
                AND NOT 
                EXCLUDE HAS modern funk
    // rock
        // stoner, space rock, heavy psych...
            %path% HAS D:\Radio\everything\ 
            AND (
                %genre% HAS stoner 
                OR %genre% HAS space 
                OR %genre% HAS heavy blues 
                OR %genre% HAS heavy psych
            ) 
            AND NOT genre IS sludge metal 
            AND NOT PLAYLIST HAS endless 
            AND NOT PLAYLIST HAS live jam
    // Pop
        // general pop music < 8 mn
            %path% HAS D:\Radio\everything\ AND (
                (%genre% HAS electro AND %genre% HAS pop) 
                OR 
                %genre% HAS synthpop 
                OR 
                %genre% HAS synth pop 
                OR 
                %genre% HAS art pop 
                OR 
                %genre% HAS dream pop 
                OR 
                %genre% HAS dance pop 
                OR (%genre% HAS "indie pop" AND NOT %genre% HAS "indie rock") 
                OR (%genre% HAS pop AND %genre% HAS r&b)
            ) 
            AND NOT 
            %length% GREATER 480 
            AND NOT (
                genre IS trip hop AND NOT genre IS art pop
                ) 
            AND NOT 
            EXCLUDE HAS pop

    // region-based and language-based
        // francophonie
            %path% HAS R:\Radio 
            AND (
                * HAS french 
                OR 
                * HAS français 
                OR 
                * HAS québec 
                OR 
                * HAS quebec 
                OR 
                * HAS belge 
                OR 
                * HAS belgian 
                OR 
                * HAS francophone 
                OR 
                %genre% HAS belgium 
                AND NOT 
                %genre% HAS flandre 
                AND NOT 
                %genre% HAS flanders
            ) 
            AND NOT 
            EXCLUDE HAS francophon

        // etc

    // Find errors & fix
        // genre issues (find tracks with non-standard genres)
                // main query
                %path% HAS D:\Radio\everything\ AND NOT (
                Rock
                Pop Rock
                Soft rock
                AOR
                New Wave
                Indie Rock
                Alternative Rock
                Glam Rock
                Garage Rock
                Garage Rock Revival
                Stoner Rock
                Space Rock
                Jam Band
                Psychedelic Rock
                Heavy Psych
                Post*Rock
                Classic Rock
                Hard Rock
                Art rock
                Progressive Rock

                Metal
                Heavy metal
                Doom Metal
                Stoner Metal
                Sludge Metal
                Black Metal
                Symphonic Metal
                Power metal
                speed metal


                Punk Rock
                Post*Punk
                Garage Punk
                Fantasy Punk

                Electronic
                Drum & Bass
                Liquid Drum & Bass
                Atmospheric Drum & Bass
                Intelligent Drum & Bass
                Jump*Up
                Liquid Funk
                Techstep
                Jungle
                Ragga Jungle
                Halftime
                Dubstep
                Technoid
                Tech House
                House
                Afro House
                Deep House
                Jazzy House
                Organic house
                Progressive house
                Electro House
                Garage House
                Funky house
                Chicago House
                Disco house
                UK garage
                Future Garage
                Big Beat
                Breakbeat
                Future Breaks
                Breaks
                Hardcore Breakbeat
                Hardcore Breaks
                Oldschool Hardcore
                Tekno
                Techno
                Acid techno
                Trance
                Progressive trance
                Psytrance
                Psybient
                Psychill
                Electro*Swing

                Beats
                Chill beats
                downtempo
                chill hop
                lofi beats
                instrumental hip hop
                Trip*Hop
                Jazzy Beats
                Funky Beats
                Hip*Hop
                old school hip Hop
                hardcore hip hop
                gangsta rap
                rap
                conscious hip Hop
                Underground hip hop
                Abstract hip hop
                jazz rap
                jazzy hip hop
                west coast
                east coast
                rap français
                
                blues
                blues Rock
                desert blues

                Reggae
                Roots Reggae
                Dub

                Folk
                Contemporary Folk
                Neofolk
                Folk rock
                Singer*Songwriter
                minimal folk
                Traditional
                Acoustic
                Instrumental
                Afro Folk
                country
                Alt*country
                bluegrass

                Funk
                Modern Funk
                Deep Funk
                Electrofunk
                Future Funk
                Jazz Funk
                Mellow Funk
                Psychedelic Funk
                Latin Funk
                Afro Funk

                R&B
                Soul
                Smooth Soul
                Blue-Eyed Soul
                Neo*Soul
                New Jack Swing
                Contemporary R&B
                Alternative R&B
                Vocal Soul
                Instrumental Soul

                Classical
                Modern Classical

                Jazz
                Piano Jazz
                Nu Jazz
                Smooth Jazz
                spiritual jazz
                Jazz Fusion
                Fusion Jazz
                Jazz Funk
                Jazz Rock
                Electro Jazz
                Contemporary Jazz
                Post*Bop
                Bop
                Bebop
                hard bop
                free jazz
                experimental jazz
                piano solo
                gypsy jazz
                gypsy swing
                jazz manouche
                Jazz Standards
                Stride
                Dark Jazz
                Jazz Noir
                Acid Jazz
                Latin Jazz
                Japanese Jazz
                Ethio Jazz
                Arabic Jazz
                oriental Jazz

                Disco
                Nu Disco

                Cumbia
                Mambo
                Funana
                Bomba
                Calypso
                Samba
                Salsa
                Descarga
                MPB
                Flamenco
                Tango
                Bossa nova


                Pop
                Synthpop
                Electropop
                Electro Pop
                Hyperpop
                Indie Pop
                Pop Rap
                Dream pop
                Afropop
                Chamber Pop
                Art Pop
                
                Vocal
                USA
                french
                chanson française
                Italian
                Japanese
                Turkish
                Greek
                Greek Traditional
                African
                West African
                East African
                South African
                Central African
                latin
                songhai music
                

                soundtrack
                video game
                Arrange
                8*bit
                movie
                TV series
                TV)