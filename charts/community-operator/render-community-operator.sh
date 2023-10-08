helm template mongodb . --namespace mongodb-operator > rendered-operator.yaml
sed -i 's/mongodb-kubernetes/mongodb/g' rendered-operator.yaml
sed -i 's/quay.io\/mongodb/custom.repo\/data/g' rendered-operator.yaml
sed -i 's/docker.io\/mongo/custom.repo\/data/g' rendered-operator.yaml

cat images.txt | awk -F: '{printf "s/%s/%s-amd64/g\n", $2, $2}' | xargs -I {} bash -c "sed -i {} rendered-operator.yaml"