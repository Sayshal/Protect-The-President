Original gamemode by Blt950 (http://facepunch.com/showthread.php?t=1426907&p=46074543&viewfull=1#post46074543 / http://blt950.com/)

Map Installation (serverside):
Grab The Map: http://steamcommunity.com/sharedfiles/filedetails/?id=185951327
Grab GMAD Extractor: http://www.treesoft.dk/gmod/gmad/
Run GMAD, Find the .GMA file in the browser, extract it, and place the .bsp in garrysmod/maps (on the server).
No need to add it to FastDL if you're using the workshop link in gamemodes/presidentprotect/gamemode/init.lua!

------------------------------------

TODO List For Protect The President:
  1. Find a decent map for PTP FIXED
  2. Test all supposed 'features' and define a list of bugs and bug fixes.
  3. Offer a non-SQL option.
  4. Look over all current code and optimize/update variables to be more readable. 
  5. Create a central configuration option.
    a) Go through all files and define what should be part of the global configuration
    b) Add enable/disable modules, define 'core' (needed) modules
    c) Verify integration with ULX (usingULX =true/false, if false, defaults?)
  6. Create a central locale configuration for all pre-determined messages.
  7. Find better chat colors, so ugly D: (maybe global config?)
