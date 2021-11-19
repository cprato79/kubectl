# kubectl

This image includes the software below listed:

- [kubectl client](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- Openshift OC v3.11 client
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
