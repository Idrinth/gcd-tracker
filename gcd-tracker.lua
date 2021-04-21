GCDTracker = {}

local abilities = {}
local time = 0
local mayCast = true
function slash(input)
    if input == "text" then
        GCDTracker.Settings.text = not GCDTracker.Settings.text
        for i=1,3 do
            WindowSetShowing("GCDTracker-"..i.."Text", GCDTracker.Settings.text)
        end
        TextLogAddEntry("Chat", SystemData.ChatLogFilters.SAY, towstring("Toggled text to "..tostring(GCDTracker.Settings.text)))
    elseif input == "image" then
        GCDTracker.Settings.image = not GCDTracker.Settings.image
        for i=1,3 do
            WindowSetShowing("GCDTracker-"..i.."Circle", GCDTracker.Settings.image)
            WindowSetShowing("GCDTracker-"..i.."Square", not GCDTracker.Settings.image)
            WindowSetShowing("GCDTracker-"..i.."Text", true)
        end
        if GCDTracker.Settings.image then
            TextLogAddEntry("Chat", SystemData.ChatLogFilters.SAY, L"Toggled image to circle")
        else
            TextLogAddEntry("Chat", SystemData.ChatLogFilters.SAY, L"Toggled image to square")
        end
    else
        TextLogAddEntry("Chat", SystemData.ChatLogFilters.SAY, L"Use the command with a toggle: text")
    end
end
function GCDTracker.OnInitialize()
    GCDTracker.Settings = GCDTracker.Settings or {}
    RegisterEventHandler(SystemData.Events.PLAYER_BEGIN_CAST, "GCDTracker.OnCast")
    CreateWindow("GCDTracker",true)
    LayoutEditor.RegisterWindow("GCDTracker", L"GCDTracker",L"", false, false, true, nil )
    if LibSlash and LibSlash.RegisterSlashCmd then
        LibSlash.RegisterSlashCmd( "gcdtracker", slash )
        LibSlash.RegisterSlashCmd( "gcdt", slash )
    end
    if GCDTracker.Settings.text == nil then
        GCDTracker.Settings.text = true
    end
    if GCDTracker.Settings.image == nil then
        GCDTracker.Settings.image = true
    end
    for i=1,3 do
        WindowSetShowing("GCDTracker-"..i.."Square", not GCDTracker.Settings.image)
        WindowSetShowing("GCDTracker-"..i.."Circle", GCDTracker.Settings.image)
        WindowSetShowing("GCDTracker-"..i.."Text", GCDTracker.Settings.text)
        LabelSetTextColor("GCDTracker-"..i.."Text", 255, 255, 255)
    end
end
function GCDTracker.OnCast(abilityId)
    local ability = Player.GetAbilityData(abilityId)
    if not ability or not mayCast then
        return
    end
    mayCast = false
    local texture, x, y = GetIconData( ability.iconNum )

    abilities[3] = abilities[2]
    abilities[2] = abilities[1]
    abilities[1] = {
        x = x,
        y = y,
        texture = texture,
        name = ability.name,
    }
end

function GCDTracker.OnUpdate(elapsed)
    time = time + elapsed
    if time < 1.4 then
        WindowClearAnchors("GCDTracker-1")
        WindowAddAnchor("GCDTracker-1", "left", "GCDTracker", "left", 120/1.4*time, 0)
        return
    end
    WindowClearAnchors("GCDTracker-1")
    WindowAddAnchor("GCDTracker-1", "left", "GCDTracker", "left", 0, 0)
    if mayCast then
        abilities[3] = abilities[2]
        abilities[2] = abilities[1]
        abilities[1] = nil
    end
    mayCast = true
    time = 0
    for i=1,3 do
        if abilities[i] ~= nil then
            WindowSetShowing("GCDTracker-"..i, true)
            if i > 1 then
                WindowStartAlphaAnimation(
                    "GCDTracker-"..i,
                    Window.AnimationType.EASE_OUT,
                    0.5 * (4 - i),
                    0.5 * (3 - i),
                    1.4,
                    true,
                    0,
                    0
                )
            end
            local winX, winY = WindowGetDimensions("GCDTracker-"..i.."Image")
            CircleImageSetTexture (
                "GCDTracker-"..i.."Circle",
                abilities[i].texture,
                abilities[i].x + winX/2,
                abilities[i].y + winY/2
            )
            DynamicImageSetTexture (
                "GCDTracker-"..i.."Square",
                abilities[i].texture,
                abilities[i].x,
                abilities[i].y
            )
            LabelSetText("GCDTracker-"..i.."Text", abilities[i].name)
        else
            WindowSetShowing("GCDTracker-"..i, false)
        end
    end
end