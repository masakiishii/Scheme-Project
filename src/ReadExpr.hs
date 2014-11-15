module ReadExpr where

import Parse
import LispVal
import Text.ParserCombinators.Parsec hiding (spaces)

readExpr::String -> LispVal
readExpr input = case parse parseExpr "lisp" input of
         Left err -> String $ "No match " ++ show err
         Right val -> val
