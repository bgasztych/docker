# Zaven's Flutter Docker Image

This was originally fork of [cirruslabs/docker-images-flutter]https://github.com/cirruslabs/docker-images-flutter).

Image consists of Android SDK, Dart SDK, Flutter SDK, Ruby and Firebase CLI

Export variables before building and pushing an image

- `DOCKER_TAG`
- `FLUTTER_VERSION`
- `DOCKER_USER_NAME`
- `DOCKER_PASSWORD`


`docker login docker.zaven.co`

You can add an image to this registry with the following commands: 
`docker build -t docker.zaven.co/zaven/docker-flutter .`
`docker push docker.zaven.co/zaven/docker-flutter`

## Build docker image on ARM chip
1. Create a builder
`docker buildx create --name m1`
2. Tell buildx to use `m1` builder
`docker buildx use m1`
3. Build the image
`docker buildx build --tag [image-tag] -o type=image --platform=linux/arm64,linux/amd64 .`
4. Push the image
`docker buildx build --push --tag [image-tag] --platform=linux/arm64,linux/amd64 .`