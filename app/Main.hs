module Main where

import Lib
import Pages
import System.Directory (getHomeDirectory)

main :: IO ()
main = do
  someFunc
  getHomeDirectory >>= findAllFiles "index.html" >>= mapM_ putStrLn
