module Main where

import qualified MyLib (someFunc)
import qualified HWOne.CreditCard (validate)
import HWFour.BinaryTree

main :: IO ()
main = do
  putStrLn "Hello, Haskell!"
  MyLib.someFunc
  print (HWOne.CreditCard.validate 4012888888881881)
  print (HWOne.CreditCard.validate 4012888888881882)
