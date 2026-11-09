-- animation.lua
-- Niri's spring animations, converted for Hyprland.
-- damping = 2 × damping_ratio × √stiffness   (mass is always 1, like Niri)

------------------------------------------------------------
-- The springs (named once, used below)
------------------------------------------------------------
hl.curve("niri_open",      { type = "spring", mass = 1, stiffness = 1000, damping = 41.1 })  -- ratio 0.65: a little bounce
hl.curve("niri_move",      { type = "spring", mass = 1, stiffness = 900,  damping = 42.0 })  -- ratio 0.7
hl.curve("niri_workspace", { type = "spring", mass = 1, stiffness = 900,  damping = 45.0 })  -- ratio 0.75
hl.curve("niri_close",     { type = "spring", mass = 1, stiffness = 1200, damping = 69.3 })  -- ratio 1.0: no bounce

------------------------------------------------------------
-- Which animation uses which spring
-- ("speed" is required by Hyprland but ignored for springs:
--  the stiffness and damping decide how fast it is)
------------------------------------------------------------
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 1, spring = "niri_open",  style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 1, spring = "niri_move" })   -- move, resize AND scrolling
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 1, spring = "niri_close", style = "popin 80%" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 1, spring = "niri_workspace", style = "slidevert" })

-- Resizing feels too bouncy? Use damping = 54.0 (Niri's resize value) for niri_move.
