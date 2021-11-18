# kubectl
This image includes as below:

- kubectl client
- OC client
- aws-cli

based on UBI system

It has 2 options:

1. distroless images build: **build_distroless_image.sh** starting from the UBI8 micro (smaller in size)
2. standard UBI8 base image: **Dockerfile** (bigger in size)

## Usage

```
docker run --rm cprato79/kubectl:<tag> aws help
docker run --rm cprato79/kubectl:<tag> kubectl --help
docker run --rm cprato79/kubectl:<tag> oc --help
```
