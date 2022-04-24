Config {
       font = "xft:JetBrains Mono:size=10:bold:antialias=true"
       , additionalFonts = [ "xft:Mononoki:pixelsize=12:antialias=true:hinting=true"
                           , "xft:Font Awesome 6 Free Solid:pixelsize=12"
                           , "xft:Font Awesome 6 Brands:pixelsize=12"
                           ]
       , bgColor = "#1d2021"
       , fgColor = "#ebdbb2"
       --, alpha   = 170
       , position = Static { xpos = 0, ypos = 0, width = 1920, height = 38 }
       , border = BottomB
       , borderWidth = 1
       , borderColor = "#fe8019"
       , lowerOnStart = True
       , hideOnStart = False
       , allDesktops = True
       , persistent = True
       , iconRoot = "/home/xeera/.config/xmobar/xpm/"  -- default: "[NERD]"
       , commands = [ Run Date "<fn=2>\xf017</fn> %b %d %Y  %H:%M:%S" "date" 10
                    , Run Cpu ["-t", "<fn=2>\xf108</fn>  CPU: (<total>%)","-H","50","--high","red"] 20
                    , Run Memory ["-t", "<fn=2>\xf233</fn>  MEM: (<usedratio>%)"] 20
                    , Run DiskU [("/", "<fn=2>\xf0c7</fn>  SSD: <free> free")] [] 60
                    , Run BatteryP ["BAT0"] ["-t", " <fn=2>\61671</fn> BAT: <acstatus><watts> (<left>%)"] 360
                    , Run Uptime ["-t", " <fn=2>\62036</fn> UP: <days>d <hours>h"] 36000
                    , Run Com "uname" ["-r"] "" 3600
              --      , Run DynNetwork ["-t","<fc=#4db5bd><fn=2></fn></fc> <rx>, <fc=#c678dd><fn=2></fn></fc> <tx>"
              --                       ,"-H","200"
              --                     ,"-L","10"
              --                       ,"-h","#bbc2cf"
              --                       ,"-l","#bbc2cf"
              --                       ,"-n","#bbc2cf"] 50
                    , Run UnsafeStdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " <icon=arch.xpm/><fc=#fe8019> <fn=2></fn> </fc>%UnsafeStdinReader% }{ <fc=#427b58><fn=3></fn> %uname%</fc>    <fc=#b57614>%cpu%</fc>   <fc=#af3a03>%memory%</fc>   <fc=#076678>%disku%</fc>   <fc=#797403>%battery%</fc>   <fc=#8f3f71>%uptime%</fc>   <fc=#d65d0e>%date%</fc>  "
       }
