Clone and Build
===============

Clone
-----

.. warning:: This repository needs to be accessible in your ``GOPATH`` and the examples below use the ``root`` user with ``GOPATH=/root/go``.

.. code-block:: bash

  #
  # Set up some helpful variables
  #
  export GOPATH="/root/go"
  export IBM_DIR="$GOPATH/src/github.com/IBM"

  #
  # Ensure the dir is present then clone.
  #
  mkdir -p ${IBM_DIR}
  cd ${IBM_DIR}
  git clone https://github.com/IBM/ibm-spectrum-scale-csi-operator.git

Build
-----

Configure Environment
`````````````````````

.. warning:: Playbook errors must be resolved before moving onto the next step.

To *help* assist in proper configuration of the build environment, a playbook is provided.

.. code-block:: bash

  ansible-playbook $GOPATH/src/github.com/IBM/ibm-spectrum-scale-csi-operator/ansible/dev-env-playbook.yaml


Build the the Image
```````````````````

.. note:: ``operator-sdk build`` requires ``docker``

Navigate to the operator directory and use ``operator-sdk`` command to build the container image.

.. code-block:: bash

  #
  # IBM_DIR is defined in the previous step
  #
  export OPERATOR_DIR="$IBM_DIR/ibm-spectrum-scale-csi-operator"
  cd ${OPERATOR_DIR}/stable/ibm-spectrum-scale-csi-operator-bundle/operators/ibm-spectrum-scale-csi-operator

  export GO111MODULE="on"
  operator-sdk build csi-scale-operator


