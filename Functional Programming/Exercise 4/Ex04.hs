{- butrfeld Andrew Butterfield -}
module Ex04 where

name, idno, username :: String
name      =  "McGrath, Luke"  -- replace with your name
idno      =  "17337376"    -- replace with your student id
username  =  "mcgratlu"   -- replace with your TCD username

declaration -- do not modify this
 = unlines
     [ ""
     , "@@@ This exercise is all my own work."
     , "@@@ Signed: " ++ name
     , "@@@ "++idno++" "++username
     ]

-- Datatypes -------------------------------------------------------------------

-- do not change anything in this section !


-- a binary tree datatype, honestly!
data BinTree k d
  	= Branch (BinTree k d) (BinTree k d) k d
  	| Leaf k d
  	| Empty
  	deriving (Eq, Show)


-- Part 1 : Tree Insert -------------------------------

-- Implement:
ins :: Ord k => k -> d -> BinTree k d -> BinTree k d
ins key value Empty = Leaf key value
ins key value (Leaf k x) 
	| key > k = Branch Empty (Leaf key value) k x  
  	| key < k = Branch (Leaf key value) Empty k x
  	| key == k = Leaf k value
   
   
ins key value (Branch q r k x)
	| key > k = Branch q (ins key value r) k x
  	| key < k = Branch (ins key value q) r k x
  	| key == k = Branch q r key value

-- Part 2 : Tree Lookup -------------------------------

-- Implement:
lkp :: (Monad m, Ord k) => BinTree k d -> k -> m d
lkp Empty _ = fail ("lkp fail - Empty Tree")
lkp (Leaf k x) key
  	| k == key = return x
  	| otherwise = fail ("lkp fail - Key not in tree")
lkp (Branch q r k x) key
	| key > k = lkp r key
  	| key < k = lkp q key
  	| key == k = return x


-- Part 3 : Tail-Recursive Statistics

{-
   It is possible to compute BOTH average and standard deviation
   in one pass along a list of data items by summing both the data
   and the square of the data.
-}
twobirdsonestone :: Double -> Double -> Int -> (Double, Double)
twobirdsonestone listsum sumofsquares len
 = (average,sqrt variance)
 where
   nd = fromInteger $ toInteger len
   average = listsum / nd
   variance = sumofsquares / nd - average * average

{-
  The following function takes a list of numbers  (Double)
  and returns a triple containing
   the length of the list (Int)
   the sum of the numbers (Double)
   the sum of the squares of the numbers (Double)

   You will need to update the definitions of init1, init2 and init3 here.
-}
getLengthAndSums :: [Double] -> (Int,Double,Double)
getLengthAndSums ds = getLASs init1 init2 init3 ds

init1 = 0
init2 = 0
init3 = 0

{-
  Implement the following tail-recursive  helper function
-}
getLASs :: Int -> Double -> Double -> [Double] -> (Int,Double,Double)
getLASs init1 init2 init3 [] = (init1,init2,init3)
getLASs init1 init2 init3 (a:aa) = getLASs (init1+1) (init2+a) (init3+a*a) aa


-- Final Hint: how would you use a while loop to do this?
--   (assuming that the [Double] was an array of double)
