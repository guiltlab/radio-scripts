$if([%RELEASETYPE%],
    [%RELEASETYPE%],
    $if($or($strstr($lower(%album%),soundtrack),
        $strstr($lower(%album%),bande originale),
        $strstr($lower(%album%), OST),$strstr($lower(%album%),sound track),$strstr($lower(%genre%),soundtrack),
        $strstr($lower(%genre%),films),$strstr($lower(%genre%),videogame),$strstr($lower(%genre%),video game),$strstr($lower(%genre%),videospiel)),
        Soundtrack,
        $if([%totaltracks%],
            $ifgreater(3,[%totaltracks%],Single,),)
            ))


$if([%RELEASETYPE%],[%RELEASETYPE%],$if($or($strstr($lower(%album%),soundtrack),$strstr($lower(%album%),bande originale),$strstr(%album%, OST),$strstr($lower(%album%),sound track),$strstr($lower(%genre%),soundtrack),$strstr($lower(%genre%),films),$strstr($lower(%genre%),videogame),$strstr($lower(%genre%),video game),$strstr($lower(%genre%),videospiel),$strstr($lower(%genre%),jeux video),$strstr($lower(%genre%),score)),Soundtrack,$if([%totaltracks%],$ifgreater(3,[%totaltracks%],Single,),)))


$if($or([%SOURCE%]=Deezer,[%SOURCE%]=Bandcamp,[%SOURCE%]=Beatport,[%SOURCE%]=Juno,[%SOURCE%]=Tidal,[%SOURCE%]=Qobuz,$strstr($lower([%COMMENT]),bandcamp.com),[%WEBSITE%]),WEB,[%MEDIA%])




$iflonger([%COMMENT%],15,[%COMMENT%],$if(%WEBSITE%,source: [%WEBSITE% ][| %codec% %__bitspersample%/$cut(%samplerate%,2)],$if($strstr($lower([%COMMENT%]),bandcamp),$if(%SOURCE%=Deezer,source: ,source: [%MEDIA% - ][%DISCOGS_LABEL% - ][%DISCOGS_CATALOG% ][| %codec% %__bitspersample%/$cut(%samplerate%,2)]))))

$if($strstr($lower([%WEBSITE%]),music.apple.com),Apple Music,
    $if($strstr($lower([%WEBSITE%]),amazon),Amazon Music,
        $if($strstr($lower([%WEBSITE%]),deezer),Deezer,
            $if($strstr($lower([%WEBSITE%]),tidal),Tidal,
            $if($strstr($lower([%COMMENT%]),bandcamp.com),Bandcamp)
            ))))

$if([%SOURCE%],[%SOURCE%],$if($strstr($lower([%WEBSITE%]),music.apple.com),Apple Music,$if($strstr($lower([%WEBSITE%]),amazon),Amazon Music,$if($strstr($lower([%WEBSITE%]),deezer),Deezer,$if($strstr($lower([%WEBSITE%]),tidal),Tidal,$if($strstr($lower([%COMMENT%]),bandcamp.com),Bandcamp))))))


$trim($meta_sep(composer,;))


// Trim all values of a multi-value tag and separate them with ; 
// Works for a maximum of 20 values - add more lines if necessary
// Need to split values according to ; separator afterwards, otherwise a literal ; stays

$if([%COMPOSER%],$puts(composers,0)$puts(target,$sub($meta_num(composer),1))
$ifgreater($get(composers),$get(target),,$trim($meta(composer,$get(composers)))
$puts(composers,$add($get(composers),1)))
$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))
$puts(composers,$add($get(composers),1)))
$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))
$puts(composers,$add($get(composers),1)))
$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))
$puts(composers,$add($get(composers),1)))
$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))
$puts(composers,$add($get(composers),1)))
$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))
$puts(composers,$add($get(composers),1)))
$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))
$puts(composers,$add($get(composers),1)))
$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))
$puts(composers,$add($get(composers),1)))
$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))
$puts(composers,$add($get(composers),1)))
$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))
$puts(composers,$add($get(composers),1)))
$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))
$puts(composers,$add($get(composers),1)))
$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))
$puts(composers,$add($get(composers),1)))
$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))
$puts(composers,$add($get(composers),1)))
$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))
$puts(composers,$add($get(composers),1)))
$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))
$puts(composers,$add($get(composers),1)))
$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))
$puts(composers,$add($get(composers),1)))
$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))
$puts(composers,$add($get(composers),1)))
$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))
$puts(composers,$add($get(composers),1)))
$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))
$puts(composers,$add($get(composers),1)))
$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))
$puts(composers,$add($get(composers),1)))
)


$if([%COMPOSER%],$puts(composers,0)$puts(target,$sub($meta_num(composer),1))$ifgreater($get(composers),$get(target),,$trim($meta(composer,$get(composers)))$puts(composers,$add($get(composers),1)))$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))$puts(composers,$add($get(composers),1)))$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))$puts(composers,$add($get(composers),1)))$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))$puts(composers,$add($get(composers),1)))$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))$puts(composers,$add($get(composers),1)))$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))$puts(composers,$add($get(composers),1)))$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))$puts(composers,$add($get(composers),1)))$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))$puts(composers,$add($get(composers),1)))$ifgreater($get(composers),$get(target),,;$trim($meta(composer,$get(composers)))$puts(composers,$add($get(composers),1))))

$if([%ARTIST ORIGIN%],[%ARTIST ORIGIN%],
$ifgreater($strstr($lower(Ratatat),$lower([%artist%])),0,French,)
$ifgreater($strstr($lower(Phoenix),$lower([%artist%])),0,French?,)
$ifgreater($strstr($lower(Eloi),$lower([%artist%])),0,French,)
$ifgreater($strstr($lower(Observe since),$lower([%artist%])),0,USA,)
$ifgreater($strstr($lower(Black Thought),$lower([%artist%])),0,USA,)
$ifgreater($strstr($lower(),$lower([%artist%])),0,USA,)
$ifgreater($strstr($lower(Scattle),$lower([%artist%])),0,USA,)
$ifgreater($strstr($lower(Scattle),$lower([%artist%])),0,USA,)
$ifgreater($strstr($lower(Soft Power),$lower([%artist%])),0,Finnish,)
$ifgreater($strstr($lower(Puts Marie),$lower([%artist%])),0,Swiss,)
$ifgreater($strstr($lower(C''mon Tigre),$lower([%artist%])),0,Italian,)
)

$if([%ARTIST ORIGIN%],[%ARTIST ORIGIN%],$ifgreater($strstr($lower(Ratatat),$lower([%artist%])),0,French,)$ifgreater($strstr($lower(Phoenix),$lower([%artist%])),0,French?,)$ifgreater($strstr($lower(Eloi),$lower([%artist%])),0,French,)$ifgreater($strstr($lower(Observe since),$lower([%artist%])),0,USA,)$ifgreater($strstr($lower(Black Thought),$lower([%artist%])),0,USA,)$ifgreater($strstr($lower(),$lower([%artist%])),0,USA,)$ifgreater($strstr($lower(Scattle),$lower([%artist%])),0,USA,)$ifgreater($strstr($lower(Scattle),$lower([%artist%])),0,USA,)$ifgreater($strstr($lower(Soft Power),$lower([%artist%])),0,Finnish,)$ifgreater($strstr($lower(Puts Marie),$lower([%artist%])),0,Swiss,)$ifgreater($strstr($lower(C''mon Tigre),$lower([%artist%])),0,Italian,))