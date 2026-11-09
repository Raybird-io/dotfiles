-- binds.lua
-- My keybinds, on top of Dux Shell's.
-- If a key seems ignored or does two things, Dux probably binds it too:
-- check with `hyprctl binds`, then hl.unbind("…") it before binding it here.

------------------------------------------------------------
-- Apps
------------------------------------------------------------
hl.bind("SUPER + T", hl.dsp.exec_cmd("ghostty"))

------------------------------------------------------------
-- Smart up/down
-- If the focused window is fullscreen (e.g. a game), slide to the next
-- workspace on this monitor, leaving the game fullscreen and untouched.
-- Otherwise, just move focus to the window above/below as normal.
------------------------------------------------------------
local function smart_move(focus_direction, workspace_step)
    return function()
        local focused_window = hl.get_active_window()

        -- "fullscreen" is a number: 0 = not fullscreen, anything else = fullscreen
        if focused_window ~= nil and focused_window.fullscreen ~= 0 then
            hl.dispatch(hl.dsp.focus({ workspace = workspace_step }))
        else
            hl.dispatch(hl.dsp.focus({ direction = focus_direction }))
        end
    end
end

hl.unbind("SUPER + Down")   -- remove Dux Shell's version first
hl.unbind("SUPER + Up")
hl.bind("SUPER + Down", smart_move("down", "m+1"))   -- m+1 = next workspace on this monitor
hl.bind("SUPER + Up",   smart_move("up",   "m-1"))   -- m-1 = previous workspace on this monitor

------------------------------------------------------------
-- Move the focused window to the workspace above/below,
-- staying on THIS monitor ("m" = only workspaces on this monitor)
------------------------------------------------------------
hl.bind("SUPER + CTRL + mouse_up",
    hl.dsp.window.move({ workspace = "m-1" }),
    { description = "↑ Move to workspace above (this monitor)" })

hl.bind("SUPER + CTRL + mouse_down",
    hl.dsp.window.move({ workspace = "m+1" }),
    { description = "↓ Move to workspace below (this monitor)" })
