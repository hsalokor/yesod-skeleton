{-# LANGUAGE TemplateHaskell, QuasiQuotes, GeneralizedNewtypeDeriving, TypeFamilies, OverloadedStrings, MultiParamTypeClasses #-}
import qualified Data.Text as T

import Yesod

data Skeleton = Skeleton

instance Yesod Skeleton

mkYesod "Skeleton" [parseRoutes|
/   DataR   GET
|]

getDataR :: Handler RepPlain
getDataR = return $ RepPlain $ toContent $ T.pack "Foobar"

main :: IO ()
main = warpDebug 3000 $ Skeleton 
