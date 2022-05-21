module Test.FunctionTest where

import Expression
  ( Expression
      ( Block,
        Call,
        Function,
        If,
        Infix,
        Literal,
        Return,
        Val
      ),
    Operator (Add, Leq, Sub),
    Type (Int),
  )
import Test.UtilsTest (test)

functionTest :: IO Bool
functionTest =
  let cases =
        [ (Function "f" [("x", Int)] Int (Block [Return (Val "x")]), "int f(int x){return x;}"),
          ( Function
              "fibonacci"
              [("x", Int)]
              Int
              ( Block
                  [ If (Infix (Val "x") Leq (Literal "1" Int)) (Block [Return (Literal "1" Int)]) Nothing Nothing,
                    Return (Infix (Call "fibonacci" [Infix (Val "x") Sub (Literal "1" Int)]) Add (Call "fibonacci" [Infix (Val "x") Sub (Literal "2" Int)]))
                  ]
              ),
            "int fibonacci(int x){if(x<=1){return 1;};return fibonacci(x-1)+fibonacci(x-2);;}"
          )
        ]
   in test cases "Function"
