Config {
       font = "xft:JetBrains Mono:weight=bold:pixelsize=11:antialias=true:hinting=true"
       , additionalFonts = [ "xft:Mononoki:pixelsize=12:antialias=true:hinting=true"
                           , "xft:Font Awesome 6 Free Solid:pixelsize=12"
                           , "xft:Font Awesome 6 Brands:pixelsize=12"
                           ]
       , bgColor = "#282828"
       , fgColor = "#ebdbb2"
       , alpha   = 255
       , position = TopSize L 100 25
       , border = NoBorder
       , borderWidth = 1
       , borderColor = "#fb4934"
       , lowerOnStart = True
       , hideOnStart = False
       , allDesktops = True
       , persistent = True
       , iconRoot = "/home/xarch/.config/xmobar/xpm/"  -- default: "[NERD]"
       , commands = [ Run Date "<fn=2>\xf017</fn> %b %d %Y  %H:%M:%S" "date" 10
                    , Run Cpu ["-t", "<fn=2>\xf108</fn>  CPU: (<total>%)","-H","50","--high","red"] 20
                    , Run Memory ["-t", "<fn=2>\xf233</fn>  MEM: (<usedratio>%)"] 20
                    , Run DiskU [("/", "<fn=2>\xf0c7</fn>  SSD: <free> free")] [] 60
                    , Run BatteryP ["BAT0"] ["-t", " <fn=2>\61671</fn> BAT: <acstatus><watts> (<left>%)"] 360
                    , Run Uptime ["-t", " <fn=2>\62036</fn> UP: <days>d <hours>h"] 36000
                    , Run Com "uname" ["-r"] "" 3600
                    , Run Brightness [ "-t", "<fn=2></fn> BR: <percent>%", "--", "-D", "intel_backlight" ] 60
                    , Run Volume "default" "Master"
                        [ "-t", "<status>", "--"
                        , "--on", "<fc=#b57614><fn=2>\xf028</fn> VOL:  <volume>%</fc>"
                        , "--onc", "#b57614"
                        , "--off", "<fc=#cc241d><fn=2>\xf026</fn> MUTE  </fc>"
                        , "--offc", "#cc241d"
                        ] 1
                    , Run UnsafeStdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " <icon=arch.xpm/><fc=#fe8019> <fn=2></fn></fc> %UnsafeStdinReader%}{ <box type=Bottom width=2 mb=2 color=#427b58><fc=#427b58><fn=3></fn> %uname%</fc></box>   <box type=Bottom width=2 mb=2 color=#b57614><fc=#b57614>%cpu%</fc></box>   <box type=Bottom width=2 mb=2 color=#af3a03><fc=#af3a03>%memory%</fc></box>   <box type=Bottom width=2 mb=2 color=#076678><fc=#076678>%disku%</fc></box>   <box type=Bottom width=2 mb=2 color=#797403><fc=#797403>%battery%</fc></box>  <box type=Bottom width=2 mb=2 color=#8f3f71><fc=#8f3f71>%uptime%</fc></box>   <box type=Bottom width=2 mb=2 color=#d65d0e>%default:Master%</box>   <box type=Bottom width=2 mb=2 color=#427b58><fc=#427b58>%bright%</fc></box>   <box type=Bottom width=2 mb=2 color=#d65d0e><fc=#d65d0e>%date%</fc></box> "
       }
