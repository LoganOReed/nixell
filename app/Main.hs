module Main where

import qualified MyLib (someFunc)
import qualified HWOne (toDigits, toDigitsRev)

main :: IO ()
main = do
  putStrLn "Hello, Haskell!"
  MyLib.someFunc
  print (HWOne.toDigits 54321)
  print (HWOne.toDigitsRev 54321)
