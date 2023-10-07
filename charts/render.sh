helm template mongodb ./enterprise-operator --namespace mongodb-operator > ./enterprise-operator/rendered-operator.yaml
sed -i 's/enterprise-//g' enterprise-operator/rendered-operator.yaml
sed -i 's/mongodb-operator-mongodb-webhook/mongodb-operator-webhook/g' enterprise-operator/rendered-operator.yaml
sed -i 's/mongodb-operator-mongodb-operator/mongodb-operator/g' enterprise-operator/rendered-operator.yaml
sed -i 's/quay.io\/mongodb/custom.repo\/data/g' enterprise-operator/rendered-operator.yaml