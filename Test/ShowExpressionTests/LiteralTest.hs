module Test.ShowExpressionTests.LiteralTest where

import Expression
  ( Expression (Literal),
    Type (Float, Int, String),
  )
import Test.UtilsTest (test)

literalTest :: IO Bool
literalTest =
  let cases =
        [ (Literal "1" Int, "1"),
          (Literal "1.0" Float, "1.0"),
          (Literal "abc" String, "\"abc\"")
        ]
   in test cases "Literal"
