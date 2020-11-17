{- butrfeld Andrew Butterfield -}
module Ex02 where

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

-- Datatypes and key functions -----------------------------------------------

-- do not change anything in this section !

type Id = String

data Expr
  = Val Double
  | Add Expr Expr
  | Mul Expr Expr
  | Sub Expr Expr
  | Dvd Expr Expr
  | Var Id
  | Def Id Expr Expr
  deriving (Eq, Show)

type Dict k d  =  [(k,d)]

define :: Dict k d -> k -> d -> Dict k d
define d s v = (s,v):d

find :: Dict String d -> String -> Either String d
find []             name              =  Left ("undefined var "++name)
find ( (s,v) : ds ) name | name == s  =  Right v
                         | otherwise  =  find ds name

type EDict = Dict String Double

v42 = Val 42 ; j42 = Just v42

-- do not change anything above !

-- Part 1 : Evaluating Expressions -- (50 test marks, worth 25 Exercise Marks) -

-- Implement the following function so all 'eval' tests pass.

-- eval should return `Left msg` if:
  -- (1) a divide by zero operation was going to be performed;
  -- (2) the expression contains a variable not in the dictionary.
  -- see test outcomes for the precise format of those messages

eval :: EDict -> Expr -> Either String Double
eval d (Val e) = Right e
eval d (Var e) = find d e

eval d (Def n e f)
    = let x = eval d e
    in case (x) of
      Right x -> eval (define d n x) f
      Left x  -> Left x

eval d (Add e1 e2) = case (eval d e1, eval d e2) of
                (Right e, Right f) -> Right(e + f)
                (Left e, Right f) -> Left e
                (Right e, Left f) -> Left f
                (Left e, Left f) -> Left e

eval d (Mul e1 e2) = case (eval d e1, eval d e2) of
                (Right e, Right f) -> Right(e * f)
                (Left e, Right f) -> Left e
                (Right e, Left f) -> Left f
                (Left e, Left f) -> Left e

eval d (Sub e1 e2) = case (eval d e1, eval d e2) of
                (Right e, Right f) -> Right(e - f)
                (Left e, Right f) -> Left e
                (Right e, Left f) -> Left f
                (Left e, Left f) -> Left e
                
eval d (Dvd _ (Val 0)) = Left "div by zero"

eval d (Dvd e1 e2) = case (eval d e1, eval d e2) of
                (Right e, Right f) -> Right(e / f)
                (Left e, Right f) -> Left e
                (Right e, Left f) -> Left f
                (Left e, Left f) -> Left e
                
                
                
-- Part 1 : Expression Laws -- (15 test marks, worth 15 Exercise Marks) --------

{-

There are many, many laws of algebra that apply to our expressions, e.g.,

  x + y            =  y + x         Law 1
  x + (y + z)      =  (x + y) + z   Law 2
  x - (y + z)      =  (x - y) - z   Law 3
  (x + y)*(x - y)  =  x*x - y*y     Law 4
  ...

  We can implement these directly in Haskell using Expr

  Function LawN takes an expression:
    If it matches the "shape" of the law lefthand-side,
    it replaces it with the corresponding righthand "shape".
    If it does not match, it returns Nothing

    Implement Laws 1 through 4 above
-}
law1 :: Expr -> Maybe Expr
law1 (Add e1 e2) = Just (Add e2 e1)
law1 _ = Nothing

law2 :: Expr -> Maybe Expr
law2 (Add e1 (Add e2 e3)) = Just (Add (Add e1 e2) e3)
law2 _ = Nothing

law3 :: Expr -> Maybe Expr
law3 (Sub e1 (Add e2 e3)) = Just (Sub (Sub e1 e2) e3)
law3 _ = Nothing

law4 :: Expr -> Maybe Expr
law4 (Mul (Add e f) (Sub g h)) = if (e == g) && (f == h) then Just (Sub (Mul e e) (Mul f f)) else Nothing
law4 _ = Nothing

