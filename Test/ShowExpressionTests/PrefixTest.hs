module Test.ShowExpressionTests.PrefixTest where

import Expression
  ( Expression (Literal, Prefix),
    PrefixOperator (Neg, Not),
    Type (Int),
  )
import Test.UtilsTest (test)

prefixTest :: IO Bool
prefixTest =
  let cases =
        [ (Prefix Neg (Literal "1" Int), "-1"),
          (Prefix Not (Literal "1" Int), "!1")
        ]
   in test cases "Prefix"
