![Alt text](DoubleTakeImages/DTLogo.png "Double Take Logo")
# DoubleTake
An Xcode extension that removes duplicate imports from the file you're currently working on

# What made me build it?
I created it because I was working on a legacy project that has a lot of places with duplicate imports. This was causing a lot of clutter and messy looking code.

# Examples
TODO

# Tip
Finding it too slow to move your mouse to the Editor menu all the time? Create a shortcut for DoubleTake by going to XCode > Preferences > Key Bindings and filter by DoubleTake.
From there you can assign any keyboard shortcut you like.

# Installation
- Clone/Download the repo
- Open DoubleTake.xcodeproj
- Enable target signing for both the Application and the XCode Extension using your own developer ID
- Select the application target and then Product > Archive
- Export the archive as a macOS App
- Run the app, then you can quit it but dont delete it
- Go to System Preferences -> Extensions -> Xcode Source Editor and enable the DoubleTake extension
- The menu-item should now be available from Xcode's Editor menu

# License
MIT, see LICENSE
