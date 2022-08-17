# Hypha server helm chart

Add the hypha helm chart repo

    helm repo add hypha https://amun-ai.github.io/hypha-helm-charts/ 

Helm-chart can be found in './charts' and can installed manually with

    helm install --generate-name charts/hypha --dependency-update

A values file can be passed in using:

    helm install --values values.yaml --generate-name charts/hypha --dependency-update

Generate a secret:

    openssl rand -base64 32

See what versions of hypha are availiabile

    helm search repo hypha --versions