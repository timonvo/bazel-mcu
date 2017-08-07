# MCU workspace for bazel

## Introduction

To build the app for an ATMega328p with an 8MHz clock, run:

`bazel build //app --config atmega328p --config clock_8mhz`

To flash the app to your device with an AVR Dragon ISP programmer, run:

`bazel build //app:flash --config atmega328p --config clock_8mhz`

You need to have avr-gcc installed. Change toolchain/CROSSTOOL to fit your
installation path. `tools/bazel.rc` contains some initial cpu and programmer
configurations. Modify it to add support for more.

## Using symlinks to "install" the workspace in an existing project

To use this workspace in an existing project, you can install symlinks to the
`toolchain` and `tools` directories. That way you can clone this project once
and share it and the configuration in `tools/bazel.rc` across different bazel
projects.