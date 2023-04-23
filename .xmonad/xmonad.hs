import XMonad
-- import qualified XMonad.StackSet as W
-- import XMonad.Layout.NoBorders

main = xmonad defaultConfig {
         modMask    = mod4Mask -- yeah, pretty gay I can't bind to mod2 ...
       , terminal   = "st"
--       , layoutHook = Full
--       , manageHook = composeAll [
--            resource  =? "Navigator" --> doF W.swapDown  -- doesn't work
--          , className =? "Iceweasel" --> doF W.swapDown  -- doesn't work
--          , className =? "VBoxSDL"   --> doShift "2"     -- sends to workspace 2
--         ]
--       , manageHook = manageHook defaultConfig <+> doF W.swapDown -- every new window starts under, might be problematic w/ floating, doesn't work
--       , layoutHook = smartBorders $ layoutHook defaultConfig
       }


-- foxtrot xmonad.hs
-- import XMonad
-- import XMonad.Hooks.DynamicLog -- requires xmonad-contrib
-- 
-- main = do
--    xmonad =<< xmobar defaultConfig {
--        modMask    = mod4Mask
--      , terminal   = "urxvt"
-- --       , layoutHook = Full
-- --       , layoutHook = smartBorders $ layoutHook defaultConfig
--    }
-- 
-- -- toggleXMobarKey XConfig { XMonad.modMask = modMask } = (modMask, xK_b) -- Super-b toggles xmobar
-- toggleXMobarKey XConfig { XMonad.modMask = modMask } = (modMask, xK_semicolon)
