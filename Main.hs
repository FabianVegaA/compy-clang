import Expression
  ( Expression
      ( Assign,
        Block,
        Call,
        Declare,
        For,
        Function,
        If,
        Infix,
        Literal,
        Program,
        Return,
        Val
      ),
    Operator (Add, Leq, Sub),
    Type (Int, String, Void),
  )
import Translate (translateToCLang)

main :: IO ()
main = do
  let program =
        Program
          [ Function "main" [] Void $
              Block
                [ For
                    (Val "i")
                    (Call "range" [Literal "10" Int])
                    (Block [Call "print" [Literal "%d\\n" String, Val "i"]]),
                  Return (Literal "0" Int)
                ],
            Function
              "fibonacci"
              [("x", Int)]
              Int
              ( Block
                  [ If (Infix (Val "x") Leq (Literal "1" Int)) (Block [Return (Literal "1" Int)]) Nothing Nothing,
                    Return (Infix (Call "fibonacci" [Infix (Val "x") Sub (Literal "1" Int)]) Add (Call "fibonacci" [Infix (Val "x") Sub (Literal "2" Int)]))
                  ]
              )
          ]
  translated <- translateToCLang program "main.c"
  putStr translated
