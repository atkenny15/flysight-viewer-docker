.PHONY: build
build:
	docker/setup.sh
	docker build --build-arg user=$(shell whoami) --build-arg uid=$(shell id -u) -t flysight-viewer docker

.PHONY: build_nocache
build_nocache:
	docker/setup.sh
	docker build --build-arg user=$(shell whoami) --build-arg uid=$(shell id -u) --no-cache -t flysight-viewer docker

.PHONY: bash
bash:
	docker run -i -t \
	    --env _JAVA_AWT_WM_NONREPARENTING=1 \
	    --env DISPLAY=unix$(DISPLAY) \
	    --env VLC_PLUGIN_PATH=/usr/lib/vlc/plugins/ \
	    --env LD_LIBRARY_PATH=/usr/local/lib \
	    --net host \
	    --privileged \
	    --volume /dev:/dev \
	    --volume /tmp/.X11-unix:/tmp/.X11-unix \
	    --volume "${HOME}/.Xauthority:${HOME}/.Xauthority:rw" \
	    --volume "${HOME}/.Xauthority:/root/.Xauthority:rw" \
	    --volume "${HOME}:${HOME}" \
	    --volume "$(shell pwd)/docker/flysight-viewer-qt:/tmp/flysight-viewer-qt" \
	    --user $(shell whoami) \
	    --rm \
	    flysight-viewer \
	    /bin/bash

.PHONY: run
run:
	docker run -i -t \
	    --env _JAVA_AWT_WM_NONREPARENTING=1 \
	    --env DISPLAY=unix$(DISPLAY) \
	    --env VLC_PLUGIN_PATH=/usr/lib/vlc/plugins/ \
	    --env LD_LIBRARY_PATH=/usr/local/lib \
	    --net host \
	    --privileged \
	    --volume /dev:/dev \
	    --volume /tmp/.X11-unix:/tmp/.X11-unix \
	    --volume "${HOME}/.Xauthority:${HOME}/.Xauthority:rw" \
	    --volume "${HOME}/.Xauthority:/root/.Xauthority:rw" \
	    --volume "${HOME}:${HOME}" \
	    --user $(shell whoami) \
	    --rm \
	    flysight-viewer \
	    /usr/local/src/flysight/flysight-viewer-qt/src/FlySightViewer
