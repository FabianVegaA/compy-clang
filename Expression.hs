module Expression where

import Data.List (intercalate)
import Data.Map (Map, (!))
import qualified Data.Map as Map

builtins :: Map String String
builtins = Map.fromList [("print", "printf")]

data Type = Int | Bool | String | Void

instance Show Type where
  show Int = "int"
  show Bool = "char"
  show String = "char*"
  show Void = "void"

data Operator = Add | Sub | Mul | Div | Mod | Pow | And | Or | Eq | Neq | Lt | Gt | Leq | Geq

instance Show Operator where
  show Add = "+"
  show Sub = "-"
  show Mul = "*"
  show Div = "/"
  show Mod = "%"
  show Pow = "^"
  show And = "&&"
  show Or = "||"
  show Eq = "=="
  show Neq = "!="
  show Lt = "<"
  show Gt = ">"
  show Leq = "<="
  show Geq = ">="

data PrefixOperator = Neg | Not

instance Show PrefixOperator where
  show Neg = "-"
  show Not = "!"

data Expression
  = Val
      { identifier :: String
      }
  | Infix
      { left :: Expression,
        operator :: Operator,
        right :: Expression
      }
  | Prefix
      { prefix :: PrefixOperator,
        right :: Expression
      }
  | Return {return_value :: Expression}
  | Call
      { identifier :: String,
        arguments_call :: [Expression]
      }
  | Literal {literal :: String, type_value :: Type}
  | Function
      { identifier :: String,
        arguments :: [(String, Type)],
        type_return :: Type,
        block :: Expression
      }
  | Block {expression :: [Expression]}
  | Program {expression :: [Expression]}
  | If
      { condition :: Expression,
        block_if :: Expression,
        block_else :: Maybe Expression,
        elifs :: Maybe [Expression]
      }
  | Elif {condition :: Expression, block :: Expression}
  | While
      { condition :: Expression,
        block :: Expression
      }
  | For {val :: Expression, iterator :: Expression, block :: Expression}
  | Break
  | Continue
  | Assign
      { identifier :: String,
        value :: Expression,
        type_value :: Type
      }

instance Show Expression where
  show (Val identifier) = identifier
  show (Infix left operator right) = unwords [show left, show operator, show right]
  show (Prefix operator right) = show operator ++ show right
  show (Return return_value) = unwords ["return", show return_value]
  show (Call identifier arguments_call) =
    let args = intercalate ", " $ map show arguments_call
        identifier' =
          if Map.member identifier builtins
            then builtins ! identifier
            else identifier
     in identifier' ++ "(" ++ args ++ ")"
  show (Literal literal type_value) = case type_value of
    String -> "\"" ++ literal ++ "\""
    Void -> "null"
    _ -> literal
  show (Function identifier arguments type_return block) =
    let args =
          intercalate
            ","
            (map (\(name, type_value) -> show type_value ++ " " ++ name) arguments)
        type_return' = if identifier == "main" then "int" else show type_return
     in type_return' ++ " " ++ identifier ++ "(" ++ args ++ ")" ++ show block
  show (Block expression) =
    case expression of
      [exp] -> "{" ++ show exp ++ ";" ++ "}"
      _ ->
        let expressions = map show expression
         in "{" ++ intercalate ";" expressions ++ ";" ++ "}"
  show (If condition@Infix {} block_if@Block {} block_else elifs) =
    let condition' = show condition
        block_if' = show block_if
        block_else' = case block_else of
          Just block@Block {} -> "else" ++ show block
          Just _ -> error "block_else must be a block"
          _ -> ""
        elifs' = case elifs of
          Just elifs -> mconcat $ do
            elif@(Elif condition@Infix {} block@Block {}) <- elifs
            pure $ show elif
          _ -> ""
     in "if (" ++ condition' ++ ")" ++ block_if' ++ elifs' ++ block_else'
  show (Elif condition@Infix {} block@Block {}) =
    unwords ["else if (", show condition, ")", show block]
  show (While condition@Infix {} block@Block {}) =
    unwords ["while (", show condition, ")", show block]
  show (For val iterator block@Block {}) = undefined -- TODO: implement iterator translate in C
  show Break = "break"
  show Continue = "continue"
  show (Assign identifier value type_value) =
    unwords [show type_value, identifier, "=", show value]
  show (Program expression) =
    let standard_libs = ["stdio.h", "stdlib.h", "string.h"]
        imports = unlines $ map ((++ ">") . ("#include <" ++)) standard_libs
     in imports ++ unlines (map show expression)
  show _ = error "Not found expression to translate"
