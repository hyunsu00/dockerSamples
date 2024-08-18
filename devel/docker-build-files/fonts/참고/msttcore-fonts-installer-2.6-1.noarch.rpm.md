# msttcore-fonts-installer-2.6-1.noarch.rpm

## 참고
- https://mscorefonts2.sourceforge.net/
- https://sourceforge.net/projects/mscorefonts2/
- https://sourceforge.net/projects/corefonts/
- https://sourceforge.net/projects/mscorefonts/

## 설치

`$ yum install https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm`

## 종속 패키지

```bash
$ yum install -y dejavu-fonts-common dejavu-sans-fonts fontpackages-filesystem freetype libpng 
$ yum install -y fontconfig
$ yum install -y libfontenc xorg-x11-font-utils cabextract
```

## 종속 패키지 설치 후

```bash
$ fc-list

/usr/share/fonts/dejavu/DejaVuSansCondensed-Oblique.ttf: DejaVu Sans,DejaVu Sans Condensed:style=Condensed Oblique,Oblique
/usr/share/fonts/dejavu/DejaVuSansCondensed-Bold.ttf: DejaVu Sans,DejaVu Sans Condensed:style=Condensed Bold,Bold
/usr/share/fonts/dejavu/DejaVuSans.ttf: DejaVu Sans:style=Book
/usr/share/fonts/dejavu/DejaVuSans-Bold.ttf: DejaVu Sans:style=Bold
/usr/share/fonts/dejavu/DejaVuSansCondensed.ttf: DejaVu Sans,DejaVu Sans Condensed:style=Condensed,Book
/usr/share/fonts/dejavu/DejaVuSans-ExtraLight.ttf: DejaVu Sans,DejaVu Sans Light:style=ExtraLight
/usr/share/fonts/dejavu/DejaVuSansCondensed-BoldOblique.ttf: DejaVu Sans,DejaVu Sans Condensed:style=Condensed Bold Oblique,Bold Oblique
/usr/share/fonts/dejavu/DejaVuSans-Oblique.ttf: DejaVu Sans:style=Oblique
/usr/share/fonts/dejavu/DejaVuSans-BoldOblique.ttf: DejaVu Sans:style=Bold Oblique
```

## msttcore 설치후

```bash
$ fc-list
/usr/share/fonts/dejavu/DejaVuSansCondensed-Oblique.ttf: DejaVu Sans,DejaVu Sans Condensed:style=Condensed Oblique,Oblique
/usr/share/fonts/dejavu/DejaVuSansCondensed-Bold.ttf: DejaVu Sans,DejaVu Sans Condensed:style=Condensed Bold,Bold
/usr/share/fonts/dejavu/DejaVuSans.ttf: DejaVu Sans:style=Book
/usr/share/fonts/dejavu/DejaVuSans-Bold.ttf: DejaVu Sans:style=Bold
/usr/share/fonts/dejavu/DejaVuSansCondensed.ttf: DejaVu Sans,DejaVu Sans Condensed:style=Condensed,Book
/usr/share/fonts/dejavu/DejaVuSans-ExtraLight.ttf: DejaVu Sans,DejaVu Sans Light:style=ExtraLight
/usr/share/fonts/dejavu/DejaVuSansCondensed-BoldOblique.ttf: DejaVu Sans,DejaVu Sans Condensed:style=Condensed Bold Oblique,Bold Oblique
/usr/share/fonts/dejavu/DejaVuSans-Oblique.ttf: DejaVu Sans:style=Oblique
/usr/share/fonts/dejavu/DejaVuSans-BoldOblique.ttf: DejaVu Sans:style=Bold Oblique

/usr/share/fonts/msttcore/candaraz.ttf: Candara:style=Bold Italic
/usr/share/fonts/msttcore/corbeli.ttf: Corbel:style=Italic
/usr/share/fonts/msttcore/timesbd.ttf: Times New Roman:style=Έντονα,Bold
/usr/share/fonts/msttcore/verdana.ttf: Verdana:style=Regular
/usr/share/fonts/msttcore/tahoma.ttf: Tahoma:style=Regular
/usr/share/fonts/msttcore/corbelz.ttf: Corbel:style=Bold Italic
/usr/share/fonts/msttcore/georgiai.ttf: Georgia:style=Italic,Cursiva
/usr/share/fonts/msttcore/impact.ttf: Impact:style=Regular,Standard
/usr/share/fonts/msttcore/ariali.ttf: Arial:style=Πλάγια,Italic
/usr/share/fonts/msttcore/andalemo.ttf: Andale Mono:style=Regular,normal
/usr/share/fonts/msttcore/courbd.ttf: Courier New:style=tučné,Bold
/usr/share/fonts/msttcore/timesi.ttf: Times New Roman:style=Πλάγια,Italic
/usr/share/fonts/msttcore/corbel.ttf: Corbel:style=Regular
/usr/share/fonts/msttcore/trebucbi.ttf: Trebuchet MS:style=Bold Italic,Negrita Cursiva
/usr/share/fonts/msttcore/constanb.ttf: Constantia:style=Bold
/usr/share/fonts/msttcore/georgiab.ttf: Georgia:style=Bold,Negreta
/usr/share/fonts/msttcore/calibri.ttf: Calibri:style=Regular
/usr/share/fonts/msttcore/comic.ttf: Comic Sans MS:style=Regular,normal
/usr/share/fonts/msttcore/consolab.ttf: Consolas:style=Bold
/usr/share/fonts/msttcore/verdanaz.ttf: Verdana:style=Bold Italic,Negreta cursiva
/usr/share/fonts/msttcore/cour.ttf: Courier New:style=Κανονικά,Regular
/usr/share/fonts/msttcore/consola.ttf: Consolas:style=Regular
/usr/share/fonts/msttcore/arialbi.ttf: Arial:style=Έντονα Πλάγια,Bold Italic
/usr/share/fonts/msttcore/georgiaz.ttf: Georgia:style=Bold Italic,Negreta cursiva
/usr/share/fonts/msttcore/times.ttf: Times New Roman:style=Standaard,Regular
/usr/share/fonts/msttcore/calibrii.ttf: Calibri:style=Italic
/usr/share/fonts/msttcore/courbi.ttf: Courier New:style=fed kursiv,Bold Italic
/usr/share/fonts/msttcore/constanz.ttf: Constantia:style=Bold Italic
/usr/share/fonts/msttcore/cambriab.ttf: Cambria:style=Bold
/usr/share/fonts/msttcore/corbelb.ttf: Corbel:style=Bold
/usr/share/fonts/msttcore/couri.ttf: Courier New:style=kurzíva,Italic
/usr/share/fonts/msttcore/constani.ttf: Constantia:style=Italic
/usr/share/fonts/msttcore/ariblk.ttf: Arial Black:style=Regular,Standard
/usr/share/fonts/msttcore/arial.ttf: Arial:style=Standaard,Regular
/usr/share/fonts/msttcore/candarai.ttf: Candara:style=Italic
/usr/share/fonts/msttcore/consolaz.ttf: Consolas:style=Bold Italic
/usr/share/fonts/msttcore/trebucit.ttf: Trebuchet MS:style=Italic,Cursiva
/usr/share/fonts/msttcore/constan.ttf: Constantia:style=Regular
/usr/share/fonts/msttcore/calibriz.ttf: Calibri:style=Bold Italic
/usr/share/fonts/msttcore/calibrib.ttf: Calibri:style=Bold
/usr/share/fonts/msttcore/trebuc.ttf: Trebuchet MS:style=Regular
/usr/share/fonts/msttcore/cambriaz.ttf: Cambria:style=Bold Italic
/usr/share/fonts/msttcore/candara.ttf: Candara:style=Regular
/usr/share/fonts/msttcore/webdings.ttf: Webdings:style=Regular,normal
/usr/share/fonts/msttcore/georgia.ttf: Georgia:style=Regular,obyčejné
/usr/share/fonts/msttcore/arialbd.ttf: Arial:style=Έντονα,Bold
/usr/share/fonts/msttcore/trebucbd.ttf: Trebuchet MS:style=Bold,Negrita
/usr/share/fonts/msttcore/cambriai.ttf: Cambria:style=Italic
/usr/share/fonts/msttcore/verdanab.ttf: Verdana:style=Bold,Fett
/usr/share/fonts/msttcore/comicbd.ttf: Comic Sans MS:style=Bold,Έντονα
/usr/share/fonts/msttcore/candarab.ttf: Candara:style=Bold
/usr/share/fonts/msttcore/consolai.ttf: Consolas:style=Italic
/usr/share/fonts/msttcore/verdanai.ttf: Verdana:style=Italic,Cursiva
/usr/share/fonts/msttcore/timesbi.ttf: Times New Roman:style=Έντονα Πλάγια,Bold Italic
```

## 수동 설치

```bash
$ yum install -y fontconfig libfontenc xorg-x11-font-utils cabextract
$ cp ./msttcore /usr/share/fonts/
$ fc-cache -f -v
```
