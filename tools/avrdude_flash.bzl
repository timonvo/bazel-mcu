def _flash_impl(ctx):
  # This is a hack... We know avr-size should be located next to the other
  # toolchain tools, so we just use the "ar" tool's path to get to the
  # "avr-size" tool path. Not the cleanest, but it gets the job done.
  avr_size = str(ctx.fragments.cpp.ar_executable).replace("ar", "size")
  ctx.file_action(
      output=ctx.outputs.executable,
      content=ctx.expand_make_variables(
          "cmd",
          """
#!/bin/bash
$(AVR_SIZE) -C --mcu=$(MCU) $(BINARY)
avrdude -p $(MCU) -c $(PROGR) -e -D -U flash:w:$(BINARY):a -u
""",
          {
            "AVR_SIZE": avr_size,
            "BINARY": ctx.executable.binary.short_path,
          }),
      executable=True
  )
  return [DefaultInfo(runfiles=ctx.runfiles(files=ctx.files.binary))]


avrdude_flash = rule(
    implementation=_flash_impl,
    executable=True,
    fragments=["cpp"],
    attrs = {
        "binary": attr.label(cfg="data", mandatory=True, allow_files=True,
             executable=True, single_file=True),
    },
)
