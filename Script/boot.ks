set Ship:Control:PilotMainThrottle to 0.
Core:DoEvent("open terminal").
clearscreen.
set Terminal:Height to 100.
set Terminal:Width to 60.
switch to 0.
print "Boot".
run once globals.
run once libsystem.
run once libdev.

debugAutoStart(). // debug hook

local tmp is Core:Part:Tag:Split(" ").
set gShipType to tmp[0].
if(tmp:Length=2 and tmp[1]="xx") {
    // hacky sign that we already did the setup
    print "  Already configured".//: tmp:Length=" +tmp:Length.
} else {
    run once libsetup.
    doInitialSetup(tmp).
}
switch to 1.
run params.ks.
loadPersistent().
writePersistent().
findParts().

if (pMissionCounter > 0) {
    Ship:PartsDubbed(gShipType+"Control")[0]
        :GetModule("ModuleCommand"):DoEvent("control from here").
    switch to 0.
    run once libmission.
    resumeMission().
} else {
    print "  No active mission".
}