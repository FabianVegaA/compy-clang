module Translate where

import Data.List (intercalate)
import Expression (Expression (Function, Program))

translateToCLang :: Expression -> String -> IO String
translateToCLang program@(Program expressions) file_path =
  do
    writeFile "headers.h" headers
    let translated = "#include \"headers.h\"\n#include \"utils.h\"\n" ++ show program
    writeFile "main.c" translated
    return translated
  where
    firms = map genFirm $ filter isFunction expressions
    headers = "#ifndef HEADERS_H\n#define HEADERS_H\n\n" ++ intercalate "\n" firms ++ "\n#endif"
translateToCLang _ _ = error "Not implemented"

isFunction :: Expression -> Bool
isFunction Function {} = True
isFunction _ = False

genFirm :: Expression -> [Char]
genFirm (Function identifier arguments type_return _) =
  let args = intercalate ", " $ map (\(arg, type_arg) -> show type_arg ++ " " ++ arg) arguments
      type_return' = case identifier of
        "main" -> "int"
        _ -> show type_return
   in type_return' ++ " " ++ identifier ++ "(" ++ args ++ ");"
genFirm _ = error "Not a function"
