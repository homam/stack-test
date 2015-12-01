module Lib
    (
      someFunc
    ) where

import Data.Time (getCurrentTime)
import Network.HTTP.Conduit
import qualified Data.ByteString.Lazy.Char8 as L


someFunc :: IO ()
someFunc = do
    getCurrentTime >>= print
    simpleHttp "http://pages.mli.me/headers" >>= L.putStrLn
