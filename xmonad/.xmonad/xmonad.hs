import Data.Default (def)
import Data.Monoid ((<>))
import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Util.EZConfig
import XMonad.Util.NamedScratchpad


main = xmonad =<< statusBar "xmobar" myXmobarPP toggleStrutsKey myConfig

myXmobarPP :: PP
myXmobarPP = def { ppCurrent = xmobarColor "green" "" . wrap "[" "]"
                 , ppTitle   = ignore -- xmobarColor "grey"  "" . shorten 40
                 , ppVisible = wrap "(" ")"
                 , ppUrgent  = xmobarColor "red" "yellow"
                 }
  where ignore _ = ""

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- main = xmonad =<< xmobar myConfig

myConfig = def
    { terminal    = "konsole"
    , modMask     = mod4Mask
    , startupHook = startupCommands
    , borderWidth = 2
    , layoutHook = avoidStruts $ layoutHook desktopConfig ||| simpleTabbed ||| Full
    , manageHook  = manageHook desktopConfig <+> manageDocks <+>  namedScratchpadManageHook scratchpads
    , normalBorderColor = "#10b060"
    , focusedBorderColor = "#30d080"
    }
    `additionalKeysP`
    [ ("M1-C-l", lockScreen) -- Lock screen using Ctrl+Alt+L
    , ("<Print>", takeScreenshot) -- Take screenshot
    -- Named scratchpads for chat apps
    , ("M-C-k", namedScratchpadAction scratchpads "wrinkle")
    , ("M-C-j", namedScratchpadAction scratchpads "irccloud")
    , ("M-C-u", namedScratchpadAction scratchpads "note")
    ]

scratchpads = [ scratchChromeApp "wrinkle" "internal.wrinkl.obsidian.systems"
              , scratchChromeApp "irccloud" "irccloud.com"
              , scratchChromeApp "dynalist" "dynalist.io"
              , scratchEmacs "note"
              ]

takeScreenshot =
  spawn "maim -s | xclip -selection clipboard -t image/png"

lockScreen =
  spawn "i3lock -i ~/mynixos/files/Atom-HD-Wallpaper.png"

startupCommands :: X ()
startupCommands = do
  -- Wallpaper
  spawn "feh --bg-fill ~/mynixos/files/Elephant-Mammoth-Dark.jpg"

-- A dedicated emacs process
scratchEmacs name = NS name cli q defaultFloating
  where cli = "emacs --name=" <> name
        q = windowQuery "Emacs" name

scratchChromeApp name url = NS name cli q defaultFloating
  where cli = "google-chrome-stable --app=https://" <> url
        q = windowQuery "Google-chrome" url

windowQuery class_ resource_ = className =? class_ <&&> resource =? resource_
