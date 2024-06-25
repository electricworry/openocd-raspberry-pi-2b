.PHONY: all kernel

all: kernel openocd/build/src/openocd

openocd/build/src/openocd:
	cd openocd && \
		./bootstrap && \
		mkdir -p build && cd build && \
		../configure && \
		make -j

kernel:
	make -C kernel

run-openocd: openocd/build/src/openocd
	openocd/build/src/openocd -f config/interface/ft2232h.cfg -f config/board/rpi2.cfg
