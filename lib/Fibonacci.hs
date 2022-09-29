{-# OPTIONS_GHC -Wall #-}

module Fibonacci (

)where

fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

-- Lazy Loads infinite list of fib nums
fibs1 :: [Integer]
fibs1 = map fib [0..]

addFirstTwo :: [Integer] -> [Integer]
addFIrstTwo [x]          = x : x : []
addFirstTwo f@(x1:x2:xs) = (x1 + x2) : f
addFirstTwo _            = [1,0]

-- O(n) runtime version of prev funct
fibs2 :: [Integer]
fibs2 = 0 : 1 : zipWith (+) fibs2 (tail fibs2)

testFibs2 :: Int -> [Integer]
testFibs2 n = take n fibs2
