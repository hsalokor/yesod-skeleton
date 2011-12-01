import Yesod.Default.Config (fromArgs)
import Yesod.Default.Main   (defaultMain)
import Application          (withYesodSkeleton)
import Prelude              (IO)

main :: IO ()
main = defaultMain fromArgs withYesodSkeleton