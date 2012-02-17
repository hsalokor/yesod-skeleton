import System.IO
import Data.Function
import Control.Monad

import Yesod

data Skeleton = Skeleton

instance Yesod Skeleton

mkYesod "Skeleton" [parseRoutes|
/   DataR   GET
|]

getDataR :: Handler RepPlain
getDataR = return $ RepPlain "Foobar"

main :: IO ()
main = warpDebug 3000 $ Skeleton 
