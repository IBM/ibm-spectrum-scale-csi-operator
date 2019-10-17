# IBM Spectrum Scale CSI Operator

[![Documentation Status](https://readthedocs.org/projects/ibm-spectrum-scale-csi-operator/badge/?version=latest)](https://ibm-spectrum-scale-csi-operator.readthedocs.io/en/latest/?badge=latest)

An Ansible based operator to run and manage the deployment of the 
[IBM Spectrum Scale CSI Driver](https://github.com/IBM/ibm-spectrum-scale-csi-driver)

This project was originally generated using [operator-sdk](https://github.com/operator-framework/operator-sdk).

> **WARNING** : This repository undergoing active development! If you encounter issues with any of the following 
> instructions, [_please open an issue_](https://github.com/IBM/ibm-spectrum-scale-csi-operator/issues).

## Setup from scratch
### Cloning the repository

>**WARNING** : This repository needs to be accessible in your `GOPATH`. In the development environment this was set to >`/root/go`, however this is at the discretion of the user.

Due to constraints in golang (relative paths are not supported in golang) you **_MUST_** clone this repository to the IBM directory in your go path. If this is not done, the `operator-sdk` build operation will fail.

``` bash
# Set up some helpful variables
export GOPATH=<your-go-path>
export IBM_DIR="$GOPATH/src/github.com/IBM"
export OPERATOR_DIR="$IBM_DIR/ibm-spectrum-scale-csi-operator"

# Ensure the dir is present then clone.
mkdir -p ${IBM_DIR}
cd ${IBM_DIR}
git clone https://github.com/IBM/ibm-spectrum-scale-csi-operator.git
```

If you are working out of a forked copy you can change your origin to match:

``` bash
git remote set-url origin <forked git repo>
git remote set-url upstream git@github.com:IBM/ibm-spectrum-scale-csi-operator.git

git pull origin
```

### Development environment setup

The development environment dependencies are managed using an ansible playbook for the IBM Spectrum Scale CSI Operator. If ansible is installed in your environment simply run the following command:

``` bash
ansible-playbook $GOPATH/src/github.com/IBM/ibm-spectrum-scale-csi-operator/ansible/dev-env-playbook.yaml
```

This script will do the following:
1. Install `python3`
2. Install `python3` requirements (`sphinx`, `operator-courier`)
3. Install `operator-sdk`
4. Ensure `go-1.13` is installed.


### Building the Image

To build the image the user must navigate to the operator directory (This directory structure is an artifact of the IBM Cloud Pak certification process). 

```
cd stable/ibm-spectrum-scale-csi-operator-bundle/operators/ibm-spectrum-scale-csi-operator
export GO111MODULE="on"
operator-sdk build csi-scale-operator

# If you want to use your
docker tag csi-scale-operator quay.io/mew2057/ibm-spectrum-scale-csi-operator:v0.0.1
```


## Deploying the Operator

### Option A: Manually

If you've built the image as outlined above and tagged it, you can easily run the following to deploy the operator manually:

```
kubectl create -f deploy/service_account.yaml
kubectl create -f deploy/role.yaml
kubectl create -f deploy/role_binding.yaml
kubectl create -f deploy/crds/csi-scale-operators_v1alpha1_podset_crd.yaml
kubectl create -f deploy/operator.yaml
```

At this point the operator is running and ready for use!

### Option B: Using OLM

> **NOTE** : This will be the prefered method, however, work is ongoing.


## Starting the CSI Driver

Once the operator is running the user needs to access the operator's API and request a deployment. This is done through
use of the `CSIScaleOperator` Custom Resource. This resource will be tuned to your environment. A sample of the file is given:

``` YAML
apiVersion: scale.ibm.com/v1alpha1
kind: 'CSIScaleOperator'
metadata:
    name: 'csi-scale-operator'
status: {}
spec:
  # Optional
  # ----
  # Attacher image for csi (actually attaches to the storage).
  attacher: "quay.io/k8scsi/csi-attacher:v1.0.0"
  
  # Provisioner image for csi (actually issues provision requests).
  provisioner:"quay.io/k8scsi/csi-provisioner:v1.0.0"
  
  # Sidecar container image for the csi spectrum scale plugin pods.
  driverRegistrar: "quay.io/k8scsi/csi-node-driver-registrar:v1.0.1"
  
  # Image name for the csi spectrum scale plugin container.
  spectrumScale: "quay.io/mew2057/ibm-spectrum-scale-csi-driver:v0.9.0"
  # ----
  
  # Required
  # ----
  # The path to the gpfs file system mounted on the host machine.
  scaleHostpath: "/ibm/fs1"

  # A collection of gpfs cluster properties for the csi driver to mount.
  clusters:
    # The cluster id of the gpfs cluster specified (mandatory).
    - id: "2120508922778391120"
      
      # A string specifying a secret resource name.
      secrets: "secret1"
      
      # Require a secure SSL connection to connect to GPFS.
      secureSslMode: false
      
      # A string specifying a cacert resource name.
      # cacert: <>
      
      # The primary file system for the GPFS cluster
      primary:
        # The name of the primary filesystem.
        primaryFS: "fs1"
        # The name of the primary fileset, created in primaryFS.
        primaryFset: "csiFset2"
        
      # A collection of targets for REST calls.
      restApi:
        # The hostname of the REST server.
        - guiHost: "GUI_HOST"
        
          # The port number running the REST server.
          # guiPort
        
  # ----

```
> **NOTE** : Work is ongoing to reduce the amount end users need to populate.

To acutally start the CSI Plugin run the following command

``` bash
kubectl apply -f deploy/spectrum_scale.yaml
```

To stop the CSI plugin you can run:

``` bash
kubectl delete -f deploy/spectrum_scale.yaml
```


## Uninstalling the CSI Operator

To remove the operator:
```
kubectl delete -f deploy/spectrum_scale.yaml
kubectl delete -f deploy/operator.yaml
kubectl delete -f deploy/role.yaml
kubectl delete -f deploy/role_binding.yaml
kubectl delete -f deploy/service_account.yaml
kubectl delete -f deploy/crds/csi-scale-operators_v1alpha1_podset_crd.yaml
```

Please note, this will completely destroy the operator and all associated resources.


