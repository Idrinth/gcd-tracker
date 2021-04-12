GCDTracker = {}

local abilities = {}
local time = 0
local mayCast = true

function GCDTracker.OnInitialize()
    RegisterEventHandler(SystemData.Events.PLAYER_BEGIN_CAST, "GCDTracker.OnCast")
    CreateWindow("GCDTracker",true)
    WindowSetShowing("GCDTracker", true)
    LayoutEditor.RegisterWindow("GCDTracker", L"GCDTracker",L"Global Cooldown Tracker", true, true, true, nil, nil, false, 1, nil, nil )
    for i=1,3 do
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
            WindowStartAlphaAnimation("GCDTracker-"..i, Window.AnimationType.EASE_OUT, 0.33 * (4 - i), 1 - (.33 * i), 1.4, true, 0, 0)
            DynamicImageSetTexture(
                "GCDTracker-"..i.."Image",
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