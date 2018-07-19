# One page website with Bootstrap 4, webpack-dev-server and Docker

This repository is a learning example and a simple boilerplate for a one page website using Bootstrap 4, webpack-dev-server and Docker.

![Preview gif](https://user-images.githubusercontent.com/3372330/42955392-ea16ff3e-8b7d-11e8-9158-959455231911.gif)

## Usage

You can start the project in production mode and development mode.

### Development mode

To serve the project with webpack-dev-server use the command:

```shell
docker-compose -f docker-compose.dev.yml up -d
```

In oder to build the development Docker image separately, use the command:

```shell
docker-compose -f docker-compose.dev.yml build
```

### Production mode

To serve the project in production mode use the command:

```shell
docker-compose up -d
```

## Features

Development mode is set up to provide the following key features:

- hot reloading of js changes
- hot reloading of scss changes
- hot reloading of `index.html` template changes

Production mode features a multi-stage Docker build to minimize image size.

## Credits

Site theme design greatly inspired by this repo: [https://github.com/BlackrockDigital/startbootstrap-creative](https://github.com/BlackrockDigital/startbootstrap-creative).