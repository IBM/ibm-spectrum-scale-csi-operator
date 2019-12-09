
Start Plugin
============

.. note:: For OpenShift environments, replace ``kubectl`` with  ``oc``

Create Namespace
----------------

#. Create the namespace 

.. code-block:: bash

  # defined in previous steps
  cd ${OPERATOR_DIR}/stable/ibm-spectrum-scale-csi-operator-bundle/operators/ibm-spectrum-scale-csi-operator

  # The following creates the namespace
  kubectl apply -f deploy/namespace.yaml

Start the CSI Operator
----------------------

#. Start the operator: 

.. code-block:: bash

  # defined in previous steps
  cd ${OPERATOR_DIR}/stable/ibm-spectrum-scale-csi-operator-bundle/operators/ibm-spectrum-scale-csi-operator

  # The following starts the csi-operator
  kubectl apply -f deploy/operator.yaml
  kubectl apply -f deploy/role.yaml
  kubectl apply -f deploy/role_binding.yaml
  kubectl apply -f deploy/service_account.yaml
  kubectl apply -f deploy/crds/ibm-spectrum-scale-csi-operator-crd.yaml
  
  
Start the CSI Driver
--------------------

.. note:: Before starting the driver add any Spectrum Scale GUI secrets to the appropriate namespace. 

A Custom Resource (CR) file is provided `deploy/crds/ibm-spectrum-scale-csi-operator-cr.yaml <https://raw.githubusercontent.com/IBM/ibm-spectrum-scale-csi-operator/master/stable/ibm-spectrum-scale-csi-operator-bundle/operators/ibm-spectrum-scale-csi-operator/deploy/crds/ibm-spectrum-scale-csi-operator-cr.yaml>`_. 

#. Edit this file to match the properties in your environment.

#. To start the driver: 

.. code-block:: bash

  # defined in previous steps
  cd ${OPERATOR_DIR}/stable/ibm-spectrum-scale-csi-operator-bundle/operators/ibm-spectrum-scale-csi-operator

  # The following starts the csi-driver
  kubectl apply -f deploy/crds/ibm-spectrum-scale-csi-operator-cr.yaml
