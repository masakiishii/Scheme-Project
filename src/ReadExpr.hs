module ReadExpr where

import Parse
import Text.ParserCombinators.Parsec hiding (spaces)

readExpr::String -> String
readExpr input = case parse parseExpr "lisp" input of
         Left err -> "No match " ++ show err
         Right val -> "found value " ++ show val
