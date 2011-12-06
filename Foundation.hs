module Foundation
    ( YesodSkeleton (..)
    , YesodSkeletonRoute (..)
    , YesodSkeletonMessage (..)
    , resourcesYesodSkeleton
    , Handler
    , Widget
    , module Yesod.Core
    , module Settings
    , StaticRoute (..)
    , lift
    , liftIO
    ) where

import Prelude
import Yesod.Core
import Yesod.Default.Config
import Yesod.Default.Util (addStaticContentExternal)
import Yesod.Static (Static, base64md5, StaticRoute(..))
import Settings.StaticFiles
import Yesod.Logger (Logger, logLazyText)
import qualified Settings
import Settings (widgetFile)
import Control.Monad.Trans.Class (lift)
import Control.Monad.IO.Class (liftIO)
import Web.ClientSession (getKey)
import Text.Hamlet (hamletFile)

data YesodSkeleton = YesodSkeleton
    { settings :: AppConfig DefaultEnv
    , getLogger :: Logger
    , getStatic :: Static
    }

mkMessage "YesodSkeleton" "messages" "en"

mkYesodData "YesodSkeleton" $(parseRoutesFile "config/routes")

instance Yesod YesodSkeleton where
    approot = appRoot . settings

    encryptKey _ = fmap Just $ getKey "config/client_session_key.aes"

    defaultLayout widget = do
        mmsg <- getMessage

        pc <- widgetToPageContent $ do
            $(widgetFile "normalize")
            $(widgetFile "default-layout")
        hamletToRepHtml $(hamletFile "templates/default-layout-wrapper.hamlet")

    urlRenderOverride y (StaticR s) =
        Just $ uncurry (joinPath y (Settings.staticRoot $ settings y)) $ renderRoute s
    urlRenderOverride _ _ = Nothing

    messageLogger y loc level msg =
      formatLogMessage loc level msg >>= logLazyText (getLogger y)

    addStaticContent = addStaticContentExternal (const $ Left ()) base64md5 Settings.staticDir (StaticR . flip StaticRoute [])

    yepnopeJs _ = Just $ Right $ StaticR js_modernizr_js
