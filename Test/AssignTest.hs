module Test.AssignTest where

import Expression
  ( Expression (Assign, Infix, Literal),
    Operator (Add),
    Type (Int),
  )
import Test.UtilsTest (test)

assignTest :: IO Bool
assignTest =
  let cases =
        [ ( Assign "x" (Literal "1" Int),
            "x=1;"
          ),
          ( Assign "x" (Infix (Literal "1" Int) Add (Literal "1" Int)),
            "x=1+1;"
          )
        ]
   in test cases "Assign"
