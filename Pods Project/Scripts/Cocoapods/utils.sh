#!/bin/bash

fixWarnings() {
    # Project last update check fix
    sed -i '' -e $'s/LastUpgradeCheck = [0-9]*;/LastUpgradeCheck = 9999;\\\n\t\t\t\tLastSwiftMigration = 9999;/g' 'Pods/Pods.xcodeproj/project.pbxproj'
    
    # Schemes last update verions fix
    find Pods/Pods.xcodeproj/xcuserdata -type f -name '*.xcscheme' -exec sed -i '' -e 's/LastUpgradeVersion = \"[0-9]*\"/LastUpgradeVersion = \"9999\"/g' {} +
}
