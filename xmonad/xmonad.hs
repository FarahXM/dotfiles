-- ###################################################################
-- #                                                  /\ \          #
-- #       __  _   ___ ___     ___     ___      __     \_\ \        #
-- #      /\ \/'\/' __` __`\  / __`\ /' _ `\  /'__`\   /'_` \       #
-- #      \/>  <//\ \/\ \/\ \/\ \L\ \/\ \/\ \/\ \L\.\_/\ \L\ \      #
-- #      /\_/\_\ \_\ \_\ \_\ \____/\ \_\ \_\ \__/.\_\ \___,_\      #
-- #       \//\/_/\/_/\/_/\/_/\/___/  \/_/\/_/\/__/\/_/\/__,_ /     #
-- ##################################################################
-- ###################################
-- ############### base ##############
-- ###################################
import XMonad

-- ###################################
-- ########### Actions ###############
-- ###################################
import XMonad.Actions.UpdatePointer
import XMonad.Actions.FindEmptyWorkspace
import XMonad.Actions.WithAll (killAll)

-- ###################################
-- ############ Hooks ################
-- ###################################
import XMonad.ManageHook (doFloat)                                                              --for manageHook
import XMonad.Hooks.ManageHelpers (doCenterFloat, doFullFloat, isFullscreen)                    --for manageHook
import XMonad.Hooks.ManageDocks (avoidStruts, docks)                                            --for xmobar
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, xmobarPP, xmobarColor, wrap, shorten, PP(..)) --for xmobar

-- ###################################
-- ############# layout ##############
-- ###################################
import XMonad.Layout.ThreeColumns
import XMonad.Layout.OneBig

-- ###################################
-- ######## Layouts/Modifiers ########
-- ###################################
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances

-- ####################################
-- ############ Utilities #############
-- ####################################
import XMonad.Util.EZConfig (additionalKeysP)                                                   -- for keybidings
import XMonad.Util.Run (spawnPipe, hPutStrLn)                                                   -- for xmobar
import XMonad.Util.SpawnOnce (spawnOnce)                                                        -- autoStart App
import XMonad.Util.Cursor

-- #####################################################################
-- ############################# Color Pallatte ########################
-- #####################################################################
-- #################
-- #### [color] ####
-- #################
bg0     = "#282828"
bg0_h   = "#1d2021"
bg0_s   = "#32302f"
bg1     = "#3c3836"
bg2     = "#504945"
bg3     = "#665c54"
bg4     = "#7c6f64"
grey    = "#928374"

fg0     = "#fbf1c7"
fg2     = "#d5c4a1"
fg3     = "#bdae93"
fg4     = "#a89984"

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

-- #################################################################################
-- ############################## Variable XMonad ##################################
-- #################################################################################
myModMask       = mod1Mask                                                          -- Sets Mod Key to alt/Super/Win/Fn.
myTerminal      = "urxvt"                                                           -- Sets default Terminal Emulator.
myBorderWidth   = 2                                                                 -- Sets Border Width in pixels.
myNormalColor   = bg0_h                                                             -- Border color of normal windows.
myFocusedColor  = blue1                                                              -- Border color of focused windows.
myWorkspaces    = [" DEV ", " SYS ", " HTTP ", " CHAT ", " DOC ", " END "]
myFont          = "xft:JetBrains Mono:bold:size=50"

-- #################################################################################
-- ############################ AutoStart App ######################################
-- #################################################################################
myStartupHook = do
    spawnOnce "dunst"                                                             -- notfiction
    spawnOnce "unclutter"                                                         -- hidden Mouse
    spawnOnce "nitrogen --restore"                                                -- feh is the alternative "feh --bg-scale /directory/of/desired/background &"
    spawnOnce "urxvt -e xset r rate 150 55"                                       -- speeds cursor in urxvt
    spawnOnce "picom --experimental-backends"                                     -- Compositor
    setDefaultCursor xC_left_ptr                                                  -- Default Cursor

-- #################################################################################
-- #################################### Layout #####################################
-- #################################################################################
mySpacings       = spacingRaw False (Border 0 0 0 0) True (Border 5 5 5 5) True
myShowWNameTheme = def
                { swn_font              = myFont
                , swn_fade              = 1.0
                , swn_bgcolor           = bg0_h
                , swn_color             = aqua
                }
myCenterWork    = renamed [Replace "CenterWork"]
                $ mySpacings
                $ ThreeColMid 1 (3/100) (1/2)

myOneBig        = renamed [Replace "OneBig"]
                $ mySpacings
                $ OneBig (3/4) (3/4)

myLayoutHook    = mkToggle (NOBORDERS ?? FULL ?? EOT)
                $ avoidStruts ( myCenterWork ||| myOneBig )


-- #####################################################################################
-- #################################### keyBidings #####################################
-- #####################################################################################
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
         , ("M-<Print>",    spawn "scrot -u -F ~/pix/screen/%Y-%m-%d-%T-screenshot.png")
                     -- import XMonad --
         , ("M-S-a",        killAll                                 )
         , ("M-f",          sendMessage $ Toggle FULL               )
         , ("M-e",          viewEmptyWorkspace                      )
         , ("M-g",          tagToEmptyWorkspace                     )
                    -- myScripts --
         , ("M-S-w",       spawn "bash ~/scripts/rofi/wifiMenu.sh" )
         , ("M-0",         spawn "bash ~/scripts/rofi/powerMenu.sh")
         ]

-- ####################################################################################
-- ######################################### ManageHook ###############################
-- ####################################################################################
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

-- #######################################################################################
-- ###################################### Aplicy All #####################################
-- #######################################################################################
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
                                                    { ppOutput = hPutStrLn xmproc 
                                                    , ppCurrent = xmobarColor blue "" . wrap "<box type=Bottom width=3 mb=2 color=aqua>" "</box>"  
                                                    , ppHidden = xmobarColor blue1 "" . wrap "<box type=Top width=2 mt=2 color=aqua>" "</box>" 
                                                    , ppHiddenNoWindows = xmobarColor blue1 ""           
                                                    , ppVisible = xmobarColor fg0  ""                 
                                                    , ppTitle = xmobarColor  blue1 "" . shorten 50          
                                                    , ppSep =  "<fc=aqua> <fn=2>\61762</fn> </fc>"                
                                                    , ppLayout = xmobarColor blue ""                          
                                                    , ppUrgent = xmobarColor fg0 "" . wrap "!" "!"                                                                 
                                                    } >>  updatePointer (0.5, 0.5) (0, 0) -- exact centre of window
                        } `additionalKeysP` myKeys
