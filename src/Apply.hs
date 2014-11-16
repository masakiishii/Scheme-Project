module Apply where

import LispVal (LispVal(..))
import Primitives

apply::String -> [LispVal] -> LispVal
apply func args = maybe (Bool False) ($ args) $ lookup func primitives
