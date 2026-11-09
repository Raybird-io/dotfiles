-- rules.lua
-- Window rules and game handling.
-- Note: Hyprland's rule patterns must match the WHOLE name,
-- so a name with a changing part needs ".*" at the end.

------------------------------------------------------------
-- Steam: pop-ups float, the main window ("Steam") tiles
------------------------------------------------------------
hl.window_rule({
    name  = "steam-popups-float",
    match = { class = "^steam$", title = "negative:^Steam$" },
    float = true,
})

------------------------------------------------------------
-- Games: when a Steam/Proton game goes FULLSCREEN, move it once
-- to a fresh empty workspace below the current one.
-- (Launchers, pop-ups and notifications, e.g. Battle.net,
--  never go fullscreen, so they stay where they are.)
------------------------------------------------------------
local already_moved_games = {}   -- remembers which game windows we've moved (by address)

hl.on("window.fullscreen", function(window)
    if window == nil then return end

    -- Only when going INTO fullscreen (0 = not fullscreen)
    if window.fullscreen == 0 then return end

    -- Only Steam/Proton windows
    -- (Lua's :match only needs the START to match, unlike Hyprland's rules)
    if window.class == nil or not window.class:match("^steam_app_") then return end

    -- Only move each game once (moving re-applies fullscreen, which would
    -- otherwise fire this event again and again)
    if already_moved_games[window.address] then return end
    already_moved_games[window.address] = true

    hl.dispatch(hl.dsp.window.move({
        window    = "address:" .. window.address,   -- this exact window
        workspace = "emptynm",                      -- next empty workspace, this monitor
    }))
end)

-- Forget closed windows, so the list doesn't grow forever
hl.on("window.close", function(window)
    if window ~= nil then
        already_moved_games[window.address] = nil
    end
end)
