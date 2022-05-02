-- ##################################################################
-- #                                                  /\ \          #
-- #       __  _   ___ ___     ___     ___      __     \_\ \        # 
-- #      /\ \/'\/' __` __`\  / __`\ /' _ `\  /'__`\   /'_` \       # 
-- #      \/>  <//\ \/\ \/\ \/\ \L\ \/\ \/\ \/\ \L\.\_/\ \L\ \      #
-- #      /\_/\_\ \_\ \_\ \_\ \____/\ \_\ \_\ \__/.\_\ \___,_\      #
-- #       \//\/_/\/_/\/_/\/_/\/___/  \/_/\/_/\/__/\/_/\/__,_ /     #
-- ##################################################################
-- base
import XMonad

-- Actions.
import XMonad.Actions.UpdatePointer
import XMonad.Actions.FindEmptyWorkspace
import XMonad.Actions.WithAll (killAll)

-- Hooks.
import XMonad.ManageHook (doFloat)                                                              --for manageHook
import XMonad.Hooks.ManageHelpers (doCenterFloat, doFullFloat, isFullscreen)                    --for manageHook
import XMonad.Hooks.ManageDocks (avoidStruts, docks)                                            --for xmobar
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, xmobarPP, xmobarColor, wrap, shorten, PP(..)) --for xmobar

--layout
import XMonad.Layout.Spiral
import XMonad.Layout.OneBig
import XMonad.Layout.Grid
import XMonad.Layout.CenteredMaster

-- Layouts/Modifiers.
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances

-- Utilities.
import XMonad.Util.EZConfig (additionalKeysP)   --for keybidings
import XMonad.Util.Run (spawnPipe, hPutStrLn)   --for xmobar
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Util.Cursor

-- #############################################################
-- ##################### Color Pallatte ########################
-- #############################################################
--[color]

fg      = "#fbf1c7"
fg0     = "#f9f5d7"
fg1     = "#ebdbb2"
fg2     = "#d5c4a1"
fg3     = "#bdae93"
fg4     = "#a89984"
fg5     = "#f2e5bc"
fg6     = "#fdffb6"
fg7     = "#d5c4a1"

black   = "#1d2021"
bg      = "#282828"
bg0     = "#3c3836"
bg1     = "#504945"
bg2     = "#665c54"
bg3     = "#7c6f64"

red     = "#cc241d"
green   = "#98971a"
yellow  = "#d79921"
blue    = "#458588"
purple  = "#b16286"
aqua    = "#689d6a"
orange  = "#d65d0e"
grey    = "#7c6f64"

red1    = "#9d0006"
green1  = "#79740e"
yellow1 = "#b57614"
blue1   = "#076678"
purple1 = "#8f3f71"
aqua1   = "#427b58"
orange1 = "#af3a03"

-- #############################################################################
-- ########################## Variable XMonad ##################################
-- #############################################################################
myFont          = "xft:JetBrains Mono:size=50"                       -- Font 
myModMask       = mod1Mask                                           -- Sets Mod Key to alt/Super/Win/Fn.
myTerminal      = "urxvt"                                            -- Sets default Terminal Emulator.
myBorderWidth   = 3                                                  -- Sets Border Width in pixels.
myNormalColor   = fg7                                                -- Border color of normal windows.
myFocusedColor  = bg                                                 -- Border color of focused windows.
myWorkspaces    = [" DEV ", " SYS ", " HTTP ", " CHAT ", " DOC ", " END "]

-- ##############################################################################
-- ######################### AutoStart App ######################################
-- ##############################################################################
myStartupHook = do
    spawnOnce "nitrogen --restore &"                            -- feh is the alternative "feh --bg-scale /directory/of/desired/background &"
    spawnOnce "picom"                                           -- Compositor
    spawnOnce "dunst &"                                         -- notfiction
    spawnOnce "urxvt -e xset r rate 400 44"                     -- Speeds Cursor
    setDefaultCursor xC_left_ptr                                -- Default Cursor

-- ############################################################################
-- ############################### Layout #####################################
-- ############################################################################
addTopBar =  noFrillsDeco shrinkText myTopBarTheme

myTopBarTheme   = def 
                { fontName              = myFont 
                , activeBorderColor     = bg
                , activeColor           = bg
                , activeTextColor       = bg
                , inactiveBorderColor   = fg7
                , inactiveColor         = fg7
                , inactiveTextColor     = fg7
                , urgentBorderColor     = fg7
                , urgentTextColor       = yellow
                , decoHeight            = 25
                }

myNameWS        = def
                { swn_font              = myFont
                , swn_fade              = 1.0
                , swn_bgcolor           = fg
                , swn_color             = red
                }

myGaps          = spacingRaw False (Border 10 10 10 10) True (Border 20 20 20 20) True

mySperial       = renamed [Replace "Sperial"]
                $ addTopBar
                $ myGaps
                $ spiral (6/7)

myOneBig        = renamed [Replace "OneBig"]
                $ addTopBar
                $ myGaps
                $ OneBig (3/4) (3/4)

myCenter        = renamed [Replace "Center"]
                $ addTopBar
                $ myGaps
                $ centerMaster Grid

myLayoutHook    = mkToggle (NOBORDERS ?? FULL ?? EOT)
                $ avoidStruts ( mySperial ||| myCenter ||| myOneBig )

-- ########################################################################
-- ####################### keyBidings #####################################
-- ########################################################################
myKeys =            -- Lanuche Programme --
        [ ("M-w",          spawn "firefox"                         )
        , ("M-n",          spawn "nitrogen"                        )
        , ("M-c",          spawn "code-oss"                        )
        , ("M-s",          spawn "pavucontrol"                     )
        , ("M-r",          spawn "urxvt -e ranger"                 )
        , ("M-d",          spawn "rofi -show drun -Show-icons"     )
                    -- ScreenShoot --
        , ("<Print>",      spawn "scrot -F ~/pix/screen/%Y-%m-%d-%T-screenshot.png"   )   
        , ("S-<Print>",    spawn "scrot -s -F ~/pix/screen/%Y-%m-%d-%T-screenshot.png")                                                    
        , ("M-<Print>",    spawn "scrot -u -F ~/pix/screen/%Y-%m-%d-%T-screenshot.png"          )
                     -- import XMonad --
        , ("M-S-a",        killAll                                 )
        , ("M-f",          sendMessage $ Toggle FULL               )
        , ("M-e",          viewEmptyWorkspace                      )
        , ("M-g",          tagToEmptyWorkspace                     )
                    -- myScripts --
        , ("M-S-w",       spawn "bash ~/scripts/rofi/wifiMenu.sh" )
        , ("M-0",         spawn "bash ~/scripts/rofi/powerMenu.sh")
        ]

-- ######################################################################
-- ########################### ManageHook ###############################
-- ######################################################################
myManageHook = composeAll
     [ className =? "mpv"               --> doCenterFloat
     , className =? "Nitrogen"          --> doCenterFloat
     , className =? "Sxiv"              --> doCenterFloat
     , className =? "Pavucontrol"       --> doCenterFloat
     , className =? "download"          --> doFloat
     , className =? "error"             --> doFloat
     , className =? "Gimp"              --> doFloat
     , className =? "notification"      --> doFloat
     ] 

-- #######################################################################
-- ########################### Applicky All ##############################
-- #######################################################################
main = do
    xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobarrc.hs"
    xmonad $ docks def { modMask                    = myModMask
                        , terminal                  = myTerminal
                        , borderWidth               = myBorderWidth
                        , focusedBorderColor        = myFocusedColor
                        , normalBorderColor         = myNormalColor
                        , workspaces                = myWorkspaces
                        , startupHook               = myStartupHook
                        , layoutHook                = showWName' myNameWS $ myLayoutHook
                        , manageHook                = myManageHook
                        , logHook                   = dynamicLogWithPP xmobarPP 
                                                    { ppOutput = hPutStrLn xmproc 
                                                    , ppCurrent = xmobarColor orange "" . wrap "<box type=Bottom width=3 mb=3 color=red>" "</box>"  
                                                    , ppHidden = xmobarColor red "" . wrap "<box type=Top width=2 mt=2 color=red>" "</box>" 
                                                    , ppHiddenNoWindows = xmobarColor orange ""           
                                                    , ppVisible = xmobarColor fg ""                 
                                                    , ppTitle = xmobarColor  orange "" . shorten 65          
                                                    , ppSep =  "<fc=orange1> <fn=2>\61545</fn> </fc>"                
                                                    , ppLayout = xmobarColor red ""                          
                                                    , ppUrgent = xmobarColor fg "" . wrap "!" "!"                                                                 
                                                    } >>  updatePointer (0.5, 0.5) (0, 0) -- exact centre of window
                        } `additionalKeysP` myKeys
