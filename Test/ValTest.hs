module Test.ValTest where

import Expression
import Test.UtilsTest (test)

valTest :: IO Bool
valTest =
  let cases =
        [ (Val "a", "a"),
          (Val "var", "var"),
          (Val "var123", "var123")
        ]
   in test cases "Val"
