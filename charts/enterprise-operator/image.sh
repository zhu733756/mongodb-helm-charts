helm template mongodb . --namespace mongodb-operator |grep "quay.io" | awk -F ": |" '{print $2}' | sed 's/\"//g' > images.txt
