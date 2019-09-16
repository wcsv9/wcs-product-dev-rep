#n=0
export env=$1
#status=`kubectl get deployment demoqaauthcrs-app |awk '{ print $5 }' | awk '{if (NR!=1) {print}}'`
# until [ $n -ge 5 ]
runtime="15 minute"
endtime=$(date -ud "$runtime" +%s)

while [[ $(date -u +%s) -le $endtime ]]
   do
   status=`kubectl get deployment $1-app |awk '{ print $5 }' | awk '{if (NR!=1) {print}}'`
   if [ $status = 1 ]; then

        echo "$status"
        break;
    else
     echo "$status"

     #n=$[$n+1]
sleep 10
fi
done

if [ $status = 1 ]; then

echo "POD is UP"
sleep 40

else
echo "POD is not coming up"
exit 3;
fi
