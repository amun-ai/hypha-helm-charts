# Hypha Helm Chart

This document details how to add the Hypha Helm chart repository, install the Hypha chart, manage values files, generate secrets, and check available chart versions. Additionally, it covers dependencies and the configuration for the Triton Inference Server, including how to load models from an S3-compatible service like Minio.

## Adding the Helm Chart Repository

To add the Hypha Helm chart repository, run the following command:

```
helm repo add hypha https://amun-ai.github.io/hypha-helm-charts/
```

## Installing the Helm Chart

You can install the Hypha Helm chart manually by specifying the chart directory and updating dependencies as follows:

```
helm install --generate-name hypha/hypha --dependency-update
```

## Using a Values File

To customize the installation, pass in a custom values.yaml file:

```
helm install --values values.yaml --generate-name hypha/hypha --dependency-update
```

## Generating a Secret

For creating secrets, such as passwords or keys, use:

```
openssl rand -base64 32
```

## Checking Available Versions

To see what versions of the Hypha chart are available, use:

```
helm search repo hypha --versions
```

# Dependencies

The chart has dependencies on Minio, Redis, and Triton. Note that these dependencies need to be installed as part of the chart installation; pre-existing installations cannot be used directly.

# Triton Inference Server
## Getting Models from S3

Models can be stored on an S3-compatible service like Minio. They can be loaded using a path format like s3::/minio/model-repository.

## Configuration

In the Triton configuration, you can customise the initContainers and volumes to load models from a storage service.

Example of mounting a volume for the Triton cache:

```
volumeMounts:
  - mountPath: /model-repository
    name: triton-cache
    subPath: model-repository
```

Example of an initContainer to synchronise models from an S3-compatible service:

```
  initContainers:
    - name: sync
      image: minio/mc
      command: ["/bin/sh"]
      args:
      - "-c"
      - |
        mc alias set bucket s3://bucket/model-repository
        mc mirror --overwrite bucket/model-repository/ /model-repository
      volumeMounts:
      - mountPath: /model-repository
        name: triton-cache
        subPath: model-repository
```

# Manually uploading models to the Bioengine

For situations where models need to be updated or added manually without using an S3-compatible service, you can use the kubectl cp command.
This allows you to copy model directories directly from your local machine to the Triton Inference Server pod.
This is not extremely 

## Manually Uploading Models to Triton Inference Server (Discouraged Method)

Directly uploading models to a pod can be quick but is generally discouraged due to the lack of persistence. If the pod restarts or is redeployed, any uploaded models will be lost. This method should only be used for temporary testing or in situations where persistence is managed externally.

### Steps for Uploading Models Directly to a Pod
Identify the Pod Name: Use kubectl get pods to find the Triton Inference Server pod.

```
kubectl get pods
```

```
kubectl cp <local_model_directory> <pod_name>:/models/<model_directory> -n <namespace>
```

## Cloud Providers

The chart supports deployment on cloud platforms, including GCP.

TODO examples:

