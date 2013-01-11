import XMonad
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.DynamicLog
import XMonad.Actions.PhysicalScreens

myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount 
	where fadeAmount = 0.8

main = xmonad =<< statusBar myBar myPP toggleStructsKey myConfig

myBar = "xmobar"

myPP = xmobarPP {ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

toggleStructsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = defaultConfig {
		workspaces = myWorkspaces,
		borderWidth = 3,
		logHook = myLogHook,
		modMask = mod4Mask
	} `additionalKeys` myKeys `additionalKeysP` myKeysP

myWorkspaces = ["1","2","3","4","5","6","7","8","9"]

myKeys = [
	  ((mod4Mask, xK_a), onPrevNeighbour W.view)
	, ((mod4Mask, xK_o), onNextNeighbour W.view)
	, ((mod4Mask .|. shiftMask, xK_a), onPrevNeighbour W.shift)
	, ((mod4Mask .|. shiftMask, xK_o), onNextNeighbour W.shift)
	] ++ 
	[((mod4Mask .|. mask, key), f sc)
	    | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
		 , (f, mask) <- [(viewScreen, 0), (sendToScreen, shiftMask)]]


myKeysP = [
	("M-C-l", spawn "xscreensaver-command -lock"),
   ("M-a", onPrevNeighbour W.view),
   ("M-o", onNextNeighbour W.view),
   ("M-S-a", onPrevNeighbour W.shift),
   ("M-S-o", onNextNeighbour W.shift)

    -- other additional keys
	]
     ++ -- (++) is needed here because the following list comprehension
         -- is a list, not a single key binding. Simply adding it to the
         -- list of key bindings would result in something like [ b1, b2,
         -- [ b3, b4, b5 ] ] resulting in a type error. (Lists must
         -- contain items all of the same type.)
 
    [ (otherModMasks ++ "M-" ++ [key], action tag)
      | (tag, key)  <- zip myWorkspaces "123456789"
      , (otherModMasks, action) <- [ ("", windows . W.view) -- was W.greedyView
                                      , ("S-", windows . W.shift)]
    ]

