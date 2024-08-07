�X�z�H��R�[�K    2   &r�H3��@����W�~+  SOURCE
$if([%SOURCE%],[%SOURCE%],$if($strstr($lower([%WEBSITE%]),music.apple.com),Apple Music,$if($strstr($lower([%WEBSITE%]),amazon),Amazon Music,$if($strstr($lower([%WEBSITE%]),deezer),Deezer,$if($strstr($lower([%WEBSITE%]),tidal),Tidal,$if($strstr($lower([%COMMENT%]),bandcamp.com),Bandcamp))))))&r�H3��@����W�~&   TITLE
$replace(%title%,' [Mixed]',' ')&r�H3��@����W�~&   TITLE
$replace(%title%,' (Mixed)',' ')&r�H3��@����W�~%   TITLE
$replace(%title%,' (Live)',' ')&r�H3��@����W�~+   TITLE
$replace(%title%,' (Remastered)',' ')&r�H3��@����W�~.   TITLE
$replace(%title%,' (Album Version)',' ')&r�H3��@����W�~%   TITLE
$replace(%title%,' (Live)',' ')w ��$�6A��c�4�6I   %title% (%REMIXER% Remix)
$ifgreater($strstr([%title%],Remix),0,%title%,)w ��$�6A��c�4�6I   %title% (%REMIXER% remix)
$ifgreater($strstr([%title%],remix),0,%title%,)&r�H3��@����W�~%   TITLE
%title%[ '('%remixer% Remix')']&r�H3��@����W�~   TITLE
$trim([%title%])�Ô���H�0��!�Vt   ARTIST
ID
Unknown Artist
c&r�H3��@����W�~%   ARTIST
$replace(%artist%,'feat.','&')�Ô���H�0��!�Vt<   WEBSITE
https://www.deezer.com/au/
https://www.deezer.com/
c&r�H3��@����W�~6   WEBSITE
$replace([%WEBSITE%],deezer.com/au,deezer.com)&r�H3��@����W�~4   LABEL
$iflonger([%LABEL%],0,[%LABEL%],[%PUBLISHER%])&r�H3��@����W�~N   LABEL
$ifequal(1,$stricmp([%LABEL%],[%album artist%]),self-released,[%LABEL%])&r�H3��@����W�~>   LABEL
$iflonger([%DISCOGS_LABEL%],2,[%DISCOGS_LABEL%],%LABEL%)&r�H3��@����W�~H   CATALOG
$iflonger([%DISCOGS_CATALOG%],0,[%DISCOGS_CATALOG%],[%CATALOG%])&r�H3��@����W�~D   CATALOG
$iflonger([%CATALOGNUMBER%],0,[%CATALOGNUMBER%],[%CATALOG%])&r�H3��@����W�~;  COMMENT
$iflonger([%COMMENT%],15,[%COMMENT%],$if(%WEBSITE%,source: [%WEBSITE% ][| %codec% %__bitspersample%/$cut(%samplerate%,2)],$if($strstr($lower([%COMMENT%]),bandcamp),$if(%SOURCE%=Deezer,source: ,source: [%MEDIA% - ][%DISCOGS_LABEL% - ][%DISCOGS_CATALOG% ][| %codec% %__bitspersample%/$cut(%samplerate%,2)]))))z^H2�5�H��rlu��    &r�H3��@����W�~   YEAR
$cut(%date%,4)ӡ�R��(J�7q�$�   ARTIST
;ӡ�R��(J�7q�$�
   COMPOSER
;ӡ�R��(J�7q�$�   GENRE
;ӡ�R��(J�7q�$�   GENRE
/&r�H3��@����W�~�   COMMENT
$ifequal($mod(%length_samples%,588),0,[%COMMENT% | ]Sample count is divisible by 588',' suggesting CD origin,[%COMMENT%])&r�H3��@����W�~�   MEDIA
$if($or([%SOURCE%]=Deezer,[%SOURCE%]=Bandcamp,[%SOURCE%]=Beatport,[%SOURCE%]=Juno,[%SOURCE%]=Tidal,[%SOURCE%]=Qobuz,$strstr($lower([%COMMENT]),bandcamp.com),[%WEBSITE%]),WEB,[%MEDIA%])&r�H3��@����W�~�  RELEASETYPE
$if([%RELEASETYPE%],[%RELEASETYPE%],$if($or($strstr($lower(%album%),soundtrack),$strstr($lower(%album%),bande originale),$strstr(%album%, OST),$strstr($lower(%album%),sound track),$strstr($lower(%genre%),soundtrack),$strstr($lower(%genre%),films),$strstr($lower(%genre%),videogame),$strstr($lower(%genre%),video game),$strstr($lower(%genre%),videospiel),$strstr($lower(%genre%),jeux video),$strstr($lower(%genre%),score)),Soundtrack,$if([%totaltracks%],$ifgreater(3,[%totaltracks%],Single,),)))�Ô���H�0��!�Vt"   GENRE
Dance
Changeme; Electronic
n�Ô���H�0��!�Vt   GENRE
Electro
Electronic
n�Ô���H�0��!�Vt   GENRE
Hip-Hop
Hip Hop
n�Ô���H�0��!�Vt   GENRE
Rap
Hip Hop
n�^�ex�@���7!�y'   GENRE
Alternative; Films; Jeux vidéo
n&r�H3��@����W�~   TITLE
$trim([%title%])&r�H3��@����W�~!   ARTIST
$trim($meta_sep(artist,;))ӡ�R��(J�7q�$�   ARTIST
;&r�H3��@����W�~-   ALBUM ARTIST
$trim($meta_sep(album artist,;))ӡ�R��(J�7q�$�   ALBUM ARTIST
;&r�H3��@����W�~   ALBUM
$trim([%album%])&r�H3��@����W�~   DATE
$trim($meta_sep(date,;))ӡ�R��(J�7q�$�   DATE
;&r�H3��@����W�~   GENRE
$trim($meta_sep(genre,;))ӡ�R��(J�7q�$�   GENRE
;&r�H3��@����W�~%   COMPOSER
$trim($meta_sep(composer,;))ӡ�R��(J�7q�$�
   COMPOSER
;&r�H3��@����W�~'   PERFORMER
$trim($meta_sep(performer,;))ӡ�R��(J�7q�$�   PERFORMER
;&r�H3��@����W�~  ARTIST ORIGIN
$if([%ARTIST ORIGIN%],[%ARTIST ORIGIN%],$ifgreater($strstr($lower(Ratatat),$lower([%artist%])),0,French,)$ifgreater($strstr($lower(Phoenix),$lower([%artist%])),0,French?,)$ifgreater($strstr($lower(Eloi),$lower([%artist%])),0,French,)$ifgreater($strstr($lower(Observe since),$lower([%artist%])),0,USA,)$ifgreater($strstr($lower(Black Thought),$lower([%artist%])),0,USA,)$ifgreater($strstr($lower(),$lower([%artist%])),0,USA,)$ifgreater($strstr($lower(Scattle),$lower([%artist%])),0,USA,)$ifgreater($strstr($lower(Scattle),$lower([%artist%])),0,USA,)$ifgreater($strstr($lower(Soft Power),$lower([%artist%])),0,Finnish,)$ifgreater($strstr($lower(Puts Marie),$lower([%artist%])),0,Swiss,)$ifgreater($strstr($lower(C''mon Tigre),$lower([%artist%])),0,Italian,))