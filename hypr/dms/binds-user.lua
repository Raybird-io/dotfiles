-- Your keybinds. dms setup never overwrites this file.
-- Loaded after binds.lua: binding a stock key here replaces it, hl.unbind("SUPER + X") frees it.
-- Saving in the DMS keybind editor rewrites this file and keeps only hl.bind/hl.unbind lines.

hl.unbind("SUPER + E")
hl.bind("SUPER + E", hl.dsp.exec_cmd("dms ipc call defaultApp fileManager"), { description = "Default File Manager: Open" })
hl.unbind("SUPER + T")
hl.bind("SUPER + T", hl.dsp.exec_cmd("ptyxis --new-window"), { description = "Terminal" })
hl.unbind("SUPER + Return")
hl.unbind("SUPER + B")
hl.bind("SUPER + B", hl.dsp.exec_cmd("dms ipc call defaultApp browser"), { description = "Default Web Browser: Open" })
