import Expression
  ( Expression
      ( Assign,
        Block,
        Call,
        Declare,
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
                [ Declare "x" (Infix (Literal "1" Int) Add (Literal "1" Int)) Int,
                  Call "print" [Literal "%d" String, Call "fibonacci" [Literal "7" Int]]
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
