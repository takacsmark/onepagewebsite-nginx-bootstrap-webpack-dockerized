# One page website with Bootstrap 4, webpack-dev-server and Docker

This repository is a learning example and a simple boilerplate for a one page website using Bootstrap 4, webpack-dev-server and Docker.

![Preview gif](https://user-images.githubusercontent.com/3372330/42955392-ea16ff3e-8b7d-11e8-9158-959455231911.gif)

## Info

[![Build Status](https://travis-ci.org/takacsmark/onepagewebsite-nginx-bootstrap-webpack-dockerized.svg?branch=master)](https://travis-ci.org/takacsmark/onepagewebsite-nginx-bootstrap-webpack-dockerized)
[![dependencies Status](https://david-dm.org/takacsmark/onepagewebsite-nginx-bootstrap-webpack-dockerized/status.svg)](https://david-dm.org/takacsmark/onepagewebsite-nginx-bootstrap-webpack-dockerized)
[![devDependencies Status](https://david-dm.org/takacsmark/onepagewebsite-nginx-bootstrap-webpack-dockerized/dev-status.svg)](https://david-dm.org/takacsmark/onepagewebsite-nginx-bootstrap-webpack-dockerized?type=dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

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

## Infrastructure as code

### Terraform

The repo contains a working example to create an AWS EC2 t2.micro instance automatically with Terraform.

First create a file called `terraform.tfwars` under the `infra` directory. I have provided an example, so you can just rename `terraform.example.tfvars` and fill in your AWS secret credentials in the file.

Update `docker-compose.infra.yml` and update the keypair path information on your machine.

Then run the following commands:

```shell
$ docker-compose -f docker-compose.infra.yml run --rm terraform init
$ docker-compose -f docker-compose.infra.yml run --rm terraform plan
$ docker-compose -f docker-compose.infra.yml run --rm terraform apply -auto-approve

```

## Credits

Site theme design greatly inspired by this repo: [https://github.com/BlackrockDigital/startbootstrap-creative](https://github.com/BlackrockDigital/startbootstrap-creative).