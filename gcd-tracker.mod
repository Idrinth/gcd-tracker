<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">   
  <UiMod name="GCDTracker" version="1.0.0" date="2021-03-08" >
    <Author name="Idrinth"/>
    <Description text="Tracks Ability usage in a window. This is meant for streamers." />      
    <VersionSettings gameVersion="1.4.8" />      
    <Dependencies>
    </Dependencies>             
    <Files>         
      <File name="gcd-tracker.lua" />
      <File name="window.xml" />
    </Files>      
    <SavedVariables/>
    <OnInitialize>
      <CallFunction name="GCDTracker.OnInitialize" />
    </OnInitialize>
    <OnShutdown/>
  </UiMod>
</ModuleFile>