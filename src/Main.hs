module Main where

import LispVal (LispVal(..))
import ShowVal
import Symbol
import Parse

import System.Environment
import Text.ParserCombinators.Parsec hiding (spaces)
import Control.Monad


readExpr::String -> String
readExpr input = case parse parseExpr "lisp" input of
         Left err -> "No match " ++ show err
         Right val -> "found value " ++ show val

main::IO()
main = do
  args <- getArgs
  putStrLn(readExpr (args !! 0))
