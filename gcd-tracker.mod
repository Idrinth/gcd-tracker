<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">   
  <UiMod name="GCDTracker" version="1.1.1" date="2021-04-21" >
    <Author name="Idrinth"/>
    <Description text="Tracks Ability usage in a window. This is meant for streamers." />      
    <VersionSettings gameVersion="1.4.8" />      
    <Dependencies>
    </Dependencies>             
    <Files>         
      <File name="gcd-tracker.lua" />
      <File name="window.xml" />
    </Files>
    <SavedVariables>
      <SavedVariable name="GCDTracker.Settings"/>
    </SavedVariables>
    <OnInitialize>
      <CallFunction name="GCDTracker.OnInitialize" />
    </OnInitialize>
    <OnUpdate>
      <CallFunction name="GCDTracker.OnUpdate" />
    </OnUpdate>
    <OnShutdown/>
  </UiMod>
</ModuleFile>