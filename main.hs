import System.IO
import Data.Either
import Data.Maybe
import Data.Function
import Control.Monad

import Yesod
import Yesod.Core

data Skeleton = Skeleton

instance Yesod Skeleton where
    approot _ = ""
    encryptKey _ = return Nothing

mkYesod "Skeleton" [parseRoutes|
/   DataR   GET
|]

getDataR :: Handler RepPlain
getDataR = return $ RepPlain "Foobar"

main :: IO ()
main = warpDebug 3000 $ Skeleton 
