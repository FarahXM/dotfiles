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
import qualified XMonad.StackSet as W

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

-------- Utilities --------
import XMonad.Util.EZConfig (additionalKeysP)                                                   -- for keybidings
import XMonad.Util.Run (spawnPipe, hPutStrLn)                                                   -- for xmobar
import XMonad.Util.SpawnOnce (spawnOnce)                                                        -- autoStart App
import XMonad.Util.Cursor

----- Layouts/Modifiers ----
-- import XMonad.Layout.NoFrillsDecoration                                                      -- Title in WS
import XMonad.Layout.PerWorkspace                                                                -- chouge Layout for WS
import XMonad.Layout.Maximize
import XMonad.Layout.Minimize
import XMonad.Layout.ComboP
import XMonad.Layout.LimitWindows
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances

--------- layout ---------
import XMonad.Layout.ResizableTile
import XMonad.Layout.ThreeColumns
import XMonad.Layout.OneBig
import XMonad.Layout.Mosaic
import XMonad.Layout.Tabbed
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Accordion
import XMonad.Layout.TwoPanePersistent

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
myFocusedColor  = red                                                               -- Border color of focused windows.
myFont          = "xft:JetBrains Mono:Regular:size=10"
myBigFont       = "xft:Source Code Pro:Bold:size=50"
myWideFont      = "xft:DejaVu Sans Mono:Bold:size=90:antialias=true:hinting=true"
windowCount     = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset  -- Number Of Window in XMobar


------ Workspaces -------
wsDEV           = "¹DEV "
wsGIT           = "²GIT "
wsWEB           = "³WEB "
wsYTB           = "⁴YTB "
wsCHT           = "⁵CHT "
wsMSC           = "⁶MSC "
wsVED           = "⁷VED "
wsSIT           = "⁸SIT "
wsGME           = "⁹GME "
myWorkspaces    = [wsDEV,wsGIT,wsWEB,wsYTB,wsCHT,wsMSC,wsVED,wsSIT]

------------------------------------------ AutoStart App --------------------------------------------------
myStartupHook = do
    spawnOnce "dunst"                                                             -- notfiction
    spawnOnce "unclutter"                                                         -- hidden Mouse
    spawnOnce "nitrogen --restore"                                                -- feh is the alternative "feh --bg-scale /directory/of/desired/background &"
    spawnOnce "xset r rate 150 55"                                       -- speeds cursor in urxvt
    spawnOnce "picom --experimental-backends"                                     -- Compositor
    setDefaultCursor xC_left_ptr                                                  -- Default Cursor

------------------------------------------ Layout --------------------------------------------------------
mySpacings       = spacingRaw False (Border 10 10 10 10) True (Border 10 10 10 10) True
myGaps           = gaps [(U, 20),(D, 10),(L, 20),(R, 20)]
-- myTitle          = noFrillsDeco shrinkText myTitleTheme
-- myTitleTheme     = def
--                  { fontName             = myFont
--                  , activeColor          = red
--                  , activeTextColor      = red
--                  , inactiveColor        = bg0
--                  , inactiveBorderColor  = bg0
--                  , inactiveTextColor    = bg0
--                  , urgentBorderColor    = red
--                  , urgentTextColor      = red
--                  , inactiveBorderWidth  = 10
--                  , activeBorderWidth    = 10
--                  , urgentBorderWidth    = 10
--                  , decoWidth            = 10
--                  , decoHeight           = 10
--                  }

myShowWNameTheme = def
                { swn_font              = myWideFont
                , swn_fade              = 1.0
                , swn_bgcolor           = bg0
                , swn_color             = red
                }

-------------------- Base Layout ------------------------
myTabTheme      = def
                { fontName              = myFont
                , activeColor           = red
                , inactiveColor         = bg0
                , activeBorderColor     = red1
                , inactiveBorderColor   = bg1
                , activeTextColor       = bg0
                , inactiveTextColor     = fg0
                }

tab             = renamed [Replace "TABBED"] 	  
                $ noBorders
                $ maximizeWithPadding 16 
                $ minimize 
                $ myGaps 
                $ tabbed shrinkText myTabTheme

threeColMid     = renamed [Replace "THREECOLMID"] 
                -- $ myTitle 
                $ maximizeWithPadding 16 
                $ minimize 
                $ mySpacings 
                $ ThreeColMid 1 (3/100) (1/2)

oneBig          = renamed [Replace "ONEBIG"] 	  
                -- $ myTitle 
                $ maximizeWithPadding 16 
                $ minimize 
                $ mySpacings 
                $ OneBig (3/4) (3/4)

tiled           = renamed [Replace "TILD"]  
                -- $ myTitle 
                $ maximizeWithPadding 16 
                $ minimize 
                $ mySpacings 
                $ ResizableTall 1 (3/100) (1/2) []

mosic           =  renamed [Replace "MOSIAC"]      
                -- $ myTitle 
                $ maximizeWithPadding 16 
                $ minimize 
                $ mySpacings 
                $ mosaic 2 [3,2]

accordion       = renamed [Replace "ACCORDN"]   
                -- $ myTitle 
                $ maximizeWithPadding 16 
                $ minimize 
                $ Accordion

simpleFloat     =  renamed [Replace "FLOAT"]    
                $ maximizeWithPadding 16 
                $ minimize 
                $ myGaps 
                $ mySpacings 
                $ simplestFloat

full            = renamed [Replace "FULL"]       
                $ maximizeWithPadding 16 
                $ minimize 
                $ mySpacings 
                $ limitWindows 20 Full

---------------------------- Usage ------------------------------
codeLayouts     = tiled ||| mosic ||| oneBig ||| threeColMid ||| tab
allLayout       = tab ||| threeColMid ||| oneBig ||| tiled ||| mosic ||| accordion ||| simpleFloat ||| full
myLayoutHook    = showWName' myShowWNameTheme
                $ mkToggle (NOBORDERS ?? FULL ?? EOT)
                $ limitWindows 12
                $ avoidStruts
                $ onWorkspace (myWorkspaces !! 0) codeLayouts
                $ allLayout

--------------------------------------------------  keyBidings --------------------------------------------
myKeys =            -- Programme --
         [ ("M-w",          spawn "firefox"                         )
         , ("M-d",          spawn "rofi -show drun -Show-icons"     )
         , ("M-S-d",        spawn "dmenu_run -fn 'JetBrains Mono:style=Bold:pixelsize=12' -nb '#282828' -nf '#fb4934' -sb '#fb4934' -sf '#282828' -p 'CMD:'")
                    -- ScreenShoot --
         , ("<Print>",      spawn "scrot -F ~/pix/screen/%Y-%m-%d-%T-screenshot.png && notify-send -t 800 'ScreenShot Takeen' 'Saved in ~/pix/screen/'"   )
         , ("S-<Print>",    spawn "scrot -s -F ~/pix/screen/%Y-%m-%d-%T-screenshot.png && notify-send -t 800 'ScreenShot Takeen' 'Saved in ~/pix/screen/'")
         , ("M-<Print>",    spawn "scrot -u -F ~/pix/screen/%Y-%m-%d-%T-screenshot.png && notify-send -t 800 'ScreenShot Takeen' 'Saved in ~/pix/screen/'")

                    -- Audio ---
         , ("<F8>",         spawn "pactl set-sink-volume @DEFAULT_SINK@ -10% && notify-send -t 200 `pulsemixer --get-volume | awk '{print $1}'`" )
         , ("<F9>",         spawn "pactl set-sink-volume @DEFAULT_SINK@ +10% && notify-send -t 200 `pulsemixer --get-volume | awk '{print $1}'`" )
         , ("<F10>",        spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle  && notify-send -t 200 'Toggle mute Mic button'"     )
         , ("M-C-m",        spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle && notify-send -t 200 'Toggle mute button!'"             )

                    -- Brightenss --
        , ("<F4>",          spawn "xbacklight -set 50 && notify-send -t 200 `xbacklight -get`")
        , ("<F5>",          spawn "xbacklight -dec 10 && notify-send -t 200 `xbacklight -get`")
        , ("<F6>",          spawn "xbacklight -inc 10 && notify-send -t 200 `xbacklight -get`")
        , ("<F7>",          spawn "xbacklight -set 100 && notify-send -t 200 `xbacklight -get`")

                    -- Scripts --
         , ("C-w",          spawn "~/scripts/rofi/wifiMenu.sh" )
         , ("C-0",          spawn "~/scripts/rofi/powerMenu.sh")

                     --  XMonad --
         , ("M-<Backspace>",        killAll                                 ) {-- Quite All --}
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
    xmonad $ docks def {  modMask                   = myModMask
                        , terminal                  = myTerminal
                        , borderWidth               = myBorderWidth
                        , focusedBorderColor        = myFocusedColor
                        , normalBorderColor         = myNormalColor
                        , workspaces                = myWorkspaces
                        , startupHook               = myStartupHook
                        , layoutHook                = myLayoutHook
                        , manageHook                = myManageHook
                        , logHook                   = dynamicLogWithPP xmobarPP
                          -- XMOBAR SETTINGS
                                    { ppOutput = hPutStrLn xmproc   -- xmobar 
                                    -- Current workspace
                                    , ppCurrent = xmobarColor red "" . wrap
                                                ("<box type=Bottom width=2 mb=2 color=" ++ red ++ ">") "</box>"
                                    -- Visible but not current workspace
                                    , ppVisible = xmobarColor green "" 
                                    -- Hidden workspace
                                    , ppHidden = xmobarColor red1 "" . wrap
                                               ("<box type=Top width=2 mt=2 color=" ++ red1 ++ ">") "</box>" 
                                    -- Hidden workspaces (no windows)
                                    , ppHiddenNoWindows = xmobarColor orange1 "" 
                                    -- Title of active window
                                    , ppTitle = xmobarColor orange1 "" . shorten 40
                                    -- Separator character
                                    , ppSep =  "<fc=" ++ orange ++ "> <fn=1>|</fn> </fc>"
                                    -- Urgent workspace
                                    , ppUrgent = xmobarColor orange "" . wrap "!" "!"
                                    -- Adding # of windows on current workspace to the bar
                                    , ppExtras  = [windowCount]
                                    --  Type Of layout in xmobar
                                    ,ppLayout   = xmobarColor red ""
                                    -- order of things in xmobar
                                    , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                                    } >>  updatePointer (0.5, 0.5) (0, 0) -- exact centre of window
                        } `additionalKeysP` myKeys
