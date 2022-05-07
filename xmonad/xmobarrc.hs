Config
   { font                = "xft:JetBrains Mono:style=Bold:size=8"
   , additionalFonts     =  [ "xft:JetBrains Mono:style=bold:size=10:antialias=true"     
                            , "xft:Font Awesome 6 Free Solid:pixelsize=12"
                            , "xft:Font Awesome 6 Brands:pixelsize=12"
                            ]
   , borderColor        = "#161320"
   , border             = NoBorder
   , bgColor            = "#161320"
   , fgColor            = "#F2CDCD"
   , alpha              = 255                 						-- default: 255
   , position           = TopSize C 100 28
   , textOffset         = -1             						-- default: -1
   , iconOffset         = -1             						-- default: -1
   , lowerOnStart       = True
   , pickBroadest       = False        							-- default: False
   , persistent         = True
   , hideOnStart        = False
   , iconRoot           = "/home/xarch/.config/xmobar/xpm/"  				-- default: "."
   , allDesktops        = True          						-- default: True
   , overrideRedirect 	= False    							-- default: True
   , commands           = [ Run Date "<fn=2>\xf017</fn> %b %d %Y  %H:%M:%S" "date" 10
                        , Run Cpu ["-t", "<fn=2>\xf108</fn>  CPU: (<total>%)","-H","50","--high","red"] 20
                        , Run Memory ["-t", "<fn=2>\xf233</fn>  MEM: (<usedratio>%)"] 20
                        , Run DiskU [("/", "<fn=2>\xf0c7</fn>  SSD: <free> free")] [] 60
                        , Run BatteryP ["BAT0"] ["-t", " <fn=2>\61671</fn> BAT: <acstatus><watts> (<left>%)"] 360
                        , Run Uptime ["-t", " <fn=2>\62036</fn> UP: <days>d <hours>h"] 36000
                        , Run Com "uname" ["-r"] "" 3600
                        , Run DynNetwork ["-t","<fc=#076678><fn=2></fn> NET:  <fn=2></fn></fc> <rx>, <fc=#8f3f71><fn=2></fn></fc> <tx>"
                            ,"-H","200"
                            ,"-L","10"
                            ,"-h","#8f3f71"
                            ,"-l","#076678"
                            ,"-n","#b57614"] 50
                        ,  Run Volume "default" "Master"
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
       , template = " <icon=arch.xpm/><fc=#689d6a>  <fn=2></fn></fc>  %UnsafeStdinReader% }{ <fc=#427b58><fn=3></fn> %uname%</fc>   <fc=#b57614>%cpu%</fc>   <fc=#af3a03>%memory%</fc>   <fc=#076678>%disku%</fc>   <fc=#797403>%battery%</fc>   <fc=#8f3f71>%uptime%</fc>   %dynnetwork%   %default:Master%   <fc=#d65d0e>%date%</fc>  "
       }
