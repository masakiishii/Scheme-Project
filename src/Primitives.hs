module Primitives where

import LispVal (LispVal(..))

primitives::[(String, [LispVal] -> LispVal)]
primitives = [("+", numericBinop (+) ),
              ("-", numericBinop (-) ),
              ("*", numericBinop (*) ),
              ("/", numericBinop div ),
              ("quotient", numericBinop quot ),
              ("remainder", numericBinop rem )]

numericBinop :: (Integer -> Integer -> Integer) -> [LispVal] -> LispVal
numericBinop op params = Number $ foldl1 op $ map unpackNum params

unpackNum :: LispVal -> Integer
unpackNum (Number n) = n
unpackNum (String n) = let parsed = reads n in
                        if null parsed
                        then 0
                        else fst $ parsed !! 0
unpackNum (List [n]) = unpackNum n
unpackNum _ = 0
