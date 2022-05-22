module Test.ForTest where

import Expression
  ( Expression (Block, Call, For, Literal, Val),
    Type (Int, String),
  )
import Test.UtilsTest (test)

forTest :: IO Bool
forTest =
  let cases =
        [ ( For
              (Val "i")
              (Call "range" [Literal "10" Int])
              ( Block [Call "print" [Literal "%d\\n" String, Val "i"]]
              ),
            "struct gen *g=range(0,10,1,NULL);;int i;do{i=g->next(g);if(i==INT_MAX){break;}printf(\"%d\\n\", i);}while(1);"
          )
        ]
   in test cases "For"
