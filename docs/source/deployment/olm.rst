Operator Lifecycle Manager (OLM)
--------------------------------

Install of Operator Lifecycle Manager (OLM) is outside the scope of this document.  Refer to the `official documentation <https://github.com/operator-framework/operator-lifecycle-manager/blob/master/doc/install/install.md>`_ for installation instructions. 

Using OLM will subscribe to the `quay.io <https://quay.io>`_ version of the operator.

.. note:: For OpenShift environments, replace ``kubectl`` with  ``oc``

1. Install OLM:

.. code-block:: bash

    curl -sL https://github.com/operator-framework/operator-lifecycle-manager/releases/download/0.11.0/install.sh | bash -s 0.11.0


2. Download the CSI Operator ``.yaml`` and apply

.. code-block:: bash

    curl https://raw.githubusercontent.com/IBM/ibm-spectrum-scale-csi-operator/master/stable/ibm-spectrum-scale-csi-operator-bundle/operators/ibm-spectrum-scale-csi-operator/deploy/olm-scripts/operator-source.yaml > operator-source.yaml

    kubectl apply -f operator-source.yaml

3. Log into the Console, search "IBM Spectrum Scale CSI Plugin" and Install the Operator 

