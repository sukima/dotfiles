.PHONY: all clean

all: ./config ./config.x11vnc

clean:
	rm ./config ./config.x11vnc

./%: ./templates/% ./templates/config.common
	cat $< ./templates/config.common > $@
