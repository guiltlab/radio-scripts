�X�z�H��R�[�K    %   �Ô���H�0��!�Vt   GENRE
dnb
Drum & Bass
n&r�H3��@����W�~~  GENRE
$ifequal($add($stricmp($meta(genre,0),jazz),$stricmp($meta(genre,1),jazz),$stricmp($meta(genre,2),jazz),$stricmp($meta(genre,3),jazz),$stricmp($meta(genre,4),jazz),$stricmp($meta(genre,5),jazz),$stricmp($meta(genre,6),jazz),$stricmp($meta(genre,7),jazz),$stricmp($meta(genre,8),jazz),$stricmp($meta(genre,9),jazz),$stricmp($meta(genre,10),jazz),$stricmp($meta(genre,11),jazz),$stricmp($meta(genre,12),jazz),$stricmp($meta(genre,13),jazz),$stricmp($meta(genre,14),jazz),$stricmp($meta(genre,15),jazz)),1,[%genre%],$if($or($strstr($lower(%genre%),contemporary jazz),$strstr($lower(%genre%),spiritual jazz),$strstr($lower(%genre%),nu jazz),$strstr($lower(%genre%),electro jazz),$strstr($lower(%genre%),afro jazz),$strstr($lower(%genre%),hard bop),$strstr($lower(%genre%),bebop),$strstr($lower(%genre%),post bop),$strstr($lower(%genre%),free jazz),$strstr($lower(%genre%),japanese jazz),$strstr($lower(%genre%),gypsy jazz),$strstr($lower(%genre%),jazz manouche),$strstr($lower(%genre%),jazz fusion),$strstr($lower(%genre%),afro cuban jazz),$strstr($lower(%genre%),south african jazz),$strstr($lower(%genre%),latin jazz)),[%genre%]; Jazz,[%genre%]))&r�H3��@����W�~�  GENRE
$if($not($strstr($lower(%genre%),electronic)),$if($or($strstr($lower(%genre%),house),$strstr($lower(%genre%),drum & bass),$strstr($lower(%genre%),jungle),$strstr($lower(%genre%),techno),$strstr($lower(%genre%),synthwave),$strstr($lower(%genre%),edm),$strstr($lower(%genre%),breakbeat),$strstr($lower(%genre%),breaks),$strstr($lower(%genre%),uk garage),$strstr($lower(%genre%),speed garage),$strstr($lower(%genre%),chiptune),$strstr($lower(%genre%),idm),$strstr($lower(%genre%),glitch hop),$strstr($lower(%genre%),dubstep),$strstr($lower(%genre%),brostep),$strstr($lower(%genre%),uk bass),$strstr($lower(%genre%),bass music)),[%genre%]; Electronic,[%genre%]),[%genre%])&r�H3��@����W�~   GENRE
$caps2([%genre%])ӡ�R��(J�7q�$�   GENRE
,ӡ�R��(J�7q�$�   GENRE
/ӡ�R��(J�7q�$�   GENRE
;w ��$�6A��c�4�6Q   %title% (%REMIXER% Remix)
$ifgreater($strstr($lower([%title%]),remix),0,%title%,)&r�H3��@����W�~,   TITLE
$trim(%title%[ '('%remixer% Remix')'])z^H2�5�H��rlu��    &r�H3��@����W�~D  ARTIST
$if($strstr($lower([%title%]),'('with),$puts(featuring,'('with)$puts(matchpos,$strstr($lower([%title%]),'('with)))$if($strstr($lower([%title%]),feat),$puts(featuring,feat)$puts(matchpos,$strstr($lower([%title%]),feat)))$if($strstr($lower([%title%]),feat.),$puts(featuring,feat.)$puts(matchpos,$strstr($lower([%title%]),feat.)))$if($strstr($lower([%title%]),'('feat.),$puts(featuring,'('feat.)$puts(matchpos,$strstr($lower([%title%]),'('feat.)))$if($strstr($lower([%title%]),featuring),$puts(featuring,featuring)$puts(matchpos,$strstr($lower([%title%]),featuring)))$if($strstr($lower([%title%]),'('featuring),$puts(featuring,'('featuring)$puts(matchpos,$strstr($lower([%title%]),'('featuring)))$if($get(matchpos),[%artist%;]$trim($replace($replace($substr(%title%,$get(matchpos),$len(%title%)),')',),$get(featuring),)),[%artist%])ӡ�R��(J�7q�$�   ARTIST
;ӡ�R��(J�7q�$�   ARTIST
feat.ӡ�R��(J�7q�$�   ARTIST
Feat.ӡ�R��(J�7q�$�   ARTIST
featuringӡ�R��(J�7q�$�   ARTIST
Featuringӡ�R��(J�7q�$�
   ARTIST
ft.ӡ�R��(J�7q�$�
   ARTIST
Ft.z^H2�5�H��rlu��    &r�H3��@����W�~#   ARTIST
$meta_sep(artist,', ',' & ')&r�H3��@����W�~	  TITLE
$if($strstr($lower([%title%]),'('with),$puts(featuring,'('with)$puts(matchpos,$strstr($lower([%title%]),'('with)))$if($strstr($lower([%title%]),feat),$puts(featuring,feat)$puts(matchpos,$strstr($lower([%title%]),feat)))$if($strstr($lower([%title%]),feat.),$puts(featuring,feat.)$puts(matchpos,$strstr($lower([%title%]),feat.)))$if($strstr($lower([%title%]),'('feat.),$puts(featuring,'('feat.)$puts(matchpos,$strstr($lower([%title%]),'('feat.)))$if($strstr($lower([%title%]),featuring),$puts(featuring,featuring)$puts(matchpos,$strstr($lower([%title%]),featuring)))$if($strstr($lower([%title%]),'('featuring),$puts(featuring,'('featuring)$puts(matchpos,$strstr($lower([%title%]),'('featuring)))$if($get(matchpos),$trim($substr(%title%,0,$sub($get(matchpos),1))),[%title%])&r�H3��@����W�~�   YEAR
$if(%ORIGINAL RELEASE DATE%,$cut(%ORIGINAL RELEASE DATE%,4),$if(%RECORDING DATE%,$cut(%RECORDING DATE%,4),$cut([%date%],4)))�Ô���H�0��!�Vt-   ALBUM ARTIST
Various Artist
Various Artists
n�Ô���H�0��!�Vt!   ALBUM ARTIST
VA
Various Artists
n&r�H3��@����W�~   TITLE
$trim([%title%])&r�H3��@����W�~   ALBUM
$trim([%album%])&r�H3��@����W�~   YEAR
$trim([%year%])&r�H3��@����W�~   ARTIST
$trim([%artist%])&r�H3��@����W�~  PLAYLIST
$if($strstr($lower(%genre%),modern funk),$if($not($strstr($lower(%PLAYLIST%),modern funk)),[%PLAYLIST%; ]Modern Funk,[%PLAYLIST%]),$if($and($strstr($lower(%PLAYLIST%),modern funk),$not($strstr($lower(%genre%),funk))),$replace([%PLAYLIST%],Modern Funk, ),[%PLAYLIST%]))&r�H3��@����W�~&  PLAYLIST
$if($strstr($lower(%genre%),jungle),$if($not($or($strstr($lower(%genre%),hardcore),$strstr($lower(%EXCLUDE%),jungle))),$if($not($strstr($lower(%PLAYLIST%),jungle)),[%PLAYLIST%; ]Jungle,[%PLAYLIST%])),$if($strstr($lower(%PLAYLIST%),jungle),$replace([%PLAYLIST%],Jungle, ),[%PLAYLIST%]))&r�H3��@����W�~�   PLAYLIST
$if($strstr($lower(%genre%),chiptune),$if($not($strstr($lower(%PLAYLIST%),chiptune)),[%PLAYLIST%; ]Chiptune,[%PLAYLIST%]),$if($strstr($lower(%PLAYLIST%),chiptune),$replace([%PLAYLIST%],Chiptune,),[%PLAYLIST%]))&r�H3��@����W�~   PLAYLIST
$caps2([%PLAYLIST%])&r�H3��@����W�~   PLAYLIST
$trim([%PLAYLIST%])&r�H3��@����W�~�   EXCLUDE
$if($strstr($lower([%genre%]),drumfunk),$if($not($strstr($lower([%EXCLUDE%]),funk)),$caps2([%EXCLUDE%;]Funk),$caps2([%EXCLUDE%])),$caps2([%EXCLUDE%]))&r�H3��@����W�~�   EXCLUDE
$if($strstr($lower([%genre%]),mellow funk),$if($not($strstr($lower([%EXCLUDE%]),modern funk)),$caps2([%EXCLUDE%;]Modern Funk),$caps2([%EXCLUDE%])),$caps2([%EXCLUDE%]))&r�H3��@����W�~   EXCLUDE
$caps2([%EXCLUDE%])&r�H3��@����W�~   EXCLUDE
$trim([%EXCLUDE%])