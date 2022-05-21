module Test.WhileTest where

import Expression
  ( Expression (Assign, Block, Infix, Literal, Val, While),
    Operator (Add, Eq),
    Type (Int),
  )
import Test.UtilsTest (test)

whileTest :: IO Bool
whileTest =
  let cases =
        [ ( While
              (Literal "1" Int)
              ( Block
                  [ Assign "x" (Infix (Val "x") Add (Literal "1" Int))
                  ]
              ),
            "while(1){x=x+1;}"
          ),
          ( While
              (Infix (Val "x") Eq (Literal "10" Int))
              ( Block
                  [ Assign "x" (Infix (Val "x") Add (Literal "1" Int))
                  ]
              ),
            "while(x==10){x=x+1;}"
          )
        ]
   in test cases "While"
