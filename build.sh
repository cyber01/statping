#!/usr/bin/env bash

APP="statup"
REPO="hunterlong/statup"

rice embed-go

docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASS
docker build -f Dockerfile -t $REPO:$VERSION .
docker tag $REPO:$VERSION $REPO:latest
docker tag $REPO:$VERSION $REPO:$VERSION
docker push $REPO

mkdir build
xgo -go 1.10.x --targets=darwin/amd64 --dest=build -ldflags="-X main.VERSION=$VERSION" ./
xgo -go 1.10.x --targets=darwin/386 --dest=build -ldflags="-X main.VERSION=$VERSION" ./
xgo -go 1.10.x --targets=linux/amd64 --dest=build -ldflags="-X main.VERSION=$VERSION" ./
xgo -go 1.10.x --targets=linux/386 --dest=build -ldflags="-X main.VERSION=$VERSION" ./
xgo -go 1.10.x --targets=windows-6.0/amd64 --dest=build -ldflags="-X main.VERSION=$VERSION" ./
xgo -go 1.10.x --targets=linux/arm-7 --dest=build -ldflags="-X main.VERSION=$VERSION" ./
xgo -go 1.10.x --targets=linux/arm64 --dest=build -ldflags="-X main.VERSION=$VERSION" ./

cd build
ls
cd ../

mv build/$APP-darwin-10.6-amd64 build/$APP-osx-x64
mv build/$APP-darwin-10.6-386 build/$APP-osx-x32
mv build/$APP-linux-amd64 build/$APP-linux-x64
mv build/$APP-linux-386 build/$APP-linux-x32
mv build/$APP-windows-6.0-amd64.exe build/$APP-windows-x64.exe
mv build/$APP-linux-arm-7 build/$APP-linux-arm7
