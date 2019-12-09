
Stop Plugin
===========

.. note:: For OpenShift environments, replace ``kubectl`` with  ``oc``

Stop the CSI Driver
-------------------

#. To stop and remove the driver: 

.. code-block:: bash

  # defined in previous steps
  cd ${OPERATOR_DIR}/stable/ibm-spectrum-scale-csi-operator-bundle/operators/ibm-spectrum-scale-csi-operator

  # The following removes the csi-driver
  kubectl delete -f deploy/crds/ibm-spectrum-scale-csi-operator-cr.yaml


Stop the CSI Operator
---------------------

#. To stop and remove the operator:

.. code-block:: bash

  # defined in previous steps
  cd ${OPERATOR_DIR}/stable/ibm-spectrum-scale-csi-operator-bundle/operators/ibm-spectrum-scale-csi-operator

  # The following removes the csi-operator
  kubectl delete -f deploy/operator.yaml
  kubectl delete -f deploy/role.yaml
  kubectl delete -f deploy/role_binding.yaml
  kubectl delete -f deploy/service_account.yaml
  kubectl delete -f deploy/crds/ibm-spectrum-scale-csi-operator-crd.yaml

Remove Namespace
----------------

#. To remove the namespace: 

.. code-block:: bash

  # defined in previous steps
  cd ${OPERATOR_DIR}/stable/ibm-spectrum-scale-csi-operator-bundle/operators/ibm-spectrum-scale-csi-operator

  # The following removes the namespace 
  kubectl delete -f deploy/namespace.yaml




