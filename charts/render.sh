helm template mongodb ./enterprise-operator --namespace mongodb-operator > ./enterprise-operator/rendered-operator.yaml
sed -i 's/enterprise-//g' enterprise-operator/rendered-operator.yaml
sed -i 's/mongodb-operator-mongodb-webhook/mongodb-operator-webhook/g' enterprise-operator/rendered-operator.yaml
sed -i 's/mongodb-operator-mongodb-operator/mongodb-operator/g' enterprise-operator/rendered-operator.yaml
sed -i 's/quay.io\/mongodb/custom.repo\/data/g' enterprise-operator/rendered-operator.yaml

cat enterprise-operator/images.txt |egrep "agent|operator" | awk -F: '{printf "s/%s/%s-amd64/g\n", $2, $2}' | xargs -I {} bash -c "sed -i {} enterprise-operator/rendered-operator.yaml"
cat enterprise-operator/images.txt |egrep -v "agent|operator" | awk -F: '{printf "s/value: %s/value: %s-amd64/g\n", $2, $2}' | xargs -I {} bash -c "sed -i '{}' enterprise-operator/rendered-operator.yaml"