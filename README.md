# kubectl

This image includes the software below listed:

- [kubectl client](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- Openshift Client V3.11 until image version = 1.1.0
- Openshift Client V3.11 / V4 starting from image version = 1.2.0 and depending on the variable: _OKD_VERSION_ which it can be set to one of the following:
    - v3  (oc client 3.11)
    - v4  (oc client 4.x) [default]
- [awscli 2](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)

based on UBI systems

You can choose between 2 options:

1. distroless images starts from the UBI8 micro (smaller in size) and is build by: ```docker build -f Dockerfile.micro -t <image_name>:<image_tag> .```
2. standard UBI8 starts from the UBI8 base image (bigger in size) and is build by: ```docker build -f Dockerfile -t <image_name>:<image_tag> .```

## Usage

```
docker run --rm cprato79/kubectl:<tag> aws --version
docker run --rm cprato79/kubectl:<tag> kubectl --help
docker run --rm cprato79/kubectl:<tag> oc --help
```
