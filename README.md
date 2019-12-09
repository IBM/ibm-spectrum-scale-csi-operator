# IBM Spectrum Scale CSI Operator

[![Documentation Status](https://readthedocs.org/projects/ibm-spectrum-scale-csi-operator/badge/?version=latest)](https://ibm-spectrum-scale-csi-operator.readthedocs.io/en/latest/?badge=latest)

An Ansible based operator to run and manage the deployment of the 
[IBM Spectrum Scale CSI Driver](https://github.com/IBM/ibm-spectrum-scale-csi-driver)

This project was originally generated using [operator-sdk](https://github.com/operator-framework/operator-sdk).

## Report Bugs 

To file issues, suggestions, new features, please use our issue tracker to open an [issue](https://github.com/IBM/ibm-spectrum-scale-csi-operator/issues).

## Getting Started and Documentation 

To get started, see our [Documentation](https://ibm-spectrum-scale-csi-operator.rtfd.io/)

## Contributing

We welcome contributions to this project, see [Contributing](CONTRIBUTING.md) for more details.

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


