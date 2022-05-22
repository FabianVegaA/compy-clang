module Builtin where

import Expression (Expression)

showBuiltin :: String -> [Expression] -> String
showBuiltin "range" args = showRange args
showBuiltin _ _ = error "showBuiltin: unknown builtin"

showRange :: [Expression] -> String
showRange [end] =
  mconcat
    [ "struct gen *g=range(0,",
      show end,
      ",1,NULL);"
    ]
showRange [start, end] =
  mconcat
    [ "struct gen *g=range(",
      show start,
      ",",
      show end,
      ",1,NULL);"
    ]
showRange [start, end, step] =
  mconcat
    [ "struct gen *g=range(",
      show start,
      ",",
      show end,
      ",",
      show step,
      ",NULL);"
    ]
showRange _ = error "showRange: invalid number of arguments"
