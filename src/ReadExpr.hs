module ReadExpr where

import Parse
import LispVal
import Text.ParserCombinators.Parsec hiding (spaces)

readExpr::String -> ThrowError LispVal
readExpr input = case parse parseExpr "lisp" input of
         Left err -> ThrowError $ Parser err
         Right val -> return val
