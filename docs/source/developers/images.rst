Deploy Image
============

To use the container image that you just built in the previous steps the image should be pushed to a container repository.

Container Repository
--------------------

The following container repositories are available: 

* **Quay.io (recommended)**

  Follow this tutorial to configure `quay.io <https://quay.io/tutorial/>`_. 
  
  Create a repository called ``ibm-spectrum-scale-csi-operator``.

* **Docker** 

  Deploying your own Docker registry is outside the scope if this document.  See `deploying <https://docs.docker.com/registry/deploying/>`_.

.. note:: This documentation will assume that the `quay.io <https://quay.io/>`_ path is being used. 


Pushing the Image
-----------------

Once a container repository is ready, use ``docker`` to tag the image, then push to the container repository.

This example uses the image: ``quay.io/<your-user>/ibm-spectrum-scale-csi-operator:v0.9.1`` 

.. code-block:: bash

  # Authenticate to quay.io
  docker login <credentials> quay.io

  # Tag the build 
  docker tag csi-scale-operator quay.io/<your-user>/ibm-spectrum-scale-csi-operator:v0.9.1

  # push the image
  docker push quay.io/<your-user>/ibm-spectrum-scale-csi-operator:v0.9.1


Update YAML
-----------

To consume your custom built image, the YAML files need to be updated to point at the image. 

This example uses the image: ``quay.io/<your-user>/ibm-spectrum-scale-csi-operator:v0.9.1`` 

.. code-block:: bash
  
  # defined in previous steps
  cd ${OPERATOR_DIR}/stable/ibm-spectrum-scale-csi-operator-bundle/operators/ibm-spectrum-scale-csi-operator

  # Update your deployment to point at your image
  hacks/change_deploy_image.py -i <quay.io/<your-user>/ibm-spectrum-scale-csi-operator:v0.9.1
```