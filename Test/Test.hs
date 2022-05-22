import Control.Monad (void)
import Test.AssignTest (assignTest)
import Test.CallTest (callTest)
import Test.DeclareTest (declareTest)
import Test.FunctionTest (functionTest)
import Test.IfTest (ifTest)
import Test.InfixTest (infixTest)
import Test.LiteralTest (literalTest)
import Test.PrefixTest (prefixTest)
import Test.ReturnTest (returnTest)
import Test.ValTest (valTest)
import Test.WhileTest (whileTest)
import Test.ForTest (forTest)

main :: IO ()
main = do
  results <-
    executeTests
      [ ifTest,
        valTest,
        infixTest,
        prefixTest,
        returnTest,
        callTest,
        literalTest,
        functionTest,
        whileTest,
        assignTest,
        declareTest,
        forTest
      ]
  if and results
    then putStrLn "All tests passed!"
    else putStrLn "Some tests failed!"

executeTests :: [IO Bool] -> IO [Bool]
executeTests = mapM (>>= return)
