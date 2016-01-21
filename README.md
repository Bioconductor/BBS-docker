# Docker container for the Bioconductor Build System

This is designed so you can get in and test minor
changes without 'testing' in production.

There are some differences between this and
the actual build system; for one, this
is based on the bioconductor docker containers.
It does not attempt to install all the 
necessary system dependencies needed
to build all Bioconductor packages.

# To Use

## Preparation

You probably want to update the image this is based on:

    docker pull bioconductor/devel_base

Then rebuild this:

    docker build -t Bioconductor/BBS-docker .

If you want to override the `R_VERSION` and 
`BIOC_VERSION` arguments that are set in the
`Dockerfile`, do that with the `--build-arg`
argument to `docker build`, as in:

    docker build --build-arg R_VERSION=3.4 ...

## Required/Suggested directory structure

## Creating data volume

## Using as `biocbuild`

## Using as `biocadmin`

## Use Cases



