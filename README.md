FlySight Viewer Docker
======================

Creates a Docker image for running
[flysight-viewer-qt](https://github.com/flysight/flysight-viewer-qt) on Linux.

To build the image:

```
make build
```

To run the image

```
make run
```

By default Google maps integration will not work due to a missing API key. An
API key can bet created
[here](https://developers.google.com/maps/documentation/javascript/get-api-key)
and included in the build by creating a `secrets.h` file in the docker
directory.  The `secrets.h` file should look like:

```
#ifndef __SECRETS_H__
#define __SECRETS_H__

#define GOOGLE_MAPS_API_KEY "GOOGLE_MAPS_API_KEY"

#endif
```
