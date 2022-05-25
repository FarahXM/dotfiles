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
import XMonad.Actions.WithAll (killAll, sinkAll)
import XMonad.Actions.Minimize

--------- Hooks ----------
import XMonad.ManageHook (doFloat)                                                              --for manageHook
import XMonad.Hooks.ManageHelpers (doCenterFloat, doFullFloat, isFullscreen)                    --for manageHook
import XMonad.Hooks.ManageDocks (avoidStruts, docks)                                            --for xmobar
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, xmobarPP, xmobarColor, wrap, shorten, PP(..)) --for xmobar

-------- Utilities --------
import XMonad.Util.NamedScratchpad
import XMonad.Util.EZConfig (additionalKeysP)                                                   -- for keybidings
import XMonad.Util.Run (spawnPipe, hPutStrLn)                                                   -- for xmobar
import XMonad.Util.SpawnOnce (spawnOnce)                                                        -- autoStart App
import XMonad.Util.Cursor                                                                       -- Normal Cursor

----- Layouts/Modifiers ----
import XMonad.Layout.PerWorkspace                                                               
import XMonad.Layout.Maximize
import XMonad.Layout.Minimize
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
import XMonad.Layout.Tabbed
import XMonad.Layout.SimplestFloat

------------------------------------------- Color Pallatte ------------------------------------------------
--- One Pallate ---
bg          = "#11121D"
fg          = "#a9b1d6"
black       = "#32344a"
red         = "#f7768e"
green       = "#9ece6a"
yellow      = "#e0af68"
blue        = "#7aa2f7"
magenta     = "#ad8ee6"
cyan        = "#449dab"
white       = "#787c99"


--- Two Pallate ---
black_       = "#444b6a"
red_         = "#ff7a93"
green_       = "#b9f27c"
yellow_      = "#ff9e64"
blue_        = "#7da6ff"
magenta_     = "#bb9af7"
cyan_        = "#0db9d7"
white_       = "#acb0d0"

--------------------------------------------- Variable XMonad --------------------------------------------
myModMask       = mod1Mask                                                          -- Sets Mod Key to alt/Super/Win/Fn.
myTerminal      = "alacritty"                                                       -- Sets default Terminal Emulator.
myBorderWidth   = 1                                                                 -- Sets Border Width in pixels.
myNormalColor   = bg                                                                -- Border color of normal windows.
myFocusedColor  = blue                                                              -- Border color of focused windows.
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
-- myWorkspaces    = [wsDEV,wsGIT,wsWEB,wsYTB,wsCHT,wsMSC,wsVED,wsSIT]
myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "] 

------------------------------------------ AutoStart App --------------------------------------------------
myStartupHook = do
    spawnOnce "dunst"                                                               -- notfiction
    spawnOnce "unclutter"                                                           -- hidden Mouse
    spawnOnce "nitrogen --restore"                                                  -- feh is the alternative "feh --bg-scale /directory/of/desired/background &"
    spawnOnce "xset r rate 200 60"                                                  -- speeds cursor in urxvt
    spawnOnce "picom --experimental-backends"                                       -- Compositor
    setDefaultCursor xC_left_ptr                                                    -- Default Cursor

------------------------------------------ Layout --------------------------------------------------------
mySpacings       = spacingRaw False (Border 0 0 0 0) True (Border 5 5 5 5) True
myGaps           = gaps [(U, 10),(D, 5),(L, 10),(R, 10)]
myShowWNameTheme = def
                { swn_font              = myWideFont
                , swn_fade              = 1.0
                , swn_bgcolor           = bg
                , swn_color             = blue
                }

-------------------- Base Layout ------------------------
myTabTheme      = def
                { fontName              = myFont
                , activeColor           = blue
                , inactiveColor         = bg
                , activeBorderColor     = blue
                , inactiveBorderColor   = bg
                , activeTextColor       = bg
                , inactiveTextColor     = fg
                }

tab             = renamed [Replace "TABBED"]      
                $ noBorders
                $ maximizeWithPadding 16 
                $ minimize 
                $ myGaps 
                $ tabbed shrinkText myTabTheme

threeColMid     = renamed [Replace "THREECOLMID"] 
                $ maximizeWithPadding 16 
                $ minimize 
                $ mySpacings 
                $ ThreeColMid 1 (3/100) (1/2)

oneBig          = renamed [Replace "ONEBIG"]      
                $ maximizeWithPadding 16 
                $ minimize 
                $ mySpacings 
                $ OneBig (3/4) (3/4)

tiled           = renamed [Replace "TILD"]  
                $ maximizeWithPadding 16 
                $ minimize 
                $ mySpacings 
                $ ResizableTall 1 (3/100) (1/2) []

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
codeLayouts     = tiled ||| oneBig ||| threeColMid ||| tab
allLayout       = threeColMid ||| oneBig ||| tiled ||| tab |||simpleFloat ||| full
myLayoutHook    = showWName' myShowWNameTheme
                $ mkToggle (NOBORDERS ?? FULL ?? EOT)
                $ limitWindows 12
                $ avoidStruts
                $ onWorkspace (myWorkspaces !! 0) codeLayouts
                $ allLayout

--------------------------------------------------  keyBidings --------------------------------------------
myKeys =            -- Programme --
         [ ("M-w",          spawn "firefox"                         )
         , ("M-S-f",        spawn "alacritty -e nnn"                )
         , ("M-d",          spawn "rofi -show drun -Show-icons"     )
         , ("M-S-d",        spawn "dmenu_run -fn 'JetBrains Mono:style=Bold:pixelsize=12' -nb '#11121D' -nf '#7aa2f7' -sb '#7aa2f7' -sf '#11121D' -p 'CMD:'")

                    -- ScreenShoot --
         , ("<Print>",      spawn "scrot -F ~/pix/screen/%Y-%m-%d-%T-screenshot.png && notify-send -t 800 'ScreenShot Takeen' 'Saved in ~/pix/screen/'"     )
         , ("S-<Print>",    spawn "scrot -s -F ~/pix/screen/%Y-%m-%d-%T-screenshot.png && notify-send -t 800 'ScreenShot Takeen' 'Saved in ~/pix/screen/'"  )
         , ("M-<Print>",    spawn "scrot -u -F ~/pix/screen/%Y-%m-%d-%T-screenshot.png && notify-send -t 800 'ScreenShot Takeen' 'Saved in ~/pix/screen/'"  )

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
         , ("C-w",          spawn "bash ~/.scripts/rofi/wifiMenu.sh" )
         , ("C-0",          spawn "bash ~/.scripts/rofi/powerMenu.sh")
               
				    -- Scratchpads --
         , ("M-s t", namedScratchpadAction myScratchPads "terminal")  

                    --  Modifiers Layout --
         , ("M-f",          sendMessage $ Toggle FULL               ) {--Full Screen --}
         , ("M-e",          viewEmptyWorkspace                      ) {-- Find Empty Workspaces --}
         , ("M-g",          tagToEmptyWorkspace                     ) {-- Go To workspaces --}
         , ("M-x",          withFocused (sendMessage . maximizeRestore)) {----For Maximaze With Paddings --}
         , ("M-n",          withFocused minimizeWindow                 ) {-- For Minimize && Action minimize --}
         , ("M-S-n",        withLastMinimized maximizeWindowAndFocus   ) {-- For Minimize && Action minimize --}
         , ("M-S-a",        killAll                                 ) {-- Quite All --}
         , ("M-S-t",        sinkAll                                 ) {-- Push ALL floating windows to tile.--}

                    -- Resize layout --
         , ("M-C-j",        sendMessage MirrorShrink) {-- For Layout ResizableTile( Tiled ) -}
         , ("M-C-k",        sendMessage MirrorExpand) {-- For Layout ResizableTile( Tiled ) -}
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
     ] <+> namedScratchpadManageHook myScratchPads
-------------------------------------------------- ScratchPads -------------------------------------------
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                ]
  where
    spawnTerm  = myTerminal ++ " -t scratchpad"
    findTerm   = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w

-------------------------------------------------- Aplicy All   -------------------------------------------
main = do
    xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobar.hs"
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
                                                       , ppCurrent = xmobarColor blue_ "" . wrap
                                                                 ("<box type=Bottom width=2 mb=2 color=" ++ cyan ++ ">") "</box>"
                                                       -- Visible but not current workspace
                                                       , ppVisible = xmobarColor green ""
                                                       -- Hidden workspace
                                                       , ppHidden = xmobarColor blue_ "" . wrap
                                                                  ("<box type=Top width=2 mt=2 color=" ++ cyan ++ ">") "</box>"
                                                       -- Hidden workspaces (no windows)
                                                       , ppHiddenNoWindows = xmobarColor blue_ ""
                                                       -- Title of active window
                                                       , ppTitle = xmobarColor blue_ "" . shorten 40
                                                       -- Separator character
                                                       , ppSep =  "<fc=" ++ cyan_ ++ "> <fn=1>|</fn> </fc>"
                                                       -- Urgent workspace
                                                       , ppWsSep = "  "
                                                       , ppUrgent = xmobarColor fg "" . wrap "!" "!"
                                                       -- Adding # of windows on current workspace to the bar
                                                       , ppExtras  = [windowCount]
                                                       --  Type Of layout in xmobar
                                                       , ppLayout   = xmobarColor blue_ ""
                                                       -- order of things in xmobar
                                                       , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                                                       } >>  updatePointer (0.5, 0.5) (0, 0) -- exact centre of window
                               } `additionalKeysP` myKeys


