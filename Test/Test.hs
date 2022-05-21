import Control.Monad (void)
import Test.IfTest (ifTest)
import Test.InfixTest (infixTest)
import Test.PrefixTest (prefixTest)
import Test.ValTest (valTest)

main :: IO ()
main = do
  results <- executeTests [ifTest, valTest, infixTest, prefixTest]
  if and results
    then putStrLn "All tests passed!"
    else putStrLn "Some tests failed!"

executeTests :: [IO Bool] -> IO [Bool]
executeTests = mapM (>>= return)
