if ! [ -d Localizations/English ]; then
  mkdir Localizations/English
fi

nibtool -L English.lproj/MainMenu.nib > Localizations/English/MainUI.strings
nibtool -L English.lproj/OpenURLPanel.nib > Localizations/English/OpenURLPanel.strings

nibtool -L Preferences/General/English.lproj/Preferences.nib > Localizations/English/PreferencesUI.strings

cp English.lproj/Localizable.strings Localizations/English/MainProgram.strings
cp Preferences/General/English.lproj/Localizable.strings Localizations/English/PreferencesProgram.strings
cp English.lproj/Credits.html Localizations/English/Credits.html
cp English.lproj/Help/index.html Localizations/English/help.html

