import Data.List.Split
import Data.List
import Data.Char
import Data.String

fromMorseCode:: String -> String
fromMorseCode str = getString (decrypted (getBit str))

--pre: the input String
--post: list of each bit without break
getBit:: String -> [String]
getBit str = splitOn " " str

--pre: take in a character bit
--post: compare the input and return the decypted alphanumeric character
decyptCheck:: String -> String
decyptCheck str
	|str == ".-" = "A"
	|str == "-..." = "B"
	|str == "-.-." = "C"
	|str == "-.." = "D"
	|str == "." = "E"
	|str == "..-." = "F"
	|str == "--." = "G"
	|str == "...." = "H"
	|str == ".." = "I"
	|str == ".---" = "J"
	|str == "-.-" = "K"
	|str == ".-.." = "L"
	|str == "--" = "M"
	|str == "-." = "N"
	|str == "---" = "O"
	|str == ".--." = "P"
	|str == "--.-" = "Q"
	|str == ".-." = "R"
	|str == "..." = "S"
	|str == "-" = "T"
	|str == "..-" = "U"
	|str == "...-" = "V"
	|str == ".--" = "W"
	|str == "-..-" = "X"
	|str == "-.--" = "Y"
	|str == "--.." = "Z"
	|str == "-----" = "0"
	|str == ".----" = "1"
	|str == "..---" = "2"
	|str == "...--" = "3"
	|str == "....-" = "4"
	|str == "....." = "5"
	|str == "-...." = "6"
	|str == "--..." = "7"
	|str == "---.." = "8"
	|str == "----." = "9"
	|otherwise = "invalid"

--pre: list of string
--post: return a decrypted list
decrypted:: [String] -> [String]
decrypted xs = map decyptCheck xs

--pre: take in a list of string
--post: return a string including all elements
getString:: Show a => [a] -> String
getString [] = ""
getString (x:xs) = (show x) ++ (getString xs)

main = putStrLn (fromMorseCode ".- ----- -...")