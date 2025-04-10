

fibonacci :: Int -> Int
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n-2) + fibonacci (n-1)

main :: IO ()
main = do
    nStr <- getLine
    let n = (read nStr :: Int)
    print(fibonacci n)
