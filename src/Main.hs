module Main where

import ReadExpr
import System.Environment

main::IO()
main = do
  args <- getArgs
  putStrLn(readExpr (args !! 0))
