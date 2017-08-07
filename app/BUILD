load("//tools:avrdude_flash.bzl", "avrdude_flash")

cc_binary (
    name = "app",
    srcs = ["main.c"],
)

avrdude_flash(
    name = "flash",
    binary = ":app",
)