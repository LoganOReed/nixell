{-# OPTIONS_GHC -Wall #-}


module HWSeven.JoinList (

)where

import Data.Monoid
import HWSeven.Sized

data JoinList m a = Empty
                  | Single m a
                  | Append m (JoinList m a) (JoinList m a)
  deriving (Eq, Show)

tag :: Monoid m => JoinList m a -> m
tag (Single m _)   = m
tag (Append m _ _) = m
tag _              = mempty

(+++) :: Monoid m => JoinList m a -> JoinList m a -> JoinList m a
(+++) jl1 jl2 = Append (tag jl1 <> tag jl2) jl1 jl2 

indexJ :: (Sized b, Monoid b) => 
          Int -> JoinList b a -> Maybe a
indexJ _ Empty        = Nothing
indexJ n (Single _ a) = Just a
indexJ n (Append s jl1 jl2)
  | n > sizeS   = Nothing
  | n < s1      = indexJ (s1 - n) jl1
  | otherwise   = indexJ (n - s1) jl2
  where sizeS  = getSize $ size s
        s1     = getSize . size $ tag jl1
        
