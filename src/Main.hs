module Main where

import ReadExpr
import Eval
import System.Environment


main::IO()
main = getArgs >>= print . eval . readExpr . head
