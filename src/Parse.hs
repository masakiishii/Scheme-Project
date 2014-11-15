module Parse where

import LispVal (LispVal(..))
import ShowVal
import Symbol

import System.Environment
import Text.ParserCombinators.Parsec hiding (spaces)
import Control.Monad


parseList::Parser LispVal
parseList = sepBy parseExpr Symbol.spaces >>= return . List

parseDottedList::Parser LispVal
parseDottedList = do
  head <- endBy parseExpr Symbol.spaces
  tail <- char '.' >> Symbol.spaces >> parseExpr
  return $ DottedList head tail

parseQuoted::Parser LispVal
parseQuoted = do
  char '\''
  x <- parseExpr
  return $ List [Atom "quote", x]

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
parseNumber = many1 digit >>= return . Number . read

parseExpr::Parser LispVal
parseExpr = parseAtom
          <|> parseString
          <|> parseNumber
          <|> parseQuoted
          <|> do char '('
                 x <- try parseList <|> parseDottedList
                 char ')'
                 return x
