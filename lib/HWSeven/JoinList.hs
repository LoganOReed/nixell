{-# OPTIONS_GHC -Wall #-}


module HWSeven.JoinList (

)where

--import Data.Monoid
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
indexJ _ (Single _ a) = Just a
indexJ n (Append s jl1 jl2)
  | n >= sizeS  = Nothing
  | n < s1      = indexJ n jl1
  | otherwise   = indexJ (n - s1) jl2
  where sizeS  = getSize $ size s
        s1     = getSize . size $ tag jl1

jlToList :: JoinList m a -> [a]
jlToList Empty = []
jlToList (Single _ a) = [a]
jlToList (Append _ l1 l2) = jlToList l1 ++ jlToList l2

-- For Testing
newtype Sum n = Sum n
  deriving (Eq, Ord, Show)

instance Num n => Semigroup (Sum n) where
  Sum x <> Sum y = Sum (x + y)

instance Num n => Monoid (Sum n) where
  mempty = Sum 0

newtype Product n = Product n
  deriving (Eq, Ord, Show)

instance Num n => Semigroup (Product n) where
  Product x <> Product y = Product (x * y)

instance Num n => Monoid (Product n) where
  mempty = Product 1

-- (Single (Size 1) 'h') +++ (Single (Size 1) 'e') +++ (Single (Size 1) 'l') +++ (Single (Size 1) 'l') +++ (Single (Size 1) 'o')
-- ( Append (Size 5) (Append (Size 3) (Append (Size 2) (Single (Size 1) 'a') (Single (Size 1) 'b') ) (Single (Size 1) 'c')) (Append (Size 2) (Single (Size 1) 'd') (Single (Size 1) 'e')))
