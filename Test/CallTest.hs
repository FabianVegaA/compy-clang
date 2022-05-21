module Test.CallTest where

import Expression
import Test.UtilsTest (test)

callTest :: IO Bool
callTest =
  let cases =
        [ (Call "f" [Val "x"], "f(x)"),
          (Call "f" [Val "x", Val "y"], "f(x, y)"),
          (Call "f" [Val "x", Val "y", Val "z"], "f(x, y, z)")
        ]
   in test cases "Call"
