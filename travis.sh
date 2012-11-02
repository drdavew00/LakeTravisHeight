#!/bin/bash
 
date
 
echo "cp"
 
cp /home/drdavew/bin/traviscurrent /home/drdavew/bin/travisprevious
 
echo "wget"
 
wget --tries=2  -O - www.lcra.org/water/conditions/river_report.html > travis.barf
 
wget --tries=2  -O - www.lcra.org/water/conditions/river_report.html | sed -rn '\|The level of Lake Travis is| s|.*The level of Lake Travis is ([0-9.]+) ft msl.*$|\1|p'  > /home/drdavew/bin/traviscurrent
 
# echo "curl"
 
# curl -s checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//' > /home/drdavew/bin/whatismyipcurrent
 
echo "diff"
 
diff /home/drdavew/bin/traviscurrent /home/drdavew/bin/travisprevious > /home/drdavew/bin/travisdiff

travisdiffsize=$(stat -c%s /home/drdavew/bin/travisdiff)
 
echo "travisdiffsize:"
echo $travisdiffsize
 
if [ $travisdiffsize -ne 0 ]

then 
 
echo "mutt"
mutt -s "Whatistraviscurrent" drdavew00@gmail.com < /home/drdavew/bin/traviscurrent
 
fi
 
