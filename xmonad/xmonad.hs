--------------------------------------------------------------------
--                                                    /\ \         |
--        __  _   ___ ___     ___     ___      __     \_\ \        |
--       /\ \/'\/' __` __`\  / __`\ /' _ `\  /'__`\   /'_` \       |
--       \/>  <//\ \/\ \/\ \/\ \L\ \/\ \/\ \/\ \L\.\_/\ \L\ \      |
--       /\_/\_\ \_\ \_\ \_\ \____/\ \_\ \_\ \__/.\_\ \___,_\      |
--        \//\/_/\/_/\/_/\/_/\/___/  \/_/\/_/\/__/\/_/\/__,_ /     |
--------------------------------------------------------------------
---------- base -----------
import XMonad

-------- Actions ---------
import XMonad.Actions.UpdatePointer
import XMonad.Actions.FindEmptyWorkspace
import XMonad.Actions.WithAll (killAll)

--------- Hooks ----------
import XMonad.ManageHook (doFloat)                                                              --for manageHook
import XMonad.Hooks.ManageHelpers (doCenterFloat, doFullFloat, isFullscreen)                    --for manageHook
import XMonad.Hooks.ManageDocks (avoidStruts, docks)                                            --for xmobar
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, xmobarPP, xmobarColor, wrap, shorten, PP(..)) --for xmobar

--------- layout ---------
import XMonad.Layout.ThreeColumns
import XMonad.Layout.OneBig

----- Layouts/Modifiers ----
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances

-------- Utilities --------
import XMonad.Util.EZConfig (additionalKeysP)                                                   -- for keybidings
import XMonad.Util.Run (spawnPipe, hPutStrLn)                                                   -- for xmobar
import XMonad.Util.SpawnOnce (spawnOnce)                                                        -- autoStart App
import XMonad.Util.Cursor

------------------------------------------- Color Pallatte ------------------------------------------------
-----[ Gruvbox ] -----
bg0     = "#1d2021"
bg1     = "#282828"
bg2     = "#32302f"
bg3     = "#3c3836"
bg4     = "#504945"
bg5     = "#665c54"
bg6     = "#7c6f64"
grey    = "#928374"

fg0     = "#fbf1c7"
fg1     = "#d5c4a1"
fg2     = "#bdae93"
fg3     = "#a89984"

red     = "#fb4934"
green   = "#b8bb26"
yellow  = "#fabd2f"
blue    = "#83a598"
purple  = "#d3869b"
aqua    = "#8ec07c"
orange  = "#fe8019"

red1    = "#cc241d"
green1  = "#98971a"
yellow1 = "#d79921"
blue1   = "#458588"
purple1 = "#b16286"
aqua1   = "#689d6a"
orange1 = "#d65d0e"

---- [ CATPUCCIN ] ----
black0  = "#161320"
black1  = "#1A1826"
black2  = "#1E1E2E"
black3  = "#302D41"
black4  = "#575268"

--------------------------------------------- Variable XMonad --------------------------------------------
myModMask       = mod1Mask                                                          -- Sets Mod Key to alt/Super/Win/Fn.
myTerminal      = "urxvt"                                                           -- Sets default Terminal Emulator.
myBorderWidth   = 2                                                                 -- Sets Border Width in pixels.
myNormalColor   = bg0                                                               -- Border color of normal windows.
myFocusedColor  = blue1                                                             -- Border color of focused windows.
myFont          = "xft:JetBrains Mono:Regular:size=10"
myBigFont       = "xft:Source Code Pro:Bold:size=30"
myWideFont      = "xft:DejaVu Sans Mono:Bold:size=50:antialias=true:hinting=true"

------ Workspaces -------
wsDEV           = " ¹DEV "
wsSYS           = " ²SYS "
wsWEB           = " ³WWW "
wsDOC           = " ⁴DOC "
wsCHAT          = " ⁵CHT "
wsMUSIC         = " ⁶MSC "
wsVEDIO         = " ⁷VED "
wsCODE          = " ⁸OSS "
wsWORK          = " ⁹WRK "
myWorkspaces    = [wsDEV, wsSYS, wsWEB, wsDOC, wsCHAT, wsMUSIC, wsVEDIO, wsCODE, wsWORK]

------------------------------------------ AutoStart App --------------------------------------------------
myStartupHook = do
    spawnOnce "dunst"                                                             -- notfiction
    spawnOnce "unclutter"                                                         -- hidden Mouse
    spawnOnce "nitrogen --restore"                                                -- feh is the alternative "feh --bg-scale /directory/of/desired/background &"
    spawnOnce "urxvt -e xset r rate 150 55"                                       -- speeds cursor in urxvt
    spawnOnce "picom --experimental-backends"                                     -- Compositor
    setDefaultCursor xC_left_ptr                                                  -- Default Cursor

------------------------------------------ Layout --------------------------------------------------------
mySpacings       = spacingRaw False (Border 0 0 0 0) True (Border 5 5 5 5) True
myTopbar         = noFrillsDeco shrinkText myTopbarTheme
myTopbarTheme    = def
                 { fontName             = myFont
                 , activeColor          = black3
                 , activeBorderColor    = black3
                 , activeBorderWidth    = 20
                 , activeTextColor      = black3
                 , inactiveColor        = black0
                 , inactiveBorderColor  = black0
                 , inactiveBorderWidth  = 20
                 , inactiveTextColor    = black0
                 , urgentBorderColor    = red
                 , urgentBorderWidth    = 20
                 , urgentTextColor      = red
                 , decoWidth            = 20
                 , decoHeight           = 20
                 }

myShowWNameTheme = def
                { swn_font              = myBigFont
                , swn_fade              = 1.0
                , swn_bgcolor           = black0
                , swn_color             = black4
                }

myCenterWork    = renamed [Replace "Center"]
                $ noBorders
                $ myTopbar
                $ mySpacings
                $ ThreeColMid 1 (3/100) (1/2)

myOneBig        = renamed [Replace "OneBig"]
                $ noBorders
                $ myTopbar
                $ mySpacings
                $ OneBig (3/4) (3/4)

myLayoutHook    = mkToggle (NOBORDERS ?? FULL ?? EOT)
                $ avoidStruts ( myCenterWork ||| myOneBig )


--------------------------------------------------  keyBidings --------------------------------------------
myKeys =            -- Programme --
         [ ("M-w",          spawn "firefox"                         )
         , ("M-n",          spawn "nitrogen"                        )
         , ("M-c",          spawn "code-oss"                        )
         , ("M-s",          spawn "pavucontrol"                     )
         , ("M-r",          spawn "urxvt -e ranger"                 )
         , ("M-d",          spawn "rofi -show drun -Show-icons"     )
                    -- ScreenShoot --
         , ("<Print>",      spawn "scrot -F ~/pix/screen/%Y-%m-%d-%T-screenshot.png"   )   
         , ("S-<Print>",    spawn "scrot -s -F ~/pix/screen/%Y-%m-%d-%T-screenshot.png")                                                    
         , ("M-<Print>",    spawn "scrot -u -F ~/pix/screen/%Y-%m-%d-%T-screenshot.png")

                    -- Audio ---
         , ("<F8>",       spawn "pactl set-sink-volume @DEFAULT_SINK@ -10% && notify-send -t 200 `pulsemixer --get-volume | awk '{print $1}'`" ) 
         , ("<F9>",       spawn "pactl set-sink-volume @DEFAULT_SINK@ +10% && notify-send -t 200 `pulsemixer --get-volume | awk '{print $1}'`" )
         , ("<F10>",      spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle  && notify-send -t 200 'Toggle mute Mic button'"     ) 
         , ("M-C-m",      spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle && notify-send -t 500 'Toggle mute button!'"             ) 

                    -- Scripts --
         , ("M-S-w",       spawn "bash ~/scripts/rofi/wifiMenu.sh" )
         , ("M-0",         spawn "bash ~/scripts/rofi/powerMenu.sh")

                     --  XMonad --
         , ("M-S-a",        killAll                                 )
         , ("M-f",          sendMessage $ Toggle FULL               )
         , ("M-e",          viewEmptyWorkspace                      )
         , ("M-g",          tagToEmptyWorkspace                     )
         ]

--------------------------------------------------- ManageHook --------------------------------------------
myManageHook = composeAll
     [ className =? "mpv"               --> doCenterFloat
     , className =? "Sxiv"              --> doCenterFloat
     , className =? "Nitrogen"          --> doCenterFloat
     , className =? "Pavucontrol"       --> doCenterFloat
     , className =? "download"          --> doFloat
     , className =? "error"             --> doFloat
     , className =? "Gimp"              --> doFloat
     , className =? "notification"      --> doFloat
     ] 

-------------------------------------------------- Aplicy All   -------------------------------------------
main = do
    xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobarrc.hs"
    xmonad $ docks def { modMask                    = myModMask
                        , terminal                  = myTerminal
                        , borderWidth               = myBorderWidth
                        , focusedBorderColor        = myFocusedColor
                        , normalBorderColor         = myNormalColor
                        , workspaces                = myWorkspaces
                        , startupHook               = myStartupHook
                        , layoutHook                = showWName' myShowWNameTheme $ myLayoutHook
                        , manageHook                = myManageHook
                        , logHook                   = dynamicLogWithPP xmobarPP 
                                                    { ppOutput                  = hPutStrLn xmproc 
                                                    , ppCurrent                 = xmobarColor blue "" . wrap "<box type=Bottom width=3 mb=2 color=aqua>" "</box>"  
                                                    , ppHidden                  = xmobarColor blue1 "" . wrap "<box type=Top width=2 mt=2 color=aqua>" "</box>" 
                                                    , ppHiddenNoWindows         = xmobarColor blue1 ""           
                                                    , ppVisible                 = xmobarColor fg0  ""                 
                                                    , ppTitle                   = xmobarColor  blue1 "" . shorten 50          
                                                    , ppSep                     =  "<fc=aqua> <fn=2>\61762</fn> </fc>"                
                                                    , ppLayout                  = xmobarColor blue ""                          
                                                    , ppUrgent                  = xmobarColor fg0 "" . wrap "!" "!"                                                                 
                                                    } >>  updatePointer (0.5, 0.5) (0, 0) -- exact centre of window
                        } `additionalKeysP` myKeys
