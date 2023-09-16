.PHONY: minikube.setup

minikube.setup:
	minikube config set memory 16384
	minikube config set cpus 4
	minikube start --addons=gpu,ingress,nvidia-driver-installer,nvidia-gpu-device-plugin  --disk-size=32g


# VERSION=$(shell grep -Eo '[0-9]\.[0-9]\.[0-9]+' helm-chart/hypha/Chart.yaml | head -1)

VERSION=$(shell grep -Po "(?<=version: )([0-9]|\.)*(?=\s|$$)" charts/hypha/Chart.yaml | head -1)

get.version:
	echo $(VERSION)


tag.release:
	version=${VERSION}
	echo "Tagging release ${VERSION}"
	git tag -a "v${VERSION}" -m "v${VERSION}" -f
	git push origin

install-and-test:
	helm upgrade hypha charts/hypha --install --timeout 20m
	helm test hypha
 

