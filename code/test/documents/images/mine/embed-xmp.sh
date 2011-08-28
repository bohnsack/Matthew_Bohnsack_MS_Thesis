name="Matthew Bohnsack"
email="bohnsack@gmail.com"
url="http://bohnsack.com/"
alt_cmd="exiftool -overwrite_original -scanForXMP -XMP-cc:License=\""
base_cmd="exiftool -overwrite_original -scanForXMP -XMP:OwnerName=\"${name} <${email}>\" -XMP-cc:AttributionName=\"${name}\" -XMP-cc:attributionURL=\"${url}\" -XMP-cc:License=\""

echo ${alt_cmd}http://creativecommons.org/publicdomain/zero/1.0/\"  cc0.jpg
echo ${base_cmd}http://creativecommons.org/licenses/by/3.0/\"       cc-by.jpg
echo ${base_cmd}http://creativecommons.org/licenses/by-nc/3.0/\"    cc-by-nc.jpg
echo ${base_cmd}http://creativecommons.org/licenses/by-nc-nd/3.0/\" cc-by-nc-nd.jpg
echo ${base_cmd}http://creativecommons.org/licenses/by-nc-sa/3.0/\" cc-by-nc-sa.jpg
echo ${base_cmd}http://creativecommons.org/licenses/by-nd/3.0/\"    cc-by-nd.jpg
echo ${base_cmd}http://creativecommons.org/licenses/by-sa/3.0/\"    cc-by-sa.jpg
