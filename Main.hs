import Expression
  ( Expression
      ( Assign,
        Block,
        Call,
        Elif,
        Function,
        If,
        Infix,
        Literal,
        Program,
        Return
      ),
    Operator (Add, Eq),
    Type (Int, String, Void),
  )
import Translate (translateToCLang)

main :: IO ()
main = do
  let program =
        Program
          [ Function "main" [] Void $
              Block
                [ Assign "x" (Infix (Literal "1" Int) Add (Literal "1" Int)) Int,
                  Call "print" [Literal "%s" String, Call "oneIsZero" []]
                ],
            Function "oneIsZero" [] String $
              Block
                [ If
                    (Infix (Literal "1" Int) Eq (Literal "0" Int))
                    (Block [Return (Literal "Is equal" String)])
                    (Just (Block [Return (Literal "Is not equal" String)]))
                    ( Just
                        [ Elif
                            (Infix (Literal "2" Int) Eq (Literal "0" Int))
                            (Block [Return (Literal "Is not equal" String)])
                        ]
                    )
                ]
          ]
  translated <- translateToCLang program "main.c"
  putStr translated
