FlySight Viewer Docker
======================

Creates a Docker image for running
[flysight-viewer-qt](https://github.com/flysight/flysight-viewer-qt) on Linux.
Last tested on `fed44f6f616b847cc6a60f9f2653574230fd032b`.

To build the image:

```
make build
```

To run the image

```
make run
```

If using a nVidia graphics card (and drivers), the drivers need to be installed
in the container for `libGL.so`. To install them, download the `.run` file for
the appropriate driver version (run `nvidia-smi` to determine the version) and
copy it to `docker/nvidia.run`.

By default Google maps integration will not work due to a missing API key. An
API key can be created
[here](https://developers.google.com/maps/documentation/javascript/get-api-key)
([Google Cloud Platform Console](https://console.cloud.google.com) and included
in the build by creating a `secrets.h` file in the `docker` directory.  The
`secrets.h` file should look like:

```
#ifndef __SECRETS_H__
#define __SECRETS_H__

#define GOOGLE_MAPS_API_KEY "GOOGLE_MAPS_API_KEY"

#endif
```
