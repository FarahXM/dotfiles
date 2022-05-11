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
import XMonad.Actions.Minimize

--------- Hooks ----------
import XMonad.ManageHook (doFloat)                                                              --for manageHook
import XMonad.Hooks.ManageHelpers (doCenterFloat, doFullFloat, isFullscreen)                    --for manageHook
import XMonad.Hooks.ManageDocks (avoidStruts, docks)                                            --for xmobar
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, xmobarPP, xmobarColor, wrap, shorten, PP(..)) --for xmobar

--------- layout ---------
import XMonad.Layout.ThreeColumns
import XMonad.Layout.OneBig
import XMonad.Layout.Mosaic
import XMonad.Layout.Master
import XMonad.Layout.Tabbed
import XMonad.Layout.TwoPane
import XMonad.Layout.Simplest
import XMonad.Layout.SimplestFloat
import XMonad.Layout.ResizableTile
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Accordion
import XMonad.Layout.Circle
import XMonad.Layout.Dishes
import XMonad.Layout.Roledex
import XMonad.Layout.TwoPanePersistent
import XMonad.Layout.Grid
import XMonad.Layout.Spiral
import XMonad.Layout.Fullscreen

----- Layouts/Modifiers ----
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Maximize
import XMonad.Layout.Minimize
import XMonad.Layout.MagicFocus
import XMonad.Layout.ComboP
import XMonad.Layout.Reflect
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.LimitWindows
import XMonad.Layout.Gaps
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
----- [ Gruvbox ] -----
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
myBigFont       = "xft:Source Code Pro:Bold:size=50"
myWideFont      = "xft:DejaVu Sans Mono:Bold:size=90:antialias=true:hinting=true"

------ Workspaces -------
wsDEV           = " ¹DEV "
wsGIT           = " ²GIT "
wsWEB           = " ³WEB "
wsYTB           = " ⁴YTB "
wsCHT           = " ⁵CHT "
wsMSC           = " ⁶MSC "
wsVED           = " ⁷VED "
wsGME           = " ⁸GME "
wsSIT           = " ⁹SIT "
myWorkspaces    = [wsDEV,wsGIT,wsWEB,wsYTB,wsCHT,wsMSC,wsVED,wsGME,wsSIT]

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
myGaps           = gaps [(U, 10),(D, 10),(L, 10),(R, 10)]
myTopBar         = noFrillsDeco shrinkText myTopBarTheme
myTopBarTheme    = def
                 { fontName             = myFont
                 , activeColor          = black3
                 , activeBorderColor    = black3
                 , activeTextColor      = black3
                 , inactiveColor        = black0
                 , inactiveBorderColor  = black0
                 , inactiveTextColor    = black0
                 , urgentBorderColor    = red
                 , urgentTextColor      = red
                 , inactiveBorderWidth  = 15
                 , activeBorderWidth    = 15
                 , urgentBorderWidth    = 15
                 , decoWidth            = 15
                 , decoHeight           = 15
                 }

myShowWNameTheme = def
                { swn_font              = myWideFont
                , swn_fade              = 1.0
                , swn_bgcolor           = black0
                , swn_color             = black4
                }

-------------------- Base Layout ---------------------------
myTabTheme      = def
                { fontName              = myFont
                , activeColor           = black3
                , inactiveColor         = black0
                , activeBorderColor     = black3
                , inactiveBorderColor   = black0
                , activeTextColor       = green
                , inactiveTextColor     = green1
                }

tab             = renamed [Replace "TABBED"]
                $ maximizeWithPadding 16
                $ minimize
                $ myTopBar
                $ myGaps
                $ tabbed shrinkText myTabTheme

masterTabbed    = renamed [Replace "MTABBED" ]
                $ maximizeWithPadding 16
                $ minimize
                $ myTopBar
                $ mySpacings
                $ mastered (1/100) (1/2) 
                $ tabbed shrinkText myTabTheme

threeCol        = renamed [Replace "THREECOL"]
                $ maximizeWithPadding 16
                $ minimize
                $ mySpacings
                $ ThreeCol 1 (3/100) (1/2)

threeColMid     = renamed [Replace "THREECOLMID"]
                $ maximizeWithPadding 16
                $ minimize
                $ myTopBar
                $ mySpacings
                $ ThreeColMid 1 (3/100) (1/2)

oneBig          = renamed [Replace "ONEBIG"]
                $ maximizeWithPadding 16
                $ minimize
                $ myTopBar
                $ mySpacings
                $ OneBig (3/4) (3/4)

bsp             = renamed [Replace "BSP"]
                $ maximizeWithPadding 16
                $ minimize
                $ myTopBar
                $ mySpacings
                $ emptyBSP 

mosic           =  renamed [Replace "MOSIC"]
                $ maximizeWithPadding 16
                $ minimize
                $ myTopBar
                $ myGaps
                $ mySpacings
                $ mosaic 2 [3,2]


simpleFloat     =  renamed [Replace "SFLOAT"]       
                $ maximizeWithPadding 16
                $ minimize
                $ myGaps
                $ mySpacings
                $ simplestFloat

refTall         = renamed [Replace "REFTALL"]
                $ maximizeWithPadding 16
                $ minimize
                $ myTopBar
	            $ mySpacings
                $ myGaps
                $ reflectHoriz
                $ Tall 1 0.03 (2/3)

tiled           = renamed [Replace "TILED"]
                $ maximizeWithPadding 16
                $ minimize
                $ myTopBar
                $ mySpacings
                $ myGaps
                $ ResizableTall 1 (3/100) (1/2) []

accordion       = renamed [Replace "ACCORDION"]
                $ maximizeWithPadding 16
                $ minimize
                $ mySpacings
                $ Accordion

circle          = renamed [Replace "CIRCLE"]
                $ maximizeWithPadding 16
                $ minimize
                $ mySpacings
                $ myGaps
                $ Circle

dishes          = renamed [Replace "DISHES"]
                $ maximizeWithPadding 16
                $ minimize
                $ mySpacings
                $ Dishes 2 (1/5)

twoPane         = renamed [Replace "TWOPANE"]
                $ maximizeWithPadding 16
                $ minimize
                $ mySpacings
                $ TwoPanePersistent Nothing (3/100) (1/2)

roledex         = renamed [Replace "ROLEDEX"]
                $ maximizeWithPadding 16
                $ minimize
                $ magicFocus
                $ mySpacings
                $ Roledex

grid            = renamed [Replace "GRID"]
                $ maximizeWithPadding 16
                $ minimize
                $ mySpacings
                $ GridRatio (4/3) 

full            = renamed [Replace "FULL"]
                $ maximizeWithPadding 16
                $ minimize
                $ mySpacings
                $ limitWindows 20 Full
----------------------------------------------------------
------------------ Compine Layout ------------------------
twoRefTab        = renamed [Replace "TwoRefTab"]
                 $ combineTwoP (TwoPane 0.03 (3/4))
                            (refTall)
                            (tab)
                            (ClassName "firefox")

twoSimAcc       = renamed [ Replace "TwoSimAcc"]
                $ maximizeWithPadding 16
                $ mySpacings
                $ myGaps
                $ combineTwoP (TwoPane 0.03 0.5)
                            (Simplest)
                            (Accordion)
                            (ClassName "firefox")

threSimTall     = renamed [Replace "ThreSimTall"]
                $ maximizeWithPadding 16
                $ myGaps
                $ mySpacings
                $ combineTwoP (ThreeCol 1 (3/100) (1/2))
                            (Simplest)
                            (Tall 1 0.03 0.5)
                            (ClassName "firefox")

-----------------------------------------------------------------
---------------------------- Usage ------------------------------
codeLayouts     = mosic ||| tiled ||| threeColMid ||| oneBig ||| twoPane
chatLayouts     = grid ||| threeColMid ||| tiled
youtubeLayouts  = twoRefTab ||| twoSimAcc ||| threSimTall ||| masterTabbed ||| Full
settingsLayouts = circle ||| grid ||| bsp ||| simpleFloat
allLayout       = tab 
                ||| masterTabbed 
                ||| threeColMid 
                ||| oneBig 
                ||| bsp 
                ||| mosic 
                ||| simpleFloat 
                ||| refTall 
                ||| tiled 
                ||| accordion 
                ||| circle 
                ||| dishes 
                ||| twoPane 
                ||| roledex 
                ||| grid
                ||| accordion
                ||| circle
                ||| dishes
                ||| twoPane
                ||| roledex
                ||| grid
                ||| twoRefTab 
                ||| twoSimAcc 
                ||| threSimTall 
                ||| full
--------------------------------------------------------------------
myLayoutHook    = showWName' myShowWNameTheme
                $ mkToggle (NOBORDERS ?? FULL ?? EOT)
                $ noBorders
                $ limitWindows 12
                $ avoidStruts
                $ onWorkspace (myWorkspaces !! 0) codeLayouts
                $ onWorkspace (myWorkspaces !! 1) chatLayouts
                $ onWorkspace (myWorkspaces !! 2) youtubeLayouts
                $ onWorkspace (myWorkspaces !! 5) settingsLayouts
                $ allLayout

--------------------------------------------------  keyBidings --------------------------------------------
myKeys =            -- Programme --
         [ ("M-w",          spawn "firefox"                         )
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
         , ("C-w",          spawn "bash ~/scripts/rofi/wifiMenu.sh" )
         , ("C-0",          spawn "bash ~/scripts/rofi/powerMenu.sh")

                     --  XMonad --
         , ("M-S-a",        killAll                                 ) {-- Quite All --}
         , ("M-f",          sendMessage $ Toggle FULL               ) {--Full Screen --}
         , ("M-e",          viewEmptyWorkspace                      ) {-- Find Empty Workspaces --}
         , ("M-g",          tagToEmptyWorkspace                     ) {-- Go To workspaces --}
         , ("M-x",          withFocused (sendMessage . maximizeRestore)) {----For Maximaze With Paddings --}
         , ("M-n",          withFocused minimizeWindow                 ) {-- For Minimize && Action minimize --}
         , ("M-S-n",        withLastMinimized maximizeWindowAndFocus   ) {-- For Minimize && Action minimize --}
         , ("M-S-t",        sendMessage Taller) {-- For Layout Mosaic -}
         , ("M-S-w",        sendMessage Wider)  {-- For Layout Mosaic -}
         , ("M-S-r",        sendMessage Reset)  {-- For Layout Mosaic -}
         , ("M-C-j",        sendMessage MirrorShrink) {-- For Layout ResizableTile( Tiled ) -}
         , ("M-C-k",        sendMessage MirrorExpand) {-- For Layout ResizableTile( Tiled ) -}
         , ("M-s",          sendMessage $ SwapWindow) {-- For Compine Layout (ComboP) --}
         ]

--------------------------------------------------- ManageHook --------------------------------------------
myManageHook = composeAll
     [ className =? "mpv"               --> doCenterFloat
     , className =? "Sxiv"              --> doCenterFloat
     , className =? "Nitrogen"          --> doCenterFloat
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
                        , layoutHook                = myLayoutHook
                        , manageHook                = myManageHook
                        , logHook                   = dynamicLogWithPP xmobarPP 
                                                    { ppOutput                  = hPutStrLn xmproc 
                                                    , ppCurrent                 = xmobarColor blue "" . wrap "<box type=Bottom width=3 mb=2 color=aqua>" "</box>"  
                                                    , ppHidden                  = xmobarColor blue1 "" . wrap "<box type=Top width=2 mt=2 color=aqua>" "</box>" 
                                                    , ppHiddenNoWindows         = xmobarColor blue1 ""           
                                                    , ppVisible                 = xmobarColor fg0  ""                 
                                                    , ppTitle                   = xmobarColor  blue1 "" . shorten 40          
                                                    , ppSep                     =  "<fc=aqua> <fn=2>\61762</fn> </fc>"                
                                                    , ppLayout                  = xmobarColor blue ""                          
                                                    , ppUrgent                  = xmobarColor fg0 "" . wrap "!" "!"                                                                 
                                                    } >>  updatePointer (0.5, 0.5) (0, 0) -- exact centre of window
                        } `additionalKeysP` myKeys
