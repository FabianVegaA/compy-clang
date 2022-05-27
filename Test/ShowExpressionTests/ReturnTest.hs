module Test.ShowExpressionTests.ReturnTest where

import Expression
  ( Expression (Infix, Literal, Prefix, Return, Val),
    Operator (Add),
    PrefixOperator (Not),
    Type (Int),
  )
import Test.UtilsTest (test)

returnTest :: IO Bool
returnTest =
  let cases =
        [ (Return (Literal "0" Int), "return 0;"),
          (Return (Val "x"), "return x;"),
          (Return (Infix (Literal "0" Int) Add (Literal "0" Int)), "return 0+0;"),
          (Return (Infix (Val "x") Add (Val "y")), "return x+y;"),
          (Return (Prefix Not (Val "x")), "return !x;")
        ]
   in test cases "Return"
