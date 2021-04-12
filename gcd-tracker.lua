GCDTracker = {}

local abilities = {}
local time = 0

function GCDTracker.OnInitialize()
    RegisterEventHandler(SystemData.Events.PLAYER_BEGIN_CAST, "GCDTracker.OnCast")
    for i=1,3 do
        CreateWindowFromTemplate("GCDTracker-"..i,"GCDTracker","Root")
        WindowSetShowing("GCDTracker-"..i, true)
        LabelSetTextColor("GCDTracker-"..i.."Text", 255, 255, 255)
        LayoutEditor.RegisterWindow("GCDTracker-"..i, L"GCDTracker"..i,L"Global Cooldown Tracker", true, true, true, nil, nil, false, 1, nil, nil )
    end
end
function GCDTracker.OnCast(abilityId)
    local ability = Player.GetAbilityData(abilityId)
    if not ability then
        return
    end

    if time <= 1.4 then
        return
    end
    time = 0
    local texture, x, y = GetIconData( ability.iconNum )

    abilities[3] = abilities[2]
    abilities[2] = abilities[1]
    abilities[1] = {
        x = x,
        y = y,
        texture = texture,
        name = ability.name,
    }

    for i=1,3 do 
        if abilities[i] ~= nil then
            WindowStartAlphaAnimation("GCDTracker-"..i, Window.AnimationType.EASE_OUT, 0.33 * (4 - i), 1 - (.33 * i), 1.4, true, 0, 0)
            DynamicImageSetTexture(
                "GCDTracker-"..i.."Image",
                abilities[i].texture,
                abilities[i].x,
                abilities[i].y
            )
            LabelSetText("GCDTracker-"..i.."Text", abilities[i].name)
        end
    end
end

function GCDTracker.OnUpdate(elapsed)
    time = time + elapsed
end
