GCDTracker = {}

function GCDTracker.OnInitialize()
    RegisterEventHandler(SystemData.Events.PLAYER_BEGIN_CAST, "GCDTracker.OnCast")
    CreateWindow("GCDTracker", true)
    WindowSetShowing("GCDTracker", true)
    LabelSetTextColor("GCDTrackerText", 255, 255, 255)
    LayoutEditor.RegisterWindow("GCDTracker", L"GCDTracker",L"Global Cooldown Tracker", true, true, true, nil, nil, false, 1, nil, nil )
end
function GCDTracker.OnCast(abilityId)
    local ability = Player.GetAbilityData(abilityId)
    local texture, x, y = GetIconData( ability.iconNum )
    DynamicImageSetTexture("GCDTrackerImage", texture, x, y)
    LabelSetText("GCDTrackerText", ability.name)
    WindowStartAlphaAnimation("GCDTracker", Window.AnimationType.EASE_OUT, 1, 0, 1.4, true, 0, 0)
end