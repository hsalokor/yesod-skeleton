module Settings.StaticFiles where

import Yesod.Static (staticFiles, StaticRoute (StaticRoute))

$(staticFiles "static")
