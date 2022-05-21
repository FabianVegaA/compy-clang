{-# LANGUAGE LambdaCase #-}

module Test.UtilsTest where

import Data.Either (isRight)
import Expression (Expression)

checker :: Expression -> String -> Bool
checker exp expected = show exp == expected

test :: [(Expression, String)] -> String -> IO Bool
test cases nameTest = do
  let results =
        zipWith
          ( curry
              ( \(i, (exp, expected)) ->
                  if checker exp expected
                    then Right $ "  " ++ show i ++ ": OK"
                    else Left $ "  " ++ show i ++ ": FAIL\n Expected: " ++ expected ++ "\n Got:      " ++ show exp
              )
          )
          [1 ..]
          cases
  putStrLn $ "Test " ++ nameTest ++ ": " ++ show (length results) ++ " tests"
  mapM_
    ( \case
        Left err -> putStrLn err
        Right ok -> putStrLn ok
    )
    results
  return $ all isRight results
