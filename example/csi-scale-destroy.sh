#!/bin/bash

kubectl delete csiscaleoperators --all
kubectl delete -f deploy/spectrum_scale.yaml
kubectl delete -f deploy/operator.yaml
kubectl delete -f deploy/role.yaml
kubectl delete -f deploy/role_binding.yaml
kubectl delete -f deploy/service_account.yaml
kubectl delete -f deploy/crds/csi-scale-operators_v1alpha1_podset_crd.yaml

