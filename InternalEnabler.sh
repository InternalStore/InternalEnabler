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
  plutil -insert ProductType -string "Internal" SystemVersion.plist
  echo "Done!"
  echo
  echo "Modifying ReleaseType..."
  plutil -insert ReleaseType -string "Internal" SystemVersion.plist
  echo "Done!"
  echo
  echo "SystemVersion.plist successfully modified!"
  echo "The device will now respring..."
  ldrestart
 
elif [ "$option" = "2" ] ; then
  echo
  echo "Uninstalling modified SystemVersion.plist..."
  cd /System/Library/CoreServices/  
  rm -rf SystemVersion.plist
  echo "Done!"
  echo
  echo "Restoring original SystemVersion.plist from backup..."
  mv /System/Library/CoreServices/SystemVersion.plist.bak /System/Library/CoreServices/SystemVersion.plist
  echo "Done!"
  echo
  echo "The device wil now respring..."
  ldrestart
fi
