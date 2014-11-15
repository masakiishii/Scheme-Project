module Main where
import LispVal (LispVal(..))
import ShowVal
import System.Environment
import Text.ParserCombinators.Parsec hiding (spaces)
import Control.Monad


parseList::Parser LispVal
parseList = liftM List $ sepBy parseExpr spaces

parseDottedList::Parser LispVal
parseDottedList = do
  head <- endBy parseExpr spaces
  tail <- char '.' >> spaces >> parseExpr
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


spaces::Parser()
spaces = skipMany1 space

symbol :: Parser Char
symbol = oneOf "!#$%&|*+-/:<=>?@^_~"

readExpr::String -> String
readExpr input = case parse parseExpr "lisp" input of
         Left err -> "No match " ++ show err
         Right val -> "found value " ++ show val

main::IO()
main = do
  args <- getArgs
  putStrLn(readExpr (args !! 0))
