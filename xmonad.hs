import XMonad
import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import XMonad.Actions.RotSlaves
import XMonad.Config.Desktop
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeWindows
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import XMonad.Util.Replace

-- https://xmonad.github.io/xmonad-docs/xmonad-contrib/XMonad-Config-Prime.html#t:KeySym
-- https://xmonad.github.io/xmonad-docs/xmonad-contrib/XMonad-Config-Prime.html#v:mod5MapIndex

alt = mod1Mask
shift = shiftMask
super = mod4Mask
space = xK_space
tab = xK_Tab

layout = tiled ||| Mirror tiled ||| Full
	where
		tiled   = Tall nmaster delta ratio
		nmaster = 1
		ratio   = 2/3
		delta   = 0

bindKeys =
	[
		((alt, tab), rotAllUp),
		((alt .|. shift, tab), rotAllDown),
		((super, tab), nextWS),
		((super .|. shift, tab), prevWS),
		((super, xK_q), kill1)
	]
-- https://gist.github.com/micrub/aeebe7eb4d2df9e5e203e76a0fd89542
unbindKeys =
	[
		-- action keybindings
		"M-S-c",
		"M-p",
		"M-S-p",
		"M-S-q",
		"M-S-/",
		-- window movement keybindings
		"M-<Space>",
		"M-S-<Space>",
		"M-<Return>",
		-- "M-<Tab>",
		-- "M-S-<Tab>",
		"M-h",
		"M-j",
		"M-S-j",
		"M-k",
		"M-S-k",
		"M-l",
		"M-m",
		"M-n",
		"M-t",
		"M-,",
		"M-."
	]

start_wm = xmonad $ ewmhFullscreen $ ewmh $ docks def {
		terminal = "kitty",
		modMask = super,
		layoutHook = avoidStruts $ smartSpacing 10 $ layout,
		borderWidth = 0
	}
	`additionalKeys` bindKeys
	`removeKeysP` unbindKeys

main :: IO ()
main = do
	replace
	start_wm
