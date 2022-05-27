module Lexer where

data Token = Token
  { tokenType :: TokenType,
    tokenValue :: String
  }

data TokenType
  = Int
  | Float
  | String
  | Identifier
