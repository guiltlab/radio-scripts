�X�z�H��R�[�K       ӡ�R��(J�7q�$�   GENRE
,ӡ�R��(J�7q�$�   GENRE
/w ��$�6A��c�4�6Q   %title% (%REMIXER% Remix)
$ifgreater($strstr($lower([%title%]),remix),0,%title%,)&r�H3��@����W�~,   TITLE
$trim(%title%[ '('%remixer% Remix')'])z^H2�5�H��rlu��    &r�H3��@����W�~D  ARTIST
$if($strstr($lower([%title%]),'('with),$puts(featuring,'('with)$puts(matchpos,$strstr($lower([%title%]),'('with)))$if($strstr($lower([%title%]),feat),$puts(featuring,feat)$puts(matchpos,$strstr($lower([%title%]),feat)))$if($strstr($lower([%title%]),feat.),$puts(featuring,feat.)$puts(matchpos,$strstr($lower([%title%]),feat.)))$if($strstr($lower([%title%]),'('feat.),$puts(featuring,'('feat.)$puts(matchpos,$strstr($lower([%title%]),'('feat.)))$if($strstr($lower([%title%]),featuring),$puts(featuring,featuring)$puts(matchpos,$strstr($lower([%title%]),featuring)))$if($strstr($lower([%title%]),'('featuring),$puts(featuring,'('featuring)$puts(matchpos,$strstr($lower([%title%]),'('featuring)))$if($get(matchpos),[%artist%;]$trim($replace($replace($substr(%title%,$get(matchpos),$len(%title%)),')',),$get(featuring),)),[%artist%])ӡ�R��(J�7q�$�   ARTIST
;z^H2�5�H��rlu��    &r�H3��@����W�~#   ARTIST
$meta_sep(artist,', ',' & ')&r�H3��@����W�~	  TITLE
$if($strstr($lower([%title%]),'('with),$puts(featuring,'('with)$puts(matchpos,$strstr($lower([%title%]),'('with)))$if($strstr($lower([%title%]),feat),$puts(featuring,feat)$puts(matchpos,$strstr($lower([%title%]),feat)))$if($strstr($lower([%title%]),feat.),$puts(featuring,feat.)$puts(matchpos,$strstr($lower([%title%]),feat.)))$if($strstr($lower([%title%]),'('feat.),$puts(featuring,'('feat.)$puts(matchpos,$strstr($lower([%title%]),'('feat.)))$if($strstr($lower([%title%]),featuring),$puts(featuring,featuring)$puts(matchpos,$strstr($lower([%title%]),featuring)))$if($strstr($lower([%title%]),'('featuring),$puts(featuring,'('featuring)$puts(matchpos,$strstr($lower([%title%]),'('featuring)))$if($get(matchpos),$trim($substr(%title%,0,$sub($get(matchpos),1))),[%title%])&r�H3��@����W�~P   YEAR
$if(%ORIGINAL RELEASE DATE%,$cut(%ORIGINAL RELEASE DATE%,4),$cut(%date%,4))�Ô���H�0��!�Vt-   ALBUM ARTIST
Various Artist
Various Artists
n�Ô���H�0��!�Vt!   ALBUM ARTIST
VA
Various Artists
n&r�H3��@����W�~   TITLE
$trim([%title%])&r�H3��@����W�~   ALBUM
$trim([%album%])&r�H3��@����W�~   YEAR
$trim([%year%])&r�H3��@����W�~   ARTIST
$trim([%artist%])&r�H3��@����W�~�   PLAYLIST
$if($and($strstr($lower(%genre%),modern funk),$not($strstr($lower(%PLAYLIST%),modern funk))),[%PLAYLIST%; ]Modern Funk,[%PLAYLIST%])&r�H3��@����W�~~   PLAYLIST
$if($and($strstr($lower(%genre%),jungle),$not($strstr($lower(%PLAYLIST%),jungle))),[%PLAYLIST%; ]Jungle,[%PLAYLIST%])