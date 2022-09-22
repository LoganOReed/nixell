module Main where

import qualified MyLib (someFunc)
import qualified CreditCard (validate)

main :: IO ()
main = do
  putStrLn "Hello, Haskell!"
  MyLib.someFunc
  print (CreditCard.validate 4012888888881881)
  print (CreditCard.validate 4012888888881882)
