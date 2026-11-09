-- DMS Window Rules — managed by Dux Shell
-- Do not edit manually; changes may be overwritten

-- DMS-RULE: id=dms-floating-windows, name=DMS Floating Windows
hl.window_rule({ match = { class = "^(dev\\.duxlabs\\.shell|com\\.danklinux\\.dms)$" }, float = true })

-- DMS-RULE: id=wr_1793812966840324158, name=dev.duxlabs.files
hl.window_rule({ match = { class = "^dev.duxlabs.files$" }, float = true, size = { 1200, 800 } })

-- DMS-RULE: id=wr_1793813174703624153, name=dev.duxlabs.calendar
hl.window_rule({ match = { class = "^dev.duxlabs.calendar$" }, float = true, size = { 1050, 800 } })

-- DMS-RULE: id=wr_1793815409092434429, name=org.gnome.Ptyxis
hl.window_rule({ match = { class = "^org.gnome.Ptyxis$" }, float = true, size = { 800, 600 } })

-- DMS-RULE: id=wr_1793821336290487207, name=io.github.kolunmi.Bazaar
hl.window_rule({ match = { class = "^io.github.kolunmi.Bazaar$" }, float = true, size = { 1000, 800 } })

-- DMS-RULE: id=dms-window-opaque, name=DMS Window Opaque
hl.window_rule({ match = { class = "^(dev\\.duxlabs\\.shell|com\\.danklinux\\.dms)$" }, opaque = true })
