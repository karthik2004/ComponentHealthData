> health_data.txt


Ipaddress() {
out=$( ping -c 3 $2 | grep "packet loss")

received=$(echo "$out" | awk -F' ' '{print $4}')
transmitted=$(echo "$out" | awk -F' ' '{print $1}')
if [ $received -ne $transmitted ]; then         
        json="\"$1\":\"FAIL\""
        echo "$json"  >> health_data.txt
else

 json="\"$1\":\"PASS\""
 echo "$json" >> health_data.txt
fi
}

Ipaddress Camera_Lane_1 192.168.92.165
Ipaddress Camera_Lane_2 192.168.92.166

