module Test.ShowExpressionTests.ValTest where

import Expression ( Expression(Val) )
import Test.UtilsTest (test)

valTest :: IO Bool
valTest =
  let cases =
        [ (Val "a", "a"),
          (Val "var", "var"),
          (Val "var123", "var123")
        ]
   in test cases "Val"
