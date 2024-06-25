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

run-openocd-rpi2: openocd/build/src/openocd
	openocd/build/src/openocd -f config/interface/ft2232h.cfg -f config/board/rpi2.cfg

run-openocd-rpi3: openocd/build/src/openocd
	openocd/build/src/openocd -f config/interface/ft2232h.cfg -f config/board/rpi3.cfg
