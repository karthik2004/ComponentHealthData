> health_data.txt


CephHealth() {

podname=$(kubectl get pods -n rook-ceph | grep 'rook-ceph-tools' | awk '{print $1}')
logs=$(kubectl exec -it "$podname" -n rook-ceph -- sh -c "ceph status")
if [ -z "$logs" ]
then
    json="\"Ceph_Health\":\"FAIL\""
    echo "$json"  >> health_data.txt
else
        requiredData=$(echo "$logs" | grep 'HEALTH_OK' )
    if [ -z "$requiredData" ]
    then
      
       json="\"Ceph_Health\":\"FAIL\""
       echo "$json"  >> health_data.txt

    else
       
       json="\"Ceph_Health\":\"PASS\""
       echo "$json"  >> health_data.txt

    fi
fi


}


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
Ipaddress HME_Connection 192.168.92.160
Ipaddress SE_AB 192.168.92.168
CephHealth
