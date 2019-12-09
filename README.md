# IBM Spectrum Scale CSI Operator

[![Documentation Status](https://readthedocs.org/projects/ibm-spectrum-scale-csi-operator/badge/?version=latest)](https://ibm-spectrum-scale-csi-operator.readthedocs.io/en/latest/?badge=latest)

An Ansible based operator to run and manage the deployment of the 
[IBM Spectrum Scale CSI Driver](https://github.com/IBM/ibm-spectrum-scale-csi-driver)

This project was originally generated using [operator-sdk](https://github.com/operator-framework/operator-sdk).

## Getting Started and Documentation 

To get started, see our Documentation.[Documentation](http://ibm-spectrum-scale-csi-operator.rtfd.io/)

### Using the image

In order to use the images that you just built, the image needs to be pushed to some container repository.

* **Quay.io (recommended)**

  Follow this tutorial to configure [quay.io](https://quay.io/tutorial/) and then create a repository named: `ibm-spectrum-scale-csi-operator`.

* **Docker** 

  Deploying your own Docker registry is an [involved process](https://docs.docker.com/registry/deploying/), and outside of the scope of this document. 

The documentation will assume that the quay.io path is being used. 

Once you have a repository ready:

``` bash
# Authenticate to quay.io
docker login <credentials> quay.io

# Tag the build 
docker tag csi-scale-operator quay.io/<your-user>/ibm-spectrum-scale-csi-operator:v0.9.1

# push the image
docker push quay.io/<your-user>/ibm-spectrum-scale-csi-operator:v0.9.1

# Update your deployment to point at your image.
hacks/change_deploy_image.py -i quay.io/<your-user>/ibm-spectrum-scale-csi-operator:v0.9.1
```

## Deploying the Operator

> **WARNING** If you are using your own image you must, complete [using the image](#using-the-image)!

### Option A: Manually

If you've built the image as outlined above and tagged it, you can easily run the following to deploy the operator manually, for openshift use "oc" instead of "kubectl"

``` bash
cd ${OPERATOR_DIR}/stable/ibm-spectrum-scale-csi-operator-bundle/operators/ibm-spectrum-scale-csi-operator

kubectl apply -f deploy/namespace.yaml
kubectl apply -f deploy/service_account.yaml
kubectl apply -f deploy/role.yaml
kubectl apply -f deploy/role_binding.yaml
kubectl apply -f deploy/crds/ibm-spectrum-scale-csi-operator-crd.yaml
kubectl apply -f deploy/operator.yaml
```


> **NOTE**: Kubernetes uses `kubectl` the command, replace with `oc` if deploying in OpenShift.

At this point the operator is running and ready for use!

### Option B: Using Operator Lifecycle Manager (OLM)

> **NOTE**: This will be the prefered method.  However, work is ongoing.


> **NOTE**: Installing OLM is out of the scope of this document, please refer to [the official documentation](https://github.com/operator-framework/operator-lifecycle-manager/blob/master/doc/install/install.md). If you're still having trouble, [this guide goes even deeper](https://github.com/operator-framework/community-operators/blob/master/docs/testing-operators.md).

The following will subscribe the [quay.io](quay.io) version of the operator assuming OLM is installed.

``` bash
cd ${OPERATOR_DIR}/stable/ibm-spectrum-scale-csi-operator-bundle/operators/ibm-spectrum-scale-csi-operator

kubectl apply -f deploy/olm-scripts/operator-source.yaml
```
> **NOTE**: Kubernetes use `kubectl` command, replace with `oc` if deploying in OpenShift.
```
cd ${OPERATOR_DIR}/stable/ibm-spectrum-scale-csi-operator-bundle/operators/ibm-spectrum-scale-csi-operator

oc apply -f deploy/olm-scripts/operator-source-oc.yaml
```


## Starting the CSI Driver

Once the operator is running the user needs to access the operator's API and request a deployment. This is done through use of the `CSIScaleOperator` Custom Resource. 

> **ATTENTION** : If the driver pod does not start, it is generally due to missing secrets. 

Before starting the plugin, add any secrets to the appropriate namespace.  The Spectrum Scale namespace is `ibm-spectrum-scale-csi-driver`:

``` bash
kubectl apply -f secrets.yaml -n ibm-spectrum-scale-csi-driver
```

A sample of the file is provided [deploy/crds/ibm-spectrum-scale-csi-operator-cr.yaml](stable/ibm-spectrum-scale-csi-operator-bundle/operators/ibm-spectrum-scale-csi-operator/deploy/crds/ibm-spectrum-scale-csi-operator-cr.yaml). 

Modify this file to match the properties in your environment, then:

  * To start the CSI plugin, run: `kubectl apply -f deploy/crds/ibm-spectrum-scale-csi-operator-cr.yaml` 
  * To stop the CSI plugin, run: `kubectl delete -f deploy/crds/ibm-spectrum-scale-csi-operator-cr.yaml` 

## Uninstalling the CSI Operator

To remove the operator:

``` bash
kubectl delete -f deploy/crds/ibm-spectrum-scale-csi-operator-cr.yaml
kubectl delete -f deploy/operator.yaml
kubectl delete -f deploy/role.yaml
kubectl delete -f deploy/role_binding.yaml
kubectl delete -f deploy/service_account.yaml
kubectl delete -f deploy/crds/ibm-spectrum-scale-csi-operator-crd.yaml
kubectl delete -f deploy/namespace.yaml
```

> **NOTE**: Kubernetes use `kubectl` command, replace with `oc` if deploying in OpenShift.

This will completely destroy the operator and all associated resources.


### Open Shift Considerations

When uninstalling on OpenShift the operator creates a `SecurityContextConstraint`  named `csiaccess`.
This allows the driver to mount files in non default namespaces. 

To verify the `SecurityContextConstraint` is gone:

``` bash
kubectl get SecurityContextConstraints csiaccess

# If you get a result:
kubectl delete SecurityContextConstraints csiaccess
```

## Troubleshooting

See the [Troubleshooting](https://ibm-spectrum-scale-csi-operator.readthedocs.io/en/latest/troubleshoot/index.html) section for more information.


