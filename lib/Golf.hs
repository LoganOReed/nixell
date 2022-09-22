{-# OPTIONS_GHC -Wall #-}

module Golf where 

hop :: [a] -> Int -> [a]
hop str n = map fst $ filter (\x -> snd x `mod` n == 0) (zip str [1..]) 

skip :: [a] -> [[a]]
skip str = map (hop str) [1 .. length(str)]
