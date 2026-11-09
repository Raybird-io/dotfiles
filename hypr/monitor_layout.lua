-- monitor_layout.lua
-- Scrolling layout per monitor, with dynamic workspaces.
-- Everything you'd normally change is in the two tables near the top.

------------------------------------------------------------
-- General settings (all monitors, unless overridden below)
------------------------------------------------------------
hl.config({
    general = {
        gaps_in  = 8,     -- Niri gap 16 = 8 on each side of a window
        gaps_out = 80,    -- fallback; the per-monitor settings below override this
    },

    scrolling = {
        focus_fit_method         = 1,      -- 1 = move the view as little as possible (0 = centre)
        follow_focus             = 1,      -- view moves to show a newly focused window
        follow_min_visible       = 0.4,    -- focus can follow onto even a thin sliver
        fullscreen_on_one_column = false,  -- a lone window keeps its size, not the whole screen
        column_width             = 0.33,   -- fallback size for monitors not listed below
    },
})

------------------------------------------------------------
-- Window size for each scroll direction
-- Sideways monitors: the size is the window's WIDTH.
-- Vertical monitors: the size is the window's HEIGHT.
------------------------------------------------------------
local window_size_by_scroll_direction = {
    right = 0.33,
    left  = 0.33,
    down  = 0.5,
    up    = 0.5,
}

------------------------------------------------------------
-- My monitors and their settings
------------------------------------------------------------
local monitor_settings = {
    -- Ultrawide: scroll sideways; big edge gaps
    {
        name      = "DP-1",
        direction = "right",
        gaps_out  = 80,
    },
    -- Portrait: stack vertically; small edge gaps
    {
        name      = "DP-2",
        direction = "down",
        gaps_out  = 10,
    },
}

------------------------------------------------------------
-- Give every workspace on a monitor that monitor's settings,
-- and remember each monitor's scroll direction for later
------------------------------------------------------------
local scroll_direction_by_monitor = {}   -- filled below, e.g. "DP-2" → "down"

-- "ipairs" goes through a list one item at a time, in order.
-- Each round, "monitor" is one entry from monitor_settings.
-- (The "_" holds the item's position in the list, which we don't need.)
for _, monitor in ipairs(monitor_settings) do
    -- Hyprland filter meaning "every workspace on this monitor", e.g. "m[DP-1]"
    local all_workspaces_on_this_monitor = "m[" .. monitor.name .. "]"

    hl.workspace_rule({
        workspace   = all_workspaces_on_this_monitor,
        layout      = "scrolling",
        layout_opts = { direction = monitor.direction },
        gaps_out    = monitor.gaps_out,
    })

    scroll_direction_by_monitor[monitor.name] = monitor.direction
end

------------------------------------------------------------
-- Resize a window that OPENS on, or is MOVED to, a scrolling workspace
------------------------------------------------------------
local function resize_window_for_its_workspace(window, workspace)
    -- Missing information? Do nothing.
    if window == nil or workspace == nil or workspace.monitor == nil then return end

    -- Only the scrolling layout; other layouts are left alone
    if workspace.tiled_layout ~= "scrolling" then return end

    -- Floating windows are left alone
    if window.floating then return end

    -- Look up the size: monitor → scroll direction → size
    local scroll_direction = scroll_direction_by_monitor[workspace.monitor.name]
    local new_size         = window_size_by_scroll_direction[scroll_direction]
    if new_size == nil then return end   -- monitor not in my settings

    -- "colresize" resizes the FOCUSED window, so only act if it's this window
    local focused_window = hl.get_active_window()
    if focused_window ~= nil and focused_window.address == window.address then
        hl.dispatch(hl.dsp.layout("colresize " .. new_size))
    end
end

-- When a new window opens: size it for the workspace it opened on
hl.on("window.open", function(opened_window)
    resize_window_for_its_workspace(opened_window, opened_window.workspace)
end)

-- When a window is moved: size it for the workspace it moved to
hl.on("window.move_to_workspace", function(moved_window, target_workspace)
    resize_window_for_its_workspace(moved_window, target_workspace)
end)
