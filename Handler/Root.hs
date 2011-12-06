module Handler.Root where

import Import

getRootR :: Handler RepHtml
getRootR = do
    defaultLayout $ do
        h2id <- lift newIdent
        setTitle "yesod-skeleton homepage"
        $(widgetFile "homepage")
