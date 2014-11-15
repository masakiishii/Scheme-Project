module Parse where

import LispVal (LispVal(..))
import ShowVal
import Symbol

import System.Environment
import Text.ParserCombinators.Parsec hiding (spaces)
import Control.Monad


parseList::Parser LispVal
parseList = liftM List $ sepBy parseExpr Symbol.spaces

parseDottedList::Parser LispVal
parseDottedList = do
  head <- endBy parseExpr Symbol.spaces
  tail <- char '.' >> Symbol.spaces >> parseExpr
  return $ DottedList head tail

parseQuated::Parser LispVal
parseQuated = do
  char '\''
  x <- parseExpr
  return $ List [Atom "quate", x]


parseString::Parser LispVal
parseString = do char '"'
                 x <- many (noneOf "\"")
                 char '"'
                 return $ String x

parseAtom::Parser LispVal
parseAtom = do first <- letter <|> symbol
               rest <- many (letter <|> digit <|> symbol)
               let atom = first:rest
               return $ case atom of
                   "#t" -> Bool True
                   "#f" -> Bool False
                   _    -> Atom atom

parseNumber::Parser LispVal
parseNumber = liftM (Number . read) $ many1 digit

parseExpr::Parser LispVal
parseExpr = parseAtom
          <|> parseString
          <|> parseNumber
          <|> parseQuated
          <|> do char '('
                 x <- try parseList <|> parseDottedList
                 char ')'
                 return x
