# Attempt to get JTAG working on Raspberry Pi

* Raspberry Pi 2 Model B v1.1
* Running kernel7.img built in ./kernel
* openocd v0.12.0 (built from source)
* FTDI FT2232H mini-module

Steps:
* Use Raspberry Pi Imager to install 32-bit OS to SD card
* Append to config.txt:
    ```
    # Disable pull downs
    gpio=22-27=np

    # Enable jtag pins (i.e. GPIO22-GPIO27)
    enable_jtag_gpio=1
    ```
* Build (`make all`) and copy kernel7.img to SD card
* Connect FT2232H to Raspberry Pi
* Power on Raspberry Pi
* Run `make run-openocd` to connect to JTAG
* Telnet to localhost:4444
* `halt`
* `step`

Single-stepping fails and outputs "timeout waiting for target halt".
