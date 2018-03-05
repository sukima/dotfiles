.PHONY: all

all: ./config ./config.x11vnc

./%: ./templates/% ./templates/config.common
	cat $^ > $@
