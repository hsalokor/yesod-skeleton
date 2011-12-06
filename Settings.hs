module Settings
    ( widgetFile
    , staticRoot
    , staticDir
    ) where

import Prelude (FilePath, String)
import Text.Shakespeare.Text (st)
import Language.Haskell.TH.Syntax
import Yesod.Default.Config
import qualified Yesod.Default.Util
import Data.Text (Text)

staticDir :: FilePath
staticDir = "static"

staticRoot :: AppConfig DefaultEnv ->  Text
staticRoot conf = [st|#{appRoot conf}/static|]

widgetFile :: String -> Q Exp
#if PRODUCTION
widgetFile = Yesod.Default.Util.widgetFileProduction
#else
widgetFile = Yesod.Default.Util.widgetFileDebug
#endif
