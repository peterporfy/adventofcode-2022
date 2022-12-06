module Program where

is :: Int -> String -> Bool
is len str = length(str) == len

only :: String -> Char -> Bool
only str c = length (filter (==c) str) == 1

uniq :: String -> Bool
uniq str = all (only str) str

match :: Int -> String -> Bool
match len str = is len str && uniq str

find :: Int -> (String, Int, String) -> (String, Int)
find len (marker, pos, next:rest)
  | match len marker = (marker, pos)
  | is len marker = find len ((tail marker) ++ [next], pos + 1, rest)
  | otherwise = find len (marker ++ [next], pos + 1, rest)

startOfPacket :: (String) -> (String, Int)
startOfPacket signal = find 4 ("", 0, signal)

startOfMessage :: (String) -> (String, Int)
startOfMessage signal = find 14 ("", 0, signal)

main = do
  signal <- readFile "data"
  print(startOfPacket signal)
  print(startOfMessage signal)
