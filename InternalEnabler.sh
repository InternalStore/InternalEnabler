#!/bin/bash
echo Welcome to InternalEnabler v1.0!
echo Please select an option:
echo 1. Install
echo 2. Uninstall
read -r option
if [ "$option" = "1" ] ; then
  echo
  echo "Making a backup of SystemVersion.plist..."
  cd /System/Library/CoreServices/
  cp SystemVersion.plist /System/Library/CoreServices/SystemVersion.plist.bak
  echo "Done!"
  echo
  echo "Installing plutil..."
  apt-get install com.bingner.plutil
  echo "Done!"
  echo
  echo "Modifying ProductType..."
  plutil -ProductType -string "Internal" SystemVersion.plist
  echo "Done!"
  echo
  echo "Modifying ReleaseType..."
  plutil -ReleaseType -string "Internal" SystemVersion.plist
  echo "Done!"
  echo
  echo "SystemVersion.plist successfully modified!"
  echo
  echo "Installing Tap-to-Radar..."
  apt -y --allow-unauthenticated install wget
  cd /Applications/
  wget https://cdn-35.anonfiles.com/b3we63J6p4/0316432e-1613532874/Tap-to-Radar.zip --no-check-certificate
  unzip Tap-to-Radar.zip
  mv /Applications/Tap-to-Radar/Tap-to-Radar.app /Applications/
  rm -rf /Applications/Tap-to-Radar/
  echo "Done!"
  echo
  echo "The installation process has finished successfully."
  echo "The device will now respring..."
  ldrestart
 
elif [ "$option" = "2" ] ; then
  echo
  echo "Reverting SystemVersion.plist..."
  cd /System/Library/CoreServices/  
  plutil -ProductType -remove SystemVersion.plist
  plutil -ReleaseType -remove SystemVersion.plist
  echo "Done!"
  echo
  echo "Uninstalling Tap-to-Radar"
  rm -rf /Applications/Tap-to-Radar.app/
  echo "Done!"
  echo
  echo "The uninstallation process has finsihed successfully."
  echo "The device wil now respring..."
  ldrestart
fi
