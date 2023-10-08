helm template mongodb . --namespace mongodb-operator > rendered-operator.yaml
sed -i 's/enterprise-//g' rendered-operator.yaml
sed -i 's/mongodb-operator-mongodb-webhook/mongodb-operator-webhook/g' rendered-operator.yaml
sed -i 's/mongodb-operator-mongodb-operator/mongodb-operator/g' rendered-operator.yaml
sed -i 's/quay.io\/mongodb/custom.repo\/data/g' rendered-operator.yaml

cat images.txt |egrep "agent|operator" | awk -F: '{printf "s/%s/%s-amd64/g\n", $2, $2}' | xargs -I {} bash -c "sed -i {} rendered-operator.yaml"
cat images.txt |egrep -v "agent|operator" | awk -F: '{printf "s/value: %s/value: %s-amd64/g\n", $2, $2}' | xargs -I {} bash -c "sed -i '{}' rendered-operator.yaml"