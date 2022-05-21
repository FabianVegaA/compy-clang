module Test.LiteralTest where

import Test.UtilsTest (test)
import Expression

literalTest :: IO Bool
literalTest =
  let cases =
        [
            (Literal "1" Int, "1")
        ,   (Literal "1.0" Float, "1.0")
        ,   (Literal "abc" String, "\"abc\"")
        ]
   in test cases "Literal"
