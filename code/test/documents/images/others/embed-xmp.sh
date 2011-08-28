name="Matthew Bohnsack"
email="bohnsack@gmail.com"
url="http://bohnsack.com/"

print_cmd () {
    image=$1
    name=$2
    url=$3
    lic=$4
    base_cmd="exiftool -overwrite_original -scanForXMP -XMP-cc:AttributionName=\"${name}\" -XMP-cc:attributionURL=\"${url}\" -XMP-cc:License=\""
    echo "${base_cmd}${lic}\" ${image}"
}

print_cmd "cc-by.jpg"       "Carl Friedrich Gauss"  "http://en.wikipedia.org/wiki/Carl_Friedrich_Gauss"  "http://creativecommons.org/licenses/by/3.0/"
print_cmd "cc-by-nc.jpg"    "Philipp Melanchthon"   "http://en.wikipedia.org/wiki/Philipp_Melanchthon"   "http://creativecommons.org/licenses/by-nc/3.0/"
print_cmd "cc-by-nc-nd.jpg" "Walter H. Schottky"    "http://en.wikipedia.org/wiki/Walter_H._Schottky"    "http://creativecommons.org/licenses/by-nc-nd/3.0/"
print_cmd "cc-by-nc-sa.jpg" "Johann Sebastian Bach" "http://en.wikipedia.org/wiki/Johann_Sebastian_Bach" "http://creativecommons.org/licenses/by-nc-sa/3.0/"
print_cmd "cc-by-nd.jpg"    "Thomas Jefferson"      "http://en.wikipedia.org/wiki/Thomas_Jefferson"      "http://creativecommons.org/licenses/by-nd/3.0/"
print_cmd "cc-by-sa.jpg"    "Arthur C. Mellette"    "http://en.wikipedia.org/wiki/Arthur_C._Mellette"    "http://creativecommons.org/licenses/by-sa/3.0/"
