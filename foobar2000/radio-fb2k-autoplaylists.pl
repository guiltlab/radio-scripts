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