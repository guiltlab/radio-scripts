�X�z�H��R�[�K    8   �Ô���H�0��!�Vt   GENRE
hip-hop
Hip Hop
n�Ô���H�0��!�Vt!   GENRE
liquid
Liquid Drum & Bass
n�Ô���H�0��!�Vt(   GENRE
atmo dnb
Atmospheric Drum & Bass
n�Ô���H�0��!�Vt   GENRE
dnb
Drum & Bass
nӡ�R��(J�7q�$�   GENRE
,ӡ�R��(J�7q�$�   GENRE
,ӡ�R��(J�7q�$�   GENRE
\\ӡ�R��(J�7q�$�   GENRE
/&r�H3��@����W�~�  GENRE
$ifgreater($add($stricmp($meta(genre,0),jazz),$stricmp($meta(genre,1),jazz),$stricmp($meta(genre,2),jazz),$stricmp($meta(genre,3),jazz),$stricmp($meta(genre,4),jazz),$stricmp($meta(genre,5),jazz),$stricmp($meta(genre,6),jazz),$stricmp($meta(genre,7),jazz),$stricmp($meta(genre,8),jazz),$stricmp($meta(genre,9),jazz),$stricmp($meta(genre,10),jazz),$stricmp($meta(genre,11),jazz),$stricmp($meta(genre,12),jazz),$stricmp($meta(genre,13),jazz),$stricmp($meta(genre,14),jazz),$stricmp($meta(genre,15),jazz)),0,[%genre%],$if($or($strstr($lower(%genre%),contemporary jazz),$strstr($lower(%genre%),spiritual jazz),$strstr($lower(%genre%),nu jazz),$strstr($lower(%genre%),electro jazz),$strstr($lower(%genre%),afro jazz),$strstr($lower(%genre%),hard bop),$strstr($lower(%genre%),bebop),$strstr($lower(%genre%),post bop),$strstr($lower(%genre%),free jazz),$strstr($lower(%genre%),japanese jazz),$strstr($lower(%genre%),gypsy jazz),$strstr($lower(%genre%),jazz manouche),$strstr($lower(%genre%),jazz fusion),$strstr($lower(%genre%),afro cuban jazz),$strstr($lower(%genre%),south african jazz),$strstr($lower(%genre%),latin jazz)),[%genre%]; Jazz,[%genre%]))ӡ�R��(J�7q�$�   GENRE
,&r�H3��@����W�~�  GENRE
$ifgreater($add($stricmp($meta(genre,0),house),$stricmp($meta(genre,1),house),$stricmp($meta(genre,2),house),$stricmp($meta(genre,3),house),$stricmp($meta(genre,4),house),$stricmp($meta(genre,5),house),$stricmp($meta(genre,6),house),$stricmp($meta(genre,7),house),$stricmp($meta(genre,8),house),$stricmp($meta(genre,9),house),$stricmp($meta(genre,10),house),$stricmp($meta(genre,11),house),$stricmp($meta(genre,12),house),$stricmp($meta(genre,13),house),$stricmp($meta(genre,14),house),$stricmp($meta(genre,15),house)),0,[%genre%],$if($or($strstr($lower(%genre%),deep house),$strstr($lower(%genre%),jazzy house),$strstr($lower(%genre%),disco house),$strstr($lower(%genre%),french house),$strstr($lower(%genre%),afro house),$strstr($lower(%genre%),tech house),$strstr($lower(%genre%),tribal house),$strstr($lower(%genre%),funky house),$strstr($lower(%genre%),progressive house),$strstr($lower(%genre%),melodic house)),[%genre%]; House,[%genre%]))ӡ�R��(J�7q�$�   GENRE
,&r�H3��@����W�~�  GENRE
$if($not($strstr($lower(%genre%),electronic)),$if($or($strstr($lower(%genre%),house),$strstr($lower(%genre%),drum & bass),$strstr($lower(%genre%),jungle),$strstr($lower(%genre%),techno),$strstr($lower(%genre%),synthwave),$strstr($lower(%genre%),edm),$strstr($lower(%genre%),breakbeat),$strstr($lower(%genre%),breaks),$strstr($lower(%genre%),uk garage),$strstr($lower(%genre%),speed garage),$strstr($lower(%genre%),chiptune),$strstr($lower(%genre%),idm),$strstr($lower(%genre%),glitch hop),$strstr($lower(%genre%),dubstep),$strstr($lower(%genre%),brostep),$strstr($lower(%genre%),uk bass),$strstr($lower(%genre%),bass music)),[%genre%]; Electronic,[%genre%]),[%genre%])&r�H3��@����W�~8   GENRE
$trim($replace($replace([%genre%],'	',),'  ',' '))&r�H3��@����W�~   GENRE
$caps2([%genre%])ӡ�R��(J�7q�$�   GENRE
,ӡ�R��(J�7q�$�   GENRE
;w ��$�6A��c�4�6R   %title% (%REMIXER% Remix)
$ifgreater($strstr($lower([%title%]), remix),0,%title%,)&r�H3��@����W�~,   TITLE
$trim(%title%[ '('%remixer% Remix')'])z^H2�5�H��rlu��    &r�H3��@����W�~�  ARTIST
$if($strstr($lower([%title%]),'('ft.),$puts(featuring,'('ft.)$puts(matchpos,$strstr($lower([%title%]),'('ft.)))$if($strstr($lower([%title%]),'('with),$puts(featuring,'('with)$puts(matchpos,$strstr($lower([%title%]),'('with)))$if($strstr($lower([%title%]),feat),$puts(featuring,feat)$puts(matchpos,$strstr($lower([%title%]),feat)))$if($strstr($lower([%title%]),feat.),$puts(featuring,feat.)$puts(matchpos,$strstr($lower([%title%]),feat.)))$if($strstr($lower([%title%]),'('feat.),$puts(featuring,'('feat.)$puts(matchpos,$strstr($lower([%title%]),'('feat.)))$if($strstr($lower([%title%]),featuring),$puts(featuring,featuring)$puts(matchpos,$strstr($lower([%title%]),featuring)))$if($strstr($lower([%title%]),'('featuring),$puts(featuring,'('featuring)$puts(matchpos,$strstr($lower([%title%]),'('featuring)))$if($get(matchpos),[%artist%;]$trim($replace($replace($substr(%title%,$get(matchpos),$len(%title%)),')',),$get(featuring),)),[%artist%])ӡ�R��(J�7q�$�   ARTIST
;ӡ�R��(J�7q�$�   ARTIST
feat.ӡ�R��(J�7q�$�   ARTIST
Feat.ӡ�R��(J�7q�$�   ARTIST
featuringӡ�R��(J�7q�$�   ARTIST
Featuringӡ�R��(J�7q�$�
   ARTIST
ft.ӡ�R��(J�7q�$�
   ARTIST
Ft.z^H2�5�H��rlu��    &r�H3��@����W�~#   ARTIST
$meta_sep(artist,', ',' & ')&r�H3��@����W�~x  TITLE
$if($strstr($lower([%title%]),'('ft.),$puts(featuring,'('ft.)$puts(matchpos,$strstr($lower([%title%]),'('ft.)))$if($strstr($lower([%title%]),'('with),$puts(featuring,'('with)$puts(matchpos,$strstr($lower([%title%]),'('with)))$if($strstr($lower([%title%]),feat),$puts(featuring,feat)$puts(matchpos,$strstr($lower([%title%]),feat)))$if($strstr($lower([%title%]),feat.),$puts(featuring,feat.)$puts(matchpos,$strstr($lower([%title%]),feat.)))$if($strstr($lower([%title%]),'('feat.),$puts(featuring,'('feat.)$puts(matchpos,$strstr($lower([%title%]),'('feat.)))$if($strstr($lower([%title%]),featuring),$puts(featuring,featuring)$puts(matchpos,$strstr($lower([%title%]),featuring)))$if($strstr($lower([%title%]),'('featuring),$puts(featuring,'('featuring)$puts(matchpos,$strstr($lower([%title%]),'('featuring)))$if($get(matchpos),$trim($substr(%title%,0,$sub($get(matchpos),1))),[%title%])&r�H3��@����W�~�   YEAR
$if(%ORIGINAL RELEASE DATE%,$cut(%ORIGINAL RELEASE DATE%,4),$if(%RECORDING DATE%,$cut(%RECORDING DATE%,4),$cut([%date%],4)))�Ô���H�0��!�Vt-   ALBUM ARTIST
Various Artist
Various Artists
n�Ô���H�0��!�Vt!   ALBUM ARTIST
VA
Various Artists
n&r�H3��@����W�~8   TITLE
$trim($replace($replace([%title%],'	',),'  ',' '))&r�H3��@����W�~8   ALBUM
$trim($replace($replace([%album%],'	',),'  ',' '))&r�H3��@����W�~   YEAR
$trim([%year%])&r�H3��@����W�~:   ARTIST
$if([%ARTIST STRING%],[%ARTIST STRING%],[%ARTIST%])&r�H3��@����W�~:   ARTIST
$trim($replace($replace([%artist%],'	',),'  ',' '))&r�H3��@����W�~  PLAYLIST
$if($strstr($lower(%genre%),modern funk),$if($not($strstr($lower(%PLAYLIST%),modern funk)),[%PLAYLIST%; ]Modern Funk,[%PLAYLIST%]),$if($and($strstr($lower(%PLAYLIST%),modern funk),$not($strstr($lower(%genre%),funk))),$replace([%PLAYLIST%],Modern Funk, ),[%PLAYLIST%]))&r�H3��@����W�~&  PLAYLIST
$if($strstr($lower(%genre%),jungle),$if($not($or($strstr($lower(%genre%),hardcore),$strstr($lower(%EXCLUDE%),jungle))),$if($not($strstr($lower(%PLAYLIST%),jungle)),[%PLAYLIST%; ]Jungle,[%PLAYLIST%])),$if($strstr($lower(%PLAYLIST%),jungle),$replace([%PLAYLIST%],Jungle, ),[%PLAYLIST%]))&r�H3��@����W�~�   PLAYLIST
$if($strstr($lower(%genre%),chiptune),$if($not($strstr($lower(%PLAYLIST%),chiptune)),[%PLAYLIST%; ]Chiptune,[%PLAYLIST%]),$if($strstr($lower(%PLAYLIST%),chiptune),$replace([%PLAYLIST%],Chiptune,),[%PLAYLIST%]))&r�H3��@����W�~   PLAYLIST
$caps2([%PLAYLIST%])&r�H3��@����W�~   PLAYLIST
$trim([%PLAYLIST%])&r�H3��@����W�~�   EXCLUDE
$if($strstr($lower([%genre%]),drumfunk),$if($not($strstr($lower([%EXCLUDE%]),funk)),$caps2([%EXCLUDE%;]Funk),$caps2([%EXCLUDE%])),$caps2([%EXCLUDE%]))&r�H3��@����W�~�   EXCLUDE
$if($strstr($lower([%genre%]),mellow funk),$if($not($strstr($lower([%EXCLUDE%]),modern funk)),$caps2([%EXCLUDE%;]Modern Funk),$caps2([%EXCLUDE%])),$caps2([%EXCLUDE%]))&r�H3��@����W�~   EXCLUDE
$caps2([%EXCLUDE%])&r�H3��@����W�~   EXCLUDE
$trim([%EXCLUDE%])ӡ�R��(J�7q�$�	   EXCLUDE
,&r�H3��@����W�~P   ARTIST ORIGIN
$trim($caps2($replace($replace([%ARTIST ORIGIN%],'	',),'  ',' ')))ӡ�R��(J�7q�$�   ARTIST ORIGIN
;ӡ�R��(J�7q�$�   ARTIST ORIGIN
,&r�H3��@����W�~F   LANGUAGE
$trim($caps2($replace($replace([%LANGUAGE%],'	',),'  ',' ')))ӡ�R��(J�7q�$�
   LANGUAGE
;ӡ�R��(J�7q�$�
   LANGUAGE
,&r�H3��@����W�~�   TRACKNUMBER
$trim($if([%tracknumber%],$iflonger([%tracknumber%],2,$if($puts(truncate_position,$strchr([%tracknumber%],/)),$cut([%tracknumber%],$sub($get(truncate_position),1)),[%tracknumber%]),[%tracknumber%])))