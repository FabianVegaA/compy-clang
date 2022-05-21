module Test.IfTest where

import Expression
  ( Expression (Block, Elif, If, Infix, Literal, Return),
    Operator (Eq),
    Type (Int, String),
  )
import Test.UtilsTest (test)

ifTest :: IO Bool
ifTest =
  let cases =
        [ ( If
              (Infix (Literal "1" Int) Eq (Literal "0" Int))
              (Block [Return (Literal "Is equal" String)])
              Nothing
              Nothing,
            "if (1 == 0){return \"Is equal\";}"
          ),
          ( If
              (Infix (Literal "1" Int) Eq (Literal "0" Int))
              (Block [Return (Literal "Is equal" String)])
              (Just (Block [Return (Literal "Is not equal" String)]))
              Nothing,
            "if (1 == 0){return \"Is equal\";}else{return \"Is not equal\";}"
          ),
          ( If
              (Infix (Literal "1" Int) Eq (Literal "0" Int))
              (Block [Return (Literal "Is equal" String)])
              (Just (Block [Return (Literal "Is not equal" String)]))
              ( Just
                  [ Elif
                      (Infix (Literal "2" Int) Eq (Literal "0" Int))
                      (Block [Return (Literal "Is not equal" String)])
                  ]
              ),
            "if (1 == 0){return \"Is equal\";}else if ( 2 == 0 ) {return \"Is not equal\";}else{return \"Is not equal\";}"
          ),
          ( If
              (Infix (Literal "1" Int) Eq (Literal "0" Int))
              (Block [Return (Literal "Is equal" String)])
              (Just (Block [Return (Literal "Is not equal" String)]))
              ( Just
                  [ Elif
                      (Infix (Literal "2" Int) Eq (Literal "0" Int))
                      (Block [Return (Literal "Is not equal" String)]),
                    Elif
                      (Infix (Literal "2" Int) Eq (Literal "0" Int))
                      (Block [Return (Literal "Is equal" String)])
                  ]
              ),
            "if (1 == 0){return \"Is equal\";}else if ( 2 == 0 ) {return \"Is not equal\";}else if ( 2 == 0 ) {return \"Is equal\";}else{return \"Is not equal\";}"
          )
        ]
   in test cases "If"
