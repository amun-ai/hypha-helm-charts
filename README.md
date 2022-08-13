# Hypha server helm chart

Helm-chart can be found in './charts' and can installed manually with

    helm install --generate-name charts/hypha --dependency-update

A values file can be passed in using:

    helm install --values values.yaml --generate-name charts/hypha --dependency-update
