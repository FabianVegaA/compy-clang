module Test.ShowExpressionTests.DeclareTest where

import Expression
  ( Expression (Declare, Infix, Literal),
    Operator (Add),
    Type (Int),
  )
import Test.UtilsTest

declareTest :: IO Bool
declareTest =
  let cases =
        [ (Declare "x" (Literal "1" Int) Int, "int x=1;"),
          (Declare "x" (Infix (Literal "1" Int) Add (Literal "1" Int)) Int, "int x=1+1;")
        ]
   in test cases "Declare"
