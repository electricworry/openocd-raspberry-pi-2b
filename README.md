# Attempt to get JTAG working on Raspberry Pi

* Raspberry Pi 2 Model B v1.1
* Running kernel7.img built in ./kernel
* openocd master (built from source)
* FTDI FT2232H mini-module
* openocd is taken from master, except rpi2.cfg which is a modification of
  rpi3.cfg to use bcm2836 instead of bcm2837

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
* Run `make run-openocd-rpi2` to connect to JTAG
* Telnet to localhost:4444
* `halt`
* `step`

Single-stepping fails and outputs "timeout waiting for target halt":

```
Open On-Chip Debugger
> halt
bcm2836.cpu0: MPIDR level2 0, cluster f, core 0, multi core, no SMT
target halted in ARM state due to debug-request, current mode: Hypervisor
cpsr: 0x000001da pc: 0x00008004
MMU: disabled, D-Cache: disabled, I-Cache: disabled
> step
timeout waiting for target halt

> 
```

The problem does not occur targetting a Rspberry Pi 3B with
`make run-openocf-rpi3`.