helm template mongodb ./enterprise-operator --namespace mongodb-operator |grep "quay.io" | awk -F ": |" '{print $2}' | sed 's/\"//g' > enterprise-operator/images.txt
