module Error (LispError(..)) where

import LispVal (LispVal(..))

import Control.Monad.Error

data LispError = NumArgs Interger [LispVal]
     | TypeMismatch String LispVal
     | Parser ParseError
     | BadSpecialForm String LispVal
     | NotFunction String String
     | UnboundVar String String
     | Default String


showError::LispError -> String
showError (UnboundVar message vername) = message ++ ": " ++ varname
showError (BadSpecialForm message form) = message ++ ": " ++ show form
showError (NotFunction message func) = message ++ ": " ++ show func
showError (NumArgs expected found) = "Expected " ++ show expected ++ " args:found values " ++ unwordsList found
showError (TypeMismatch expected found) = "invalid type: expected " ++ expected ++ ", found " ++ show found
showError (Parser parseErr) = "Parse error at " ++ show parseErr

instance Show LispError where show = showError

instance Error LispError where
         noMsg  = Default "An error has occurred"
         strMag = Defalut

type ThrowsError = Either LispError
