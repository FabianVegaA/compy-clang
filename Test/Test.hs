import Control.Monad (void)
import Test.ShowExpressionTests.AssignTest (assignTest)
import Test.ShowExpressionTests.CallTest (callTest)
import Test.ShowExpressionTests.DeclareTest (declareTest)
import Test.ShowExpressionTests.ForTest (forTest)
import Test.ShowExpressionTests.FunctionTest (functionTest)
import Test.ShowExpressionTests.IfTest (ifTest)
import Test.ShowExpressionTests.InfixTest (infixTest)
import Test.ShowExpressionTests.LiteralTest (literalTest)
import Test.ShowExpressionTests.PrefixTest (prefixTest)
import Test.ShowExpressionTests.ReturnTest (returnTest)
import Test.ShowExpressionTests.ValTest (valTest)
import Test.ShowExpressionTests.WhileTest (whileTest)

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
