module Test.InfixTest where

import Expression
  ( Expression (Infix, Literal),
    Operator
      ( Add,
        And,
        Div,
        Eq,
        Geq,
        Gt,
        Leq,
        Lt,
        Mod,
        Mul,
        Neq,
        Or,
        Pow,
        Sub
      ),
    Type (Int),
  )
import Test.UtilsTest (test)

infixTest :: IO Bool
infixTest =
  let cases =
        [ (Infix (Literal "1" Int) Add (Literal "2" Int), "1+2"),
          (Infix (Literal "1" Int) Sub (Literal "2" Int), "1-2"),
          (Infix (Literal "1" Int) Mul (Literal "2" Int), "1*2"),
          (Infix (Literal "1" Int) Div (Literal "2" Int), "1/2"),
          (Infix (Literal "1" Int) Mod (Literal "2" Int), "1%2"),
          (Infix (Literal "1" Int) Pow (Literal "2" Int), "1^2"),
          (Infix (Literal "1" Int) And (Literal "2" Int), "1&&2"),
          (Infix (Literal "1" Int) Or (Literal "2" Int), "1||2"),
          (Infix (Literal "1" Int) Eq (Literal "2" Int), "1==2"),
          (Infix (Literal "1" Int) Neq (Literal "2" Int), "1!=2"),
          (Infix (Literal "1" Int) Lt (Literal "2" Int), "1<2"),
          (Infix (Literal "1" Int) Leq (Literal "2" Int), "1<=2"),
          (Infix (Literal "1" Int) Gt (Literal "2" Int), "1>2"),
          (Infix (Literal "1" Int) Geq (Literal "2" Int), "1>=2")
        ]
   in test cases "Infix"
