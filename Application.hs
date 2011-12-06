{-# OPTIONS_GHC -fno-warn-orphans #-}
module Application
    ( withYesodSkeleton
    , withDevelAppPort
    ) where

import Import
import Settings
import Yesod.Static
import Yesod.Default.Config
import Yesod.Default.Main (defaultDevelApp, defaultRunner)
import Yesod.Default.Handlers (getFaviconR, getRobotsR)
import Yesod.Logger (Logger)
import Network.Wai (Application)
import Data.Dynamic (Dynamic, toDyn)

import Handler.Root

mkYesodDispatch "YesodSkeleton" resourcesYesodSkeleton

withYesodSkeleton :: AppConfig DefaultEnv -> Logger -> (Application -> IO ()) -> IO ()
withYesodSkeleton conf logger f = do
#ifdef PRODUCTION
    s <- static Settings.staticDir
#else
    s <- staticDevel Settings.staticDir
#endif
    let h = YesodSkeleton conf logger s
    defaultRunner f h

withDevelAppPort :: Dynamic
withDevelAppPort = toDyn $ defaultDevelApp withYesodSkeleton
