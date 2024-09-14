# OpenOCD output

Connected to Raspberry Pi 3B as follows:

```
FTDI <=> Target
GND      GND
AD0      pin 22 = GPIO 25
AD1      pin 37 = GPIO 26
AD2      pin 18 = GPIO 24
AD3      pin 13 = GPIO 27
AD4      NC
AD5      pin 15 = GPIO 22
AD6      NC
AD7      pin 16 = SPIO 23
```

On insertion:
```
electricworry@EW:~/projects/openocd-raspberry-pi-2b$ ls -l /dev/ttyUSB*
crw-rw---- 1 root dialout 188, 0 Sep 14 14:26 /dev/ttyUSB0
crw-rw---- 1 root dialout 188, 1 Sep 14 14:26 /dev/ttyUSB1
```

Run `sudo openocd/build/src/openocd -f config/interface/ft2232h.cfg`:

```
Open On-Chip Debugger 0.12.0+dev-01711-gcbed09ee9 (2024-09-14-14:21)
Licensed under GNU GPL v2
For bug reports, read
	http://openocd.org/doc/doxygen/bugs.html
DEPRECATED! use 'ftdi channel' not 'ftdi_channel'
Info : Listening on port 6666 for tcl connections
Info : Listening on port 4444 for telnet connections
Warn : An adapter speed is not selected in the init scripts. OpenOCD will try to run the adapter at very low speed (100 kHz).
Warn : To remove this warnings and achieve reasonable communication speed with the target, set "adapter speed" or "jtag_rclk" in the init scripts.
Info : clock speed 100 kHz
Error: session transport was not selected. Use 'transport select <transport>'
Error: Transports available:
Error: jtag
Error: swd
<EXITS>
```

Error expected since a transport isn't defined. After running:
```
electricworry@EW:~/projects/openocd-raspberry-pi-2b$ ls -l /dev/ttyUSB*
crw-rw---- 1 root dialout 188, 1 Sep 14 14:26 /dev/ttyUSB1
```
Proves that the device mode has changed.

Running with the full command line but with target device off/disconnected:

```
$ sudo openocd/build/src/openocd -f config/interface/ft2232h.cfg -f config/board/rpi3.cfg -d3

Open On-Chip Debugger 0.12.0+dev-01711-gcbed09ee9 (2024-09-14-14:21)
Licensed under GNU GPL v2
For bug reports, read
	http://openocd.org/doc/doxygen/bugs.html
User : 3 1 options.c:52 configuration_output_handler(): debug_level: 3User : 4 1 options.c:52 configuration_output_handler(): 
Debug: 5 1 options.c:346 parse_cmdline_args(): ARGV[0] = "openocd/build/src/openocd"
Debug: 6 1 options.c:346 parse_cmdline_args(): ARGV[1] = "-f"
Debug: 7 1 options.c:346 parse_cmdline_args(): ARGV[2] = "config/interface/ft2232h.cfg"
Debug: 8 1 options.c:346 parse_cmdline_args(): ARGV[3] = "-f"
Debug: 9 1 options.c:346 parse_cmdline_args(): ARGV[4] = "config/board/rpi3.cfg"
Debug: 10 1 options.c:346 parse_cmdline_args(): ARGV[5] = "-d3"
Debug: 11 1 options.c:233 add_default_dirs(): bindir=/usr/local/bin
Debug: 12 1 options.c:234 add_default_dirs(): pkgdatadir=/usr/local/share/openocd
Debug: 13 1 options.c:235 add_default_dirs(): exepath=/home/electricworry/projects/openocd-raspberry-pi-2b/openocd/build/src
Debug: 14 1 options.c:236 add_default_dirs(): bin2data=../share/openocd
Debug: 15 1 configuration.c:33 add_script_search_dir(): adding /root/.config/openocd
Debug: 16 1 configuration.c:33 add_script_search_dir(): adding /root/.openocd
Debug: 17 1 configuration.c:33 add_script_search_dir(): adding /home/electricworry/projects/openocd-raspberry-pi-2b/openocd/build/src/../share/openocd/site
Debug: 18 1 configuration.c:33 add_script_search_dir(): adding /home/electricworry/projects/openocd-raspberry-pi-2b/openocd/build/src/../share/openocd/scripts
Debug: 19 1 command.c:153 script_debug(): command - ocd_find config/interface/ft2232h.cfg
Debug: 20 1 configuration.c:88 find_file(): found config/interface/ft2232h.cfg
Debug: 21 1 command.c:153 script_debug(): command - adapter driver ftdi
Debug: 22 1 command.c:153 script_debug(): command - ftdi vid_pid 0x0403 0x6010
Debug: 23 1 command.c:153 script_debug(): command - echo DEPRECATED! use 'ftdi channel' not 'ftdi_channel'
User : 24 1 command.c:678 handle_echo(): DEPRECATED! use 'ftdi channel' not 'ftdi_channel'
Debug: 25 1 command.c:153 script_debug(): command - ftdi channel 0
Debug: 26 1 command.c:153 script_debug(): command - ftdi layout_init 0x0008 0x000b
Debug: 27 1 command.c:153 script_debug(): command - ftdi layout_signal nSRST -data 0x0020 -oe 0x0020
Debug: 28 1 command.c:153 script_debug(): command - ocd_find config/board/rpi3.cfg
Debug: 29 1 configuration.c:88 find_file(): found config/board/rpi3.cfg
Debug: 30 1 command.c:153 script_debug(): command - ocd_find config/target/bcm2837.cfg
Debug: 31 1 configuration.c:88 find_file(): found config/target/bcm2837.cfg
Debug: 32 1 command.c:153 script_debug(): command - transport select
Info : 33 1 transport.c:267 handle_transport_select(): auto-selecting first available session transport "jtag". To override use 'transport select <transport>'.
Debug: 34 1 command.c:153 script_debug(): command - transport select
Debug: 35 1 command.c:153 script_debug(): command - jtag newtap bcm2837 cpu -expected-id 0x4ba00477 -irlen 4
Debug: 36 1 tcl.c:404 handle_jtag_newtap_args(): Creating New Tap, Chip: bcm2837, Tap: cpu, Dotted: bcm2837.cpu, 4 params
Debug: 37 1 core.c:1475 jtag_tap_init(): Created Tap: bcm2837.cpu @ abs position 0, irlen 4, capture: 0x1 mask: 0x3
Debug: 38 1 command.c:153 script_debug(): command - adapter speed 4000
Debug: 39 1 adapter.c:250 adapter_config_khz(): handle adapter khz
Debug: 40 1 adapter.c:214 adapter_khz_to_speed(): convert khz to adapter specific speed value
Debug: 41 1 adapter.c:214 adapter_khz_to_speed(): convert khz to adapter specific speed value
Debug: 42 1 command.c:153 script_debug(): command - dap create bcm2837.dap -chain-position bcm2837.cpu
Debug: 43 1 command.c:153 script_debug(): command - target create bcm2837.ap mem_ap -dap bcm2837.dap -ap-num 0
Debug: 44 1 command.c:153 script_debug(): command - cti create bcm2837.cti0 -dap bcm2837.dap -ap-num 0 -baseaddr 0x80018000
Debug: 45 1 arm_adi_v5.c:1193 dap_get_ap(): refcount AP#0x0 get 1
Debug: 46 1 command.c:153 script_debug(): command - target create bcm2837.cpu0 aarch64 -dap bcm2837.dap -ap-num 0 -dbgbase 0x80010000 -cti bcm2837.cti0
Debug: 47 1 command.c:153 script_debug(): command - bcm2837.cpu0 configure -event reset-assert-post  aarch64  dbginit 
Debug: 48 1 command.c:153 script_debug(): command - cti create bcm2837.cti1 -dap bcm2837.dap -ap-num 0 -baseaddr 0x80019000
Debug: 49 1 arm_adi_v5.c:1193 dap_get_ap(): refcount AP#0x0 get 2
Debug: 50 1 command.c:153 script_debug(): command - target create bcm2837.cpu1 aarch64 -dap bcm2837.dap -ap-num 0 -dbgbase 0x80012000 -cti bcm2837.cti1
Debug: 51 1 command.c:259 register_command(): command 'arm' is already registered
Debug: 52 1 command.c:259 register_command(): command 'arm semihosting' is already registered
Debug: 53 1 command.c:259 register_command(): command 'arm semihosting_redirect' is already registered
Debug: 54 1 command.c:259 register_command(): command 'arm semihosting_cmdline' is already registered
Debug: 55 1 command.c:259 register_command(): command 'arm semihosting_fileio' is already registered
Debug: 56 1 command.c:259 register_command(): command 'arm semihosting_resexit' is already registered
Debug: 57 1 command.c:259 register_command(): command 'arm semihosting_read_user_param' is already registered
Debug: 58 1 command.c:259 register_command(): command 'arm semihosting_basedir' is already registered
Debug: 59 1 command.c:259 register_command(): command 'catch_exc' is already registered
Debug: 60 1 command.c:259 register_command(): command 'pauth' is already registered
Debug: 61 1 command.c:259 register_command(): command 'aarch64' is already registered
Debug: 62 1 command.c:259 register_command(): command 'aarch64 cache_info' is already registered
Debug: 63 1 command.c:259 register_command(): command 'aarch64 dbginit' is already registered
Debug: 64 1 command.c:259 register_command(): command 'aarch64 disassemble' is already registered
Debug: 65 1 command.c:259 register_command(): command 'aarch64 maskisr' is already registered
Debug: 66 1 command.c:259 register_command(): command 'aarch64 mcr' is already registered
Debug: 67 1 command.c:259 register_command(): command 'aarch64 mrc' is already registered
Debug: 68 1 command.c:259 register_command(): command 'aarch64 smp' is already registered
Debug: 69 1 command.c:259 register_command(): command 'aarch64 smp_gdb' is already registered
Debug: 70 1 command.c:153 script_debug(): command - bcm2837.cpu1 configure -event reset-assert-post  aarch64  dbginit 
Debug: 71 1 command.c:153 script_debug(): command - cti create bcm2837.cti2 -dap bcm2837.dap -ap-num 0 -baseaddr 0x8001a000
Debug: 72 1 arm_adi_v5.c:1193 dap_get_ap(): refcount AP#0x0 get 3
Debug: 73 1 command.c:153 script_debug(): command - target create bcm2837.cpu2 aarch64 -dap bcm2837.dap -ap-num 0 -dbgbase 0x80014000 -cti bcm2837.cti2
Debug: 74 1 command.c:259 register_command(): command 'arm' is already registered
Debug: 75 1 command.c:259 register_command(): command 'arm semihosting' is already registered
Debug: 76 1 command.c:259 register_command(): command 'arm semihosting_redirect' is already registered
Debug: 77 1 command.c:259 register_command(): command 'arm semihosting_cmdline' is already registered
Debug: 78 1 command.c:259 register_command(): command 'arm semihosting_fileio' is already registered
Debug: 79 1 command.c:259 register_command(): command 'arm semihosting_resexit' is already registered
Debug: 80 1 command.c:259 register_command(): command 'arm semihosting_read_user_param' is already registered
Debug: 81 1 command.c:259 register_command(): command 'arm semihosting_basedir' is already registered
Debug: 82 1 command.c:259 register_command(): command 'catch_exc' is already registered
Debug: 83 1 command.c:259 register_command(): command 'pauth' is already registered
Debug: 84 1 command.c:259 register_command(): command 'aarch64' is already registered
Debug: 85 1 command.c:259 register_command(): command 'aarch64 cache_info' is already registered
Debug: 86 1 command.c:259 register_command(): command 'aarch64 dbginit' is already registered
Debug: 87 1 command.c:259 register_command(): command 'aarch64 disassemble' is already registered
Debug: 88 1 command.c:259 register_command(): command 'aarch64 maskisr' is already registered
Debug: 89 1 command.c:259 register_command(): command 'aarch64 mcr' is already registered
Debug: 90 1 command.c:259 register_command(): command 'aarch64 mrc' is already registered
Debug: 91 1 command.c:259 register_command(): command 'aarch64 smp' is already registered
Debug: 92 1 command.c:259 register_command(): command 'aarch64 smp_gdb' is already registered
Debug: 93 1 command.c:153 script_debug(): command - bcm2837.cpu2 configure -event reset-assert-post  aarch64  dbginit 
Debug: 94 1 command.c:153 script_debug(): command - cti create bcm2837.cti3 -dap bcm2837.dap -ap-num 0 -baseaddr 0x8001b000
Debug: 95 1 arm_adi_v5.c:1193 dap_get_ap(): refcount AP#0x0 get 4
Debug: 96 1 command.c:153 script_debug(): command - target create bcm2837.cpu3 aarch64 -dap bcm2837.dap -ap-num 0 -dbgbase 0x80016000 -cti bcm2837.cti3
Debug: 97 1 command.c:259 register_command(): command 'arm' is already registered
Debug: 98 1 command.c:259 register_command(): command 'arm semihosting' is already registered
Debug: 99 1 command.c:259 register_command(): command 'arm semihosting_redirect' is already registered
Debug: 100 1 command.c:259 register_command(): command 'arm semihosting_cmdline' is already registered
Debug: 101 1 command.c:259 register_command(): command 'arm semihosting_fileio' is already registered
Debug: 102 1 command.c:259 register_command(): command 'arm semihosting_resexit' is already registered
Debug: 103 1 command.c:259 register_command(): command 'arm semihosting_read_user_param' is already registered
Debug: 104 1 command.c:259 register_command(): command 'arm semihosting_basedir' is already registered
Debug: 105 1 command.c:259 register_command(): command 'catch_exc' is already registered
Debug: 106 1 command.c:259 register_command(): command 'pauth' is already registered
Debug: 107 1 command.c:259 register_command(): command 'aarch64' is already registered
Debug: 108 1 command.c:259 register_command(): command 'aarch64 cache_info' is already registered
Debug: 109 1 command.c:259 register_command(): command 'aarch64 dbginit' is already registered
Debug: 110 1 command.c:259 register_command(): command 'aarch64 disassemble' is already registered
Debug: 111 1 command.c:259 register_command(): command 'aarch64 maskisr' is already registered
Debug: 112 1 command.c:259 register_command(): command 'aarch64 mcr' is already registered
Debug: 113 1 command.c:259 register_command(): command 'aarch64 mrc' is already registered
Debug: 114 1 command.c:259 register_command(): command 'aarch64 smp' is already registered
Debug: 115 1 command.c:259 register_command(): command 'aarch64 smp_gdb' is already registered
Debug: 116 1 command.c:153 script_debug(): command - bcm2837.cpu3 configure -event reset-assert-post  aarch64  dbginit 
Debug: 117 1 command.c:153 script_debug(): command - targets bcm2837.cpu0
Debug: 118 1 command.c:153 script_debug(): command - transport select jtag
Warn : 119 1 transport.c:280 handle_transport_select(): Transport "jtag" was already selected
Debug: 120 1 command.c:153 script_debug(): command - reset_config trst_only
User : 121 1 options.c:52 configuration_output_handler(): trst_only separate trst_push_pullUser : 122 1 options.c:52 configuration_output_handler(): 
Info : 123 2 server.c:298 add_service(): Listening on port 6666 for tcl connections
Info : 124 2 server.c:298 add_service(): Listening on port 4444 for telnet connections
Debug: 125 2 command.c:153 script_debug(): command - init
Debug: 126 2 command.c:153 script_debug(): command - target init
Debug: 127 2 command.c:153 script_debug(): command - target names
Debug: 128 2 command.c:153 script_debug(): command - bcm2837.ap cget -event gdb-flash-erase-start
Debug: 129 2 command.c:153 script_debug(): command - bcm2837.ap configure -event gdb-flash-erase-start reset init
Debug: 130 2 command.c:153 script_debug(): command - bcm2837.ap cget -event gdb-flash-write-end
Debug: 131 2 command.c:153 script_debug(): command - bcm2837.ap configure -event gdb-flash-write-end reset halt
Debug: 132 2 command.c:153 script_debug(): command - bcm2837.ap cget -event gdb-attach
Debug: 133 2 command.c:153 script_debug(): command - bcm2837.ap configure -event gdb-attach halt 1000
Debug: 134 2 command.c:153 script_debug(): command - bcm2837.cpu0 cget -event gdb-flash-erase-start
Debug: 135 2 command.c:153 script_debug(): command - bcm2837.cpu0 configure -event gdb-flash-erase-start reset init
Debug: 136 2 command.c:153 script_debug(): command - bcm2837.cpu0 cget -event gdb-flash-write-end
Debug: 137 2 command.c:153 script_debug(): command - bcm2837.cpu0 configure -event gdb-flash-write-end reset halt
Debug: 138 2 command.c:153 script_debug(): command - bcm2837.cpu0 cget -event gdb-attach
Debug: 139 2 command.c:153 script_debug(): command - bcm2837.cpu0 configure -event gdb-attach halt 1000
Debug: 140 2 command.c:153 script_debug(): command - bcm2837.cpu1 cget -event gdb-flash-erase-start
Debug: 141 2 command.c:153 script_debug(): command - bcm2837.cpu1 configure -event gdb-flash-erase-start reset init
Debug: 142 2 command.c:153 script_debug(): command - bcm2837.cpu1 cget -event gdb-flash-write-end
Debug: 143 2 command.c:153 script_debug(): command - bcm2837.cpu1 configure -event gdb-flash-write-end reset halt
Debug: 144 2 command.c:153 script_debug(): command - bcm2837.cpu1 cget -event gdb-attach
Debug: 145 2 command.c:153 script_debug(): command - bcm2837.cpu1 configure -event gdb-attach halt 1000
Debug: 146 2 command.c:153 script_debug(): command - bcm2837.cpu2 cget -event gdb-flash-erase-start
Debug: 147 2 command.c:153 script_debug(): command - bcm2837.cpu2 configure -event gdb-flash-erase-start reset init
Debug: 148 2 command.c:153 script_debug(): command - bcm2837.cpu2 cget -event gdb-flash-write-end
Debug: 149 2 command.c:153 script_debug(): command - bcm2837.cpu2 configure -event gdb-flash-write-end reset halt
Debug: 150 2 command.c:153 script_debug(): command - bcm2837.cpu2 cget -event gdb-attach
Debug: 151 2 command.c:153 script_debug(): command - bcm2837.cpu2 configure -event gdb-attach halt 1000
Debug: 152 2 command.c:153 script_debug(): command - bcm2837.cpu3 cget -event gdb-flash-erase-start
Debug: 153 2 command.c:153 script_debug(): command - bcm2837.cpu3 configure -event gdb-flash-erase-start reset init
Debug: 154 2 command.c:153 script_debug(): command - bcm2837.cpu3 cget -event gdb-flash-write-end
Debug: 155 2 command.c:153 script_debug(): command - bcm2837.cpu3 configure -event gdb-flash-write-end reset halt
Debug: 156 2 command.c:153 script_debug(): command - bcm2837.cpu3 cget -event gdb-attach
Debug: 157 2 command.c:153 script_debug(): command - bcm2837.cpu3 configure -event gdb-attach halt 1000
Debug: 158 2 target.c:1588 handle_target_init_command(): Initializing targets...
Debug: 159 2 mem_ap.c:61 mem_ap_init_target(): mem_ap_init_target
Debug: 160 2 semihosting_common.c:107 semihosting_common_init():  
Debug: 161 2 semihosting_common.c:107 semihosting_common_init():  
Debug: 162 2 semihosting_common.c:107 semihosting_common_init():  
Debug: 163 2 semihosting_common.c:107 semihosting_common_init():  
Debug: 164 2 ftdi.c:654 ftdi_initialize(): ftdi interface using shortest path jtag state transitions
Debug: 165 15 mpsse.c:427 mpsse_purge(): -
Debug: 166 19 mpsse.c:708 mpsse_loopback_config(): off
Debug: 167 19 mpsse.c:753 mpsse_set_frequency(): target 4000000 Hz
Debug: 168 19 mpsse.c:745 mpsse_rtck_config(): off
Debug: 169 19 mpsse.c:734 mpsse_divide_by_5_config(): off
Debug: 170 19 mpsse.c:714 mpsse_set_divisor(): 7
Debug: 171 19 mpsse.c:777 mpsse_set_frequency(): actually 3750000 Hz
Debug: 172 19 adapter.c:214 adapter_khz_to_speed(): convert khz to adapter specific speed value
Debug: 173 19 adapter.c:218 adapter_khz_to_speed(): have adapter set up
Debug: 174 19 mpsse.c:753 mpsse_set_frequency(): target 4000000 Hz
Debug: 175 19 mpsse.c:745 mpsse_rtck_config(): off
Debug: 176 19 mpsse.c:734 mpsse_divide_by_5_config(): off
Debug: 177 19 mpsse.c:714 mpsse_set_divisor(): 7
Debug: 178 19 mpsse.c:777 mpsse_set_frequency(): actually 3750000 Hz
Debug: 179 19 adapter.c:214 adapter_khz_to_speed(): convert khz to adapter specific speed value
Debug: 180 19 adapter.c:218 adapter_khz_to_speed(): have adapter set up
Info : 181 19 adapter.c:178 adapter_init(): clock speed 4000 kHz
Debug: 182 19 openocd.c:133 handle_init_command(): Debug Adapter init complete
Debug: 183 19 command.c:153 script_debug(): command - transport init
Debug: 184 19 transport.c:219 handle_transport_init(): handle_transport_init
Debug: 185 19 core.c:830 jtag_add_reset(): SRST line released
Debug: 186 19 core.c:855 jtag_add_reset(): TRST line released
Debug: 187 19 core.c:328 jtag_call_event_callbacks(): jtag event: TAP reset
Debug: 188 19 command.c:153 script_debug(): command - jtag arp_init
Debug: 189 19 core.c:1510 jtag_init_inner(): Init JTAG chain
Debug: 190 19 core.c:328 jtag_call_event_callbacks(): jtag event: TAP reset
Debug: 191 19 core.c:1235 jtag_examine_chain(): DR scan interrogation for IDCODE/BYPASS
Debug: 192 19 core.c:328 jtag_call_event_callbacks(): jtag event: TAP reset
Error: 193 19 core.c:1122 jtag_examine_chain_check(): JTAG scan chain interrogation failed: all ones
Error: 194 19 core.c:1124 jtag_examine_chain_check(): Check JTAG interface, timings, target power, etc.
Error: 195 19 core.c:1555 jtag_init_inner(): Trying to use configured scan chain anyway...
Debug: 196 19 core.c:1365 jtag_validate_ircapture(): IR capture validation scan
Error: 197 19 core.c:1414 jtag_validate_ircapture(): bcm2837.cpu: IR capture error; saw 0x0f not 0x01
Debug: 198 19 core.c:328 jtag_call_event_callbacks(): jtag event: TAP reset
Warn : 199 19 core.c:1578 jtag_init_inner(): Bypassing JTAG setup events due to errors
Debug: 200 19 command.c:153 script_debug(): command - dap init
Debug: 201 19 arm_dap.c:96 dap_init_all(): Initializing all DAPs ...
Debug: 202 19 arm_dap.c:120 dap_init_all(): DAP bcm2837.cpu configured by default to use ADIv5 protocol
Debug: 203 19 arm_adi_v5.c:783 dap_dp_init(): bcm2837.dap
Debug: 204 19 arm_adi_v5.c:816 dap_dp_init(): DAP: wait CDBGPWRUPACK
Debug: 205 19 arm_adi_v5.h:682 dap_dp_poll_register(): DAP: poll 4, mask 0x20000000, value 0x20000000
Error: 206 19 adi_v5_jtag.c:454 jtagdp_overrun_check(): Invalid ACK (7) in DAP response
Debug: 207 19 adi_v5_jtag.c:671 jtagdp_transaction_endcheck(): jtag-dp: CTRL/STAT 0xffffffff
Error: 208 19 adi_v5_jtag.c:682 jtagdp_transaction_endcheck(): JTAG-DP STICKY ERROR
Debug: 209 19 adi_v5_jtag.c:684 jtagdp_transaction_endcheck(): JTAG-DP STICKY OVERRUN
Debug: 210 20 command.c:528 exec_command(): Command 'dap init' failed with error code -107
User : 211 20 command.c:601 command_run_line(): 
Debug: 212 20 command.c:528 exec_command(): Command 'init' failed with error code -4
User : 213 20 command.c:601 command_run_line(): 
Debug: 214 20 breakpoints.c:328 breakpoint_remove_all_internal(): [bcm2837.ap] Delete all breakpoints
Debug: 215 20 mem_ap.c:71 mem_ap_deinit_target(): mem_ap_deinit_target
Debug: 216 20 target.c:2130 target_free_all_working_areas_restore(): freeing all working areas
Debug: 217 20 breakpoints.c:328 breakpoint_remove_all_internal(): [bcm2837.cpu0] Delete all breakpoints
Debug: 218 20 target.c:2130 target_free_all_working_areas_restore(): freeing all working areas
Debug: 219 20 breakpoints.c:328 breakpoint_remove_all_internal(): [bcm2837.cpu1] Delete all breakpoints
Debug: 220 20 target.c:2130 target_free_all_working_areas_restore(): freeing all working areas
Debug: 221 20 breakpoints.c:328 breakpoint_remove_all_internal(): [bcm2837.cpu2] Delete all breakpoints
Debug: 222 20 target.c:2130 target_free_all_working_areas_restore(): freeing all working areas
Debug: 223 20 breakpoints.c:328 breakpoint_remove_all_internal(): [bcm2837.cpu3] Delete all breakpoints
Debug: 224 20 target.c:2130 target_free_all_working_areas_restore(): freeing all working areas
Debug: 225 20 arm_adi_v5.c:1218 dap_put_ap(): refcount AP#0x0 put 3
Debug: 226 20 arm_adi_v5.c:1218 dap_put_ap(): refcount AP#0x0 put 2
Debug: 227 20 arm_adi_v5.c:1218 dap_put_ap(): refcount AP#0x0 put 1
Debug: 228 20 arm_adi_v5.c:1218 dap_put_ap(): refcount AP#0x0 put 0
<EXITS>
```

And finally the same again with the device on/connected:

```
$ sudo openocd/build/src/openocd -f config/interface/ft2232h.cfg -f config/board/rpi3.cfg -d3

Open On-Chip Debugger 0.12.0+dev-01711-gcbed09ee9 (2024-09-14-14:21)
Licensed under GNU GPL v2
For bug reports, read
	http://openocd.org/doc/doxygen/bugs.html
User : 3 0 options.c:52 configuration_output_handler(): debug_level: 3User : 4 0 options.c:52 configuration_output_handler(): 
Debug: 5 0 options.c:346 parse_cmdline_args(): ARGV[0] = "openocd/build/src/openocd"
Debug: 6 0 options.c:346 parse_cmdline_args(): ARGV[1] = "-f"
Debug: 7 0 options.c:346 parse_cmdline_args(): ARGV[2] = "config/interface/ft2232h.cfg"
Debug: 8 0 options.c:346 parse_cmdline_args(): ARGV[3] = "-f"
Debug: 9 0 options.c:346 parse_cmdline_args(): ARGV[4] = "config/board/rpi3.cfg"
Debug: 10 0 options.c:346 parse_cmdline_args(): ARGV[5] = "-d3"
Debug: 11 1 options.c:233 add_default_dirs(): bindir=/usr/local/bin
Debug: 12 1 options.c:234 add_default_dirs(): pkgdatadir=/usr/local/share/openocd
Debug: 13 1 options.c:235 add_default_dirs(): exepath=/home/electricworry/projects/openocd-raspberry-pi-2b/openocd/build/src
Debug: 14 1 options.c:236 add_default_dirs(): bin2data=../share/openocd
Debug: 15 1 configuration.c:33 add_script_search_dir(): adding /root/.config/openocd
Debug: 16 1 configuration.c:33 add_script_search_dir(): adding /root/.openocd
Debug: 17 1 configuration.c:33 add_script_search_dir(): adding /home/electricworry/projects/openocd-raspberry-pi-2b/openocd/build/src/../share/openocd/site
Debug: 18 1 configuration.c:33 add_script_search_dir(): adding /home/electricworry/projects/openocd-raspberry-pi-2b/openocd/build/src/../share/openocd/scripts
Debug: 19 1 command.c:153 script_debug(): command - ocd_find config/interface/ft2232h.cfg
Debug: 20 1 configuration.c:88 find_file(): found config/interface/ft2232h.cfg
Debug: 21 1 command.c:153 script_debug(): command - adapter driver ftdi
Debug: 22 1 command.c:153 script_debug(): command - ftdi vid_pid 0x0403 0x6010
Debug: 23 1 command.c:153 script_debug(): command - echo DEPRECATED! use 'ftdi channel' not 'ftdi_channel'
User : 24 1 command.c:678 handle_echo(): DEPRECATED! use 'ftdi channel' not 'ftdi_channel'
Debug: 25 1 command.c:153 script_debug(): command - ftdi channel 0
Debug: 26 1 command.c:153 script_debug(): command - ftdi layout_init 0x0008 0x000b
Debug: 27 1 command.c:153 script_debug(): command - ftdi layout_signal nSRST -data 0x0020 -oe 0x0020
Debug: 28 1 command.c:153 script_debug(): command - ocd_find config/board/rpi3.cfg
Debug: 29 1 configuration.c:88 find_file(): found config/board/rpi3.cfg
Debug: 30 1 command.c:153 script_debug(): command - ocd_find config/target/bcm2837.cfg
Debug: 31 1 configuration.c:88 find_file(): found config/target/bcm2837.cfg
Debug: 32 1 command.c:153 script_debug(): command - transport select
Info : 33 1 transport.c:267 handle_transport_select(): auto-selecting first available session transport "jtag". To override use 'transport select <transport>'.
Debug: 34 1 command.c:153 script_debug(): command - transport select
Debug: 35 1 command.c:153 script_debug(): command - jtag newtap bcm2837 cpu -expected-id 0x4ba00477 -irlen 4
Debug: 36 1 tcl.c:404 handle_jtag_newtap_args(): Creating New Tap, Chip: bcm2837, Tap: cpu, Dotted: bcm2837.cpu, 4 params
Debug: 37 1 core.c:1475 jtag_tap_init(): Created Tap: bcm2837.cpu @ abs position 0, irlen 4, capture: 0x1 mask: 0x3
Debug: 38 1 command.c:153 script_debug(): command - adapter speed 4000
Debug: 39 1 adapter.c:250 adapter_config_khz(): handle adapter khz
Debug: 40 1 adapter.c:214 adapter_khz_to_speed(): convert khz to adapter specific speed value
Debug: 41 1 adapter.c:214 adapter_khz_to_speed(): convert khz to adapter specific speed value
Debug: 42 1 command.c:153 script_debug(): command - dap create bcm2837.dap -chain-position bcm2837.cpu
Debug: 43 1 command.c:153 script_debug(): command - target create bcm2837.ap mem_ap -dap bcm2837.dap -ap-num 0
Debug: 44 1 command.c:153 script_debug(): command - cti create bcm2837.cti0 -dap bcm2837.dap -ap-num 0 -baseaddr 0x80018000
Debug: 45 1 arm_adi_v5.c:1193 dap_get_ap(): refcount AP#0x0 get 1
Debug: 46 1 command.c:153 script_debug(): command - target create bcm2837.cpu0 aarch64 -dap bcm2837.dap -ap-num 0 -dbgbase 0x80010000 -cti bcm2837.cti0
Debug: 47 1 command.c:153 script_debug(): command - bcm2837.cpu0 configure -event reset-assert-post  aarch64  dbginit 
Debug: 48 1 command.c:153 script_debug(): command - cti create bcm2837.cti1 -dap bcm2837.dap -ap-num 0 -baseaddr 0x80019000
Debug: 49 1 arm_adi_v5.c:1193 dap_get_ap(): refcount AP#0x0 get 2
Debug: 50 1 command.c:153 script_debug(): command - target create bcm2837.cpu1 aarch64 -dap bcm2837.dap -ap-num 0 -dbgbase 0x80012000 -cti bcm2837.cti1
Debug: 51 1 command.c:259 register_command(): command 'arm' is already registered
Debug: 52 1 command.c:259 register_command(): command 'arm semihosting' is already registered
Debug: 53 1 command.c:259 register_command(): command 'arm semihosting_redirect' is already registered
Debug: 54 1 command.c:259 register_command(): command 'arm semihosting_cmdline' is already registered
Debug: 55 1 command.c:259 register_command(): command 'arm semihosting_fileio' is already registered
Debug: 56 1 command.c:259 register_command(): command 'arm semihosting_resexit' is already registered
Debug: 57 1 command.c:259 register_command(): command 'arm semihosting_read_user_param' is already registered
Debug: 58 1 command.c:259 register_command(): command 'arm semihosting_basedir' is already registered
Debug: 59 1 command.c:259 register_command(): command 'catch_exc' is already registered
Debug: 60 1 command.c:259 register_command(): command 'pauth' is already registered
Debug: 61 1 command.c:259 register_command(): command 'aarch64' is already registered
Debug: 62 1 command.c:259 register_command(): command 'aarch64 cache_info' is already registered
Debug: 63 1 command.c:259 register_command(): command 'aarch64 dbginit' is already registered
Debug: 64 1 command.c:259 register_command(): command 'aarch64 disassemble' is already registered
Debug: 65 1 command.c:259 register_command(): command 'aarch64 maskisr' is already registered
Debug: 66 1 command.c:259 register_command(): command 'aarch64 mcr' is already registered
Debug: 67 1 command.c:259 register_command(): command 'aarch64 mrc' is already registered
Debug: 68 1 command.c:259 register_command(): command 'aarch64 smp' is already registered
Debug: 69 1 command.c:259 register_command(): command 'aarch64 smp_gdb' is already registered
Debug: 70 1 command.c:153 script_debug(): command - bcm2837.cpu1 configure -event reset-assert-post  aarch64  dbginit 
Debug: 71 1 command.c:153 script_debug(): command - cti create bcm2837.cti2 -dap bcm2837.dap -ap-num 0 -baseaddr 0x8001a000
Debug: 72 1 arm_adi_v5.c:1193 dap_get_ap(): refcount AP#0x0 get 3
Debug: 73 1 command.c:153 script_debug(): command - target create bcm2837.cpu2 aarch64 -dap bcm2837.dap -ap-num 0 -dbgbase 0x80014000 -cti bcm2837.cti2
Debug: 74 1 command.c:259 register_command(): command 'arm' is already registered
Debug: 75 1 command.c:259 register_command(): command 'arm semihosting' is already registered
Debug: 76 1 command.c:259 register_command(): command 'arm semihosting_redirect' is already registered
Debug: 77 1 command.c:259 register_command(): command 'arm semihosting_cmdline' is already registered
Debug: 78 1 command.c:259 register_command(): command 'arm semihosting_fileio' is already registered
Debug: 79 1 command.c:259 register_command(): command 'arm semihosting_resexit' is already registered
Debug: 80 1 command.c:259 register_command(): command 'arm semihosting_read_user_param' is already registered
Debug: 81 1 command.c:259 register_command(): command 'arm semihosting_basedir' is already registered
Debug: 82 1 command.c:259 register_command(): command 'catch_exc' is already registered
Debug: 83 1 command.c:259 register_command(): command 'pauth' is already registered
Debug: 84 1 command.c:259 register_command(): command 'aarch64' is already registered
Debug: 85 1 command.c:259 register_command(): command 'aarch64 cache_info' is already registered
Debug: 86 1 command.c:259 register_command(): command 'aarch64 dbginit' is already registered
Debug: 87 1 command.c:259 register_command(): command 'aarch64 disassemble' is already registered
Debug: 88 1 command.c:259 register_command(): command 'aarch64 maskisr' is already registered
Debug: 89 1 command.c:259 register_command(): command 'aarch64 mcr' is already registered
Debug: 90 1 command.c:259 register_command(): command 'aarch64 mrc' is already registered
Debug: 91 1 command.c:259 register_command(): command 'aarch64 smp' is already registered
Debug: 92 1 command.c:259 register_command(): command 'aarch64 smp_gdb' is already registered
Debug: 93 1 command.c:153 script_debug(): command - bcm2837.cpu2 configure -event reset-assert-post  aarch64  dbginit 
Debug: 94 1 command.c:153 script_debug(): command - cti create bcm2837.cti3 -dap bcm2837.dap -ap-num 0 -baseaddr 0x8001b000
Debug: 95 1 arm_adi_v5.c:1193 dap_get_ap(): refcount AP#0x0 get 4
Debug: 96 1 command.c:153 script_debug(): command - target create bcm2837.cpu3 aarch64 -dap bcm2837.dap -ap-num 0 -dbgbase 0x80016000 -cti bcm2837.cti3
Debug: 97 1 command.c:259 register_command(): command 'arm' is already registered
Debug: 98 1 command.c:259 register_command(): command 'arm semihosting' is already registered
Debug: 99 1 command.c:259 register_command(): command 'arm semihosting_redirect' is already registered
Debug: 100 1 command.c:259 register_command(): command 'arm semihosting_cmdline' is already registered
Debug: 101 1 command.c:259 register_command(): command 'arm semihosting_fileio' is already registered
Debug: 102 1 command.c:259 register_command(): command 'arm semihosting_resexit' is already registered
Debug: 103 1 command.c:259 register_command(): command 'arm semihosting_read_user_param' is already registered
Debug: 104 1 command.c:259 register_command(): command 'arm semihosting_basedir' is already registered
Debug: 105 1 command.c:259 register_command(): command 'catch_exc' is already registered
Debug: 106 1 command.c:259 register_command(): command 'pauth' is already registered
Debug: 107 1 command.c:259 register_command(): command 'aarch64' is already registered
Debug: 108 1 command.c:259 register_command(): command 'aarch64 cache_info' is already registered
Debug: 109 1 command.c:259 register_command(): command 'aarch64 dbginit' is already registered
Debug: 110 1 command.c:259 register_command(): command 'aarch64 disassemble' is already registered
Debug: 111 1 command.c:259 register_command(): command 'aarch64 maskisr' is already registered
Debug: 112 1 command.c:259 register_command(): command 'aarch64 mcr' is already registered
Debug: 113 1 command.c:259 register_command(): command 'aarch64 mrc' is already registered
Debug: 114 1 command.c:259 register_command(): command 'aarch64 smp' is already registered
Debug: 115 1 command.c:259 register_command(): command 'aarch64 smp_gdb' is already registered
Debug: 116 1 command.c:153 script_debug(): command - bcm2837.cpu3 configure -event reset-assert-post  aarch64  dbginit 
Debug: 117 1 command.c:153 script_debug(): command - targets bcm2837.cpu0
Debug: 118 1 command.c:153 script_debug(): command - transport select jtag
Warn : 119 1 transport.c:280 handle_transport_select(): Transport "jtag" was already selected
Debug: 120 1 command.c:153 script_debug(): command - reset_config trst_only
User : 121 1 options.c:52 configuration_output_handler(): trst_only separate trst_push_pullUser : 122 1 options.c:52 configuration_output_handler(): 
Info : 123 1 server.c:298 add_service(): Listening on port 6666 for tcl connections
Info : 124 1 server.c:298 add_service(): Listening on port 4444 for telnet connections
Debug: 125 1 command.c:153 script_debug(): command - init
Debug: 126 1 command.c:153 script_debug(): command - target init
Debug: 127 1 command.c:153 script_debug(): command - target names
Debug: 128 1 command.c:153 script_debug(): command - bcm2837.ap cget -event gdb-flash-erase-start
Debug: 129 1 command.c:153 script_debug(): command - bcm2837.ap configure -event gdb-flash-erase-start reset init
Debug: 130 1 command.c:153 script_debug(): command - bcm2837.ap cget -event gdb-flash-write-end
Debug: 131 1 command.c:153 script_debug(): command - bcm2837.ap configure -event gdb-flash-write-end reset halt
Debug: 132 1 command.c:153 script_debug(): command - bcm2837.ap cget -event gdb-attach
Debug: 133 1 command.c:153 script_debug(): command - bcm2837.ap configure -event gdb-attach halt 1000
Debug: 134 1 command.c:153 script_debug(): command - bcm2837.cpu0 cget -event gdb-flash-erase-start
Debug: 135 1 command.c:153 script_debug(): command - bcm2837.cpu0 configure -event gdb-flash-erase-start reset init
Debug: 136 1 command.c:153 script_debug(): command - bcm2837.cpu0 cget -event gdb-flash-write-end
Debug: 137 1 command.c:153 script_debug(): command - bcm2837.cpu0 configure -event gdb-flash-write-end reset halt
Debug: 138 1 command.c:153 script_debug(): command - bcm2837.cpu0 cget -event gdb-attach
Debug: 139 1 command.c:153 script_debug(): command - bcm2837.cpu0 configure -event gdb-attach halt 1000
Debug: 140 1 command.c:153 script_debug(): command - bcm2837.cpu1 cget -event gdb-flash-erase-start
Debug: 141 1 command.c:153 script_debug(): command - bcm2837.cpu1 configure -event gdb-flash-erase-start reset init
Debug: 142 1 command.c:153 script_debug(): command - bcm2837.cpu1 cget -event gdb-flash-write-end
Debug: 143 1 command.c:153 script_debug(): command - bcm2837.cpu1 configure -event gdb-flash-write-end reset halt
Debug: 144 1 command.c:153 script_debug(): command - bcm2837.cpu1 cget -event gdb-attach
Debug: 145 1 command.c:153 script_debug(): command - bcm2837.cpu1 configure -event gdb-attach halt 1000
Debug: 146 1 command.c:153 script_debug(): command - bcm2837.cpu2 cget -event gdb-flash-erase-start
Debug: 147 1 command.c:153 script_debug(): command - bcm2837.cpu2 configure -event gdb-flash-erase-start reset init
Debug: 148 1 command.c:153 script_debug(): command - bcm2837.cpu2 cget -event gdb-flash-write-end
Debug: 149 1 command.c:153 script_debug(): command - bcm2837.cpu2 configure -event gdb-flash-write-end reset halt
Debug: 150 1 command.c:153 script_debug(): command - bcm2837.cpu2 cget -event gdb-attach
Debug: 151 1 command.c:153 script_debug(): command - bcm2837.cpu2 configure -event gdb-attach halt 1000
Debug: 152 1 command.c:153 script_debug(): command - bcm2837.cpu3 cget -event gdb-flash-erase-start
Debug: 153 1 command.c:153 script_debug(): command - bcm2837.cpu3 configure -event gdb-flash-erase-start reset init
Debug: 154 1 command.c:153 script_debug(): command - bcm2837.cpu3 cget -event gdb-flash-write-end
Debug: 155 1 command.c:153 script_debug(): command - bcm2837.cpu3 configure -event gdb-flash-write-end reset halt
Debug: 156 1 command.c:153 script_debug(): command - bcm2837.cpu3 cget -event gdb-attach
Debug: 157 1 command.c:153 script_debug(): command - bcm2837.cpu3 configure -event gdb-attach halt 1000
Debug: 158 1 target.c:1588 handle_target_init_command(): Initializing targets...
Debug: 159 1 mem_ap.c:61 mem_ap_init_target(): mem_ap_init_target
Debug: 160 1 semihosting_common.c:107 semihosting_common_init():  
Debug: 161 1 semihosting_common.c:107 semihosting_common_init():  
Debug: 162 1 semihosting_common.c:107 semihosting_common_init():  
Debug: 163 1 semihosting_common.c:107 semihosting_common_init():  
Debug: 164 1 ftdi.c:654 ftdi_initialize(): ftdi interface using shortest path jtag state transitions
Debug: 165 14 mpsse.c:427 mpsse_purge(): -
Debug: 166 18 mpsse.c:708 mpsse_loopback_config(): off
Debug: 167 18 mpsse.c:753 mpsse_set_frequency(): target 4000000 Hz
Debug: 168 18 mpsse.c:745 mpsse_rtck_config(): off
Debug: 169 18 mpsse.c:734 mpsse_divide_by_5_config(): off
Debug: 170 18 mpsse.c:714 mpsse_set_divisor(): 7
Debug: 171 18 mpsse.c:777 mpsse_set_frequency(): actually 3750000 Hz
Debug: 172 18 adapter.c:214 adapter_khz_to_speed(): convert khz to adapter specific speed value
Debug: 173 18 adapter.c:218 adapter_khz_to_speed(): have adapter set up
Debug: 174 18 mpsse.c:753 mpsse_set_frequency(): target 4000000 Hz
Debug: 175 18 mpsse.c:745 mpsse_rtck_config(): off
Debug: 176 18 mpsse.c:734 mpsse_divide_by_5_config(): off
Debug: 177 18 mpsse.c:714 mpsse_set_divisor(): 7
Debug: 178 18 mpsse.c:777 mpsse_set_frequency(): actually 3750000 Hz
Debug: 179 18 adapter.c:214 adapter_khz_to_speed(): convert khz to adapter specific speed value
Debug: 180 18 adapter.c:218 adapter_khz_to_speed(): have adapter set up
Info : 181 18 adapter.c:178 adapter_init(): clock speed 4000 kHz
Debug: 182 18 openocd.c:133 handle_init_command(): Debug Adapter init complete
Debug: 183 18 command.c:153 script_debug(): command - transport init
Debug: 184 18 transport.c:219 handle_transport_init(): handle_transport_init
Debug: 185 18 core.c:830 jtag_add_reset(): SRST line released
Debug: 186 18 core.c:855 jtag_add_reset(): TRST line released
Debug: 187 18 core.c:328 jtag_call_event_callbacks(): jtag event: TAP reset
Debug: 188 18 command.c:153 script_debug(): command - jtag arp_init
Debug: 189 18 core.c:1510 jtag_init_inner(): Init JTAG chain
Debug: 190 18 core.c:328 jtag_call_event_callbacks(): jtag event: TAP reset
Debug: 191 18 core.c:1235 jtag_examine_chain(): DR scan interrogation for IDCODE/BYPASS
Debug: 192 18 core.c:328 jtag_call_event_callbacks(): jtag event: TAP reset
Info : 193 18 core.c:1133 jtag_examine_chain_display(): JTAG tap: bcm2837.cpu tap/device found: 0x4ba00477 (mfg: 0x23b (ARM Ltd), part: 0xba00, ver: 0x4)
Debug: 194 18 core.c:1365 jtag_validate_ircapture(): IR capture validation scan
Debug: 195 18 core.c:1422 jtag_validate_ircapture(): bcm2837.cpu: IR capture 0x01
Debug: 196 18 command.c:153 script_debug(): command - dap init
Debug: 197 18 arm_dap.c:96 dap_init_all(): Initializing all DAPs ...
Debug: 198 18 arm_dap.c:120 dap_init_all(): DAP bcm2837.cpu configured by default to use ADIv5 protocol
Debug: 199 18 arm_adi_v5.c:783 dap_dp_init(): bcm2837.dap
Debug: 200 18 arm_adi_v5.c:816 dap_dp_init(): DAP: wait CDBGPWRUPACK
Debug: 201 18 arm_adi_v5.h:682 dap_dp_poll_register(): DAP: poll 4, mask 0x20000000, value 0x20000000
Debug: 202 19 arm_adi_v5.c:824 dap_dp_init(): DAP: wait CSYSPWRUPACK
Debug: 203 19 arm_adi_v5.h:682 dap_dp_poll_register(): DAP: poll 4, mask 0x80000000, value 0x80000000
Debug: 204 19 openocd.c:150 handle_init_command(): Examining targets...
Debug: 205 19 target.c:674 target_examine_one(): [bcm2837.ap] Examination started
Debug: 206 19 target.c:1774 target_call_event_callbacks(): target event 19 (examine-start) for core bcm2837.ap
Debug: 207 19 arm_adi_v5.c:1193 dap_get_ap(): refcount AP#0x0 get 5
Debug: 208 19 arm_adi_v5.c:934 mem_ap_init(): MEM_AP CFG: large data 0, long address 0, big-endian 0
Debug: 209 19 target.c:1774 target_call_event_callbacks(): target event 21 (examine-end) for core bcm2837.ap
Info : 210 19 target.c:690 target_examine_one(): [bcm2837.ap] Examination succeed
Debug: 211 19 target.c:674 target_examine_one(): [bcm2837.cpu0] Examination started
Debug: 212 19 target.c:1774 target_call_event_callbacks(): target event 19 (examine-start) for core bcm2837.cpu0
Debug: 213 19 arm_adi_v5.c:1193 dap_get_ap(): refcount AP#0x0 get 6
Debug: 214 19 arm_adi_v5.c:934 mem_ap_init(): MEM_AP CFG: large data 0, long address 0, big-endian 0
Debug: 215 20 aarch64.c:2685 aarch64_examine_first(): cpuid = 0x410fd034
Debug: 216 20 aarch64.c:2686 aarch64_examine_first(): ttypr = 0x00001122
Debug: 217 20 aarch64.c:2687 aarch64_examine_first(): debug = 0x10305106
Info : 218 20 armv8_dpm.c:1470 armv8_dpm_setup(): bcm2837.cpu0: hardware has 6 breakpoints, 4 watchpoints
Debug: 219 20 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80010408
Debug: 220 20 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80010418
Debug: 221 20 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80010428
Debug: 222 20 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80010438
Debug: 223 21 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80010448
Debug: 224 21 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80010458
Debug: 225 21 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80010808
Debug: 226 21 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80010818
Debug: 227 21 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80010828
Debug: 228 21 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80010838
Debug: 229 22 aarch64.c:2728 aarch64_examine_first(): Configured 6 hw breakpoints, 4 watchpoints
Debug: 230 22 aarch64.c:205 aarch64_init_debug_access(): bcm2837.cpu0
Debug: 231 23 target.c:1774 target_call_event_callbacks(): target event 21 (examine-end) for core bcm2837.cpu0
Info : 232 23 target.c:690 target_examine_one(): [bcm2837.cpu0] Examination succeed
Debug: 233 23 target.c:674 target_examine_one(): [bcm2837.cpu1] Examination started
Debug: 234 23 target.c:1774 target_call_event_callbacks(): target event 19 (examine-start) for core bcm2837.cpu1
Debug: 235 23 arm_adi_v5.c:1193 dap_get_ap(): refcount AP#0x0 get 7
Debug: 236 23 arm_adi_v5.c:934 mem_ap_init(): MEM_AP CFG: large data 0, long address 0, big-endian 0
Debug: 237 24 aarch64.c:2685 aarch64_examine_first(): cpuid = 0x410fd034
Debug: 238 24 aarch64.c:2686 aarch64_examine_first(): ttypr = 0x00001122
Debug: 239 24 aarch64.c:2687 aarch64_examine_first(): debug = 0x10305106
Info : 240 24 armv8_dpm.c:1470 armv8_dpm_setup(): bcm2837.cpu1: hardware has 6 breakpoints, 4 watchpoints
Debug: 241 24 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80012408
Debug: 242 24 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80012418
Debug: 243 24 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80012428
Debug: 244 24 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80012438
Debug: 245 24 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80012448
Debug: 246 24 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80012458
Debug: 247 25 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80012808
Debug: 248 25 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80012818
Debug: 249 25 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80012828
Debug: 250 25 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80012838
Debug: 251 25 aarch64.c:2728 aarch64_examine_first(): Configured 6 hw breakpoints, 4 watchpoints
Debug: 252 25 aarch64.c:205 aarch64_init_debug_access(): bcm2837.cpu1
Debug: 253 27 target.c:1774 target_call_event_callbacks(): target event 21 (examine-end) for core bcm2837.cpu1
Info : 254 27 target.c:690 target_examine_one(): [bcm2837.cpu1] Examination succeed
Debug: 255 27 target.c:674 target_examine_one(): [bcm2837.cpu2] Examination started
Debug: 256 27 target.c:1774 target_call_event_callbacks(): target event 19 (examine-start) for core bcm2837.cpu2
Debug: 257 27 arm_adi_v5.c:1193 dap_get_ap(): refcount AP#0x0 get 8
Debug: 258 27 arm_adi_v5.c:934 mem_ap_init(): MEM_AP CFG: large data 0, long address 0, big-endian 0
Debug: 259 27 aarch64.c:2685 aarch64_examine_first(): cpuid = 0x410fd034
Debug: 260 27 aarch64.c:2686 aarch64_examine_first(): ttypr = 0x00001122
Debug: 261 27 aarch64.c:2687 aarch64_examine_first(): debug = 0x10305106
Info : 262 27 armv8_dpm.c:1470 armv8_dpm_setup(): bcm2837.cpu2: hardware has 6 breakpoints, 4 watchpoints
Debug: 263 27 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80014408
Debug: 264 28 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80014418
Debug: 265 28 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80014428
Debug: 266 28 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80014438
Debug: 267 28 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80014448
Debug: 268 28 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80014458
Debug: 269 28 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80014808
Debug: 270 29 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80014818
Debug: 271 29 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80014828
Debug: 272 29 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80014838
Debug: 273 29 aarch64.c:2728 aarch64_examine_first(): Configured 6 hw breakpoints, 4 watchpoints
Debug: 274 29 aarch64.c:205 aarch64_init_debug_access(): bcm2837.cpu2
Debug: 275 30 target.c:1774 target_call_event_callbacks(): target event 21 (examine-end) for core bcm2837.cpu2
Info : 276 30 target.c:690 target_examine_one(): [bcm2837.cpu2] Examination succeed
Debug: 277 30 target.c:674 target_examine_one(): [bcm2837.cpu3] Examination started
Debug: 278 30 target.c:1774 target_call_event_callbacks(): target event 19 (examine-start) for core bcm2837.cpu3
Debug: 279 30 arm_adi_v5.c:1193 dap_get_ap(): refcount AP#0x0 get 9
Debug: 280 31 arm_adi_v5.c:934 mem_ap_init(): MEM_AP CFG: large data 0, long address 0, big-endian 0
Debug: 281 31 aarch64.c:2685 aarch64_examine_first(): cpuid = 0x410fd034
Debug: 282 31 aarch64.c:2686 aarch64_examine_first(): ttypr = 0x00001122
Debug: 283 31 aarch64.c:2687 aarch64_examine_first(): debug = 0x10305106
Info : 284 31 armv8_dpm.c:1470 armv8_dpm_setup(): bcm2837.cpu3: hardware has 6 breakpoints, 4 watchpoints
Debug: 285 31 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80016408
Debug: 286 31 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80016418
Debug: 287 31 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80016428
Debug: 288 32 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80016438
Debug: 289 32 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80016448
Debug: 290 32 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80016458
Debug: 291 32 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80016808
Debug: 292 32 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80016818
Debug: 293 33 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80016828
Debug: 294 33 armv8_dpm.c:472 dpmv8_bpwp_disable(): A: bpwp disable, cr 80016838
Debug: 295 33 aarch64.c:2728 aarch64_examine_first(): Configured 6 hw breakpoints, 4 watchpoints
Debug: 296 33 aarch64.c:205 aarch64_init_debug_access(): bcm2837.cpu3
Debug: 297 34 target.c:1774 target_call_event_callbacks(): target event 21 (examine-end) for core bcm2837.cpu3
Info : 298 34 target.c:690 target_examine_one(): [bcm2837.cpu3] Examination succeed
Debug: 299 34 command.c:153 script_debug(): command - flash init
Debug: 300 34 tcl.c:1364 handle_flash_init_command(): Initializing flash devices...
Debug: 301 34 command.c:153 script_debug(): command - nand init
Debug: 302 34 tcl.c:484 handle_nand_init_command(): Initializing NAND devices...
Debug: 303 34 command.c:153 script_debug(): command - pld init
Debug: 304 34 pld.c:337 handle_pld_init_command(): Initializing PLDs...
Debug: 305 34 command.c:153 script_debug(): command - tpiu init
Info : 306 34 gdb_server.c:3874 gdb_target_add_one(): [bcm2837.ap] gdb port disabled
Info : 307 34 gdb_server.c:3840 gdb_target_start(): [bcm2837.cpu0] starting gdb server on 3333
Info : 308 34 server.c:298 add_service(): Listening on port 3333 for gdb connections
Info : 309 34 gdb_server.c:3840 gdb_target_start(): [bcm2837.cpu1] starting gdb server on 3334
Info : 310 34 server.c:298 add_service(): Listening on port 3334 for gdb connections
Info : 311 34 gdb_server.c:3840 gdb_target_start(): [bcm2837.cpu2] starting gdb server on 3335
Info : 312 34 server.c:298 add_service(): Listening on port 3335 for gdb connections
Info : 313 34 gdb_server.c:3840 gdb_target_start(): [bcm2837.cpu3] starting gdb server on 3336
Info : 314 34 server.c:298 add_service(): Listening on port 3336 for gdb connections
Debug: 315 34 command.c:153 script_debug(): command - target names
Debug: 316 34 command.c:153 script_debug(): command - target names
Debug: 317 34 command.c:153 script_debug(): command - bcm2837.ap cget -type
Debug: 318 34 command.c:153 script_debug(): command - bcm2837.cpu0 cget -type
Debug: 319 34 command.c:153 script_debug(): command - bcm2837.cpu1 cget -type
Debug: 320 34 command.c:153 script_debug(): command - bcm2837.cpu2 cget -type
Debug: 321 34 command.c:153 script_debug(): command - bcm2837.cpu3 cget -type
```
