-- EECS 368 HW 11
-- Author: Vuong Nguyen

import Data.List.Split
import Data.List
import Data.Char
import Data.String

--pre: Takes in a character
--post: returns the index of the character (A as 0, B as 1,... Z as 25, "1" as 26, ... 0 as 35)
charToIndex:: Char -> Int
charToIndex c 
	|c == 'A' = 0
	|c == 'B' = 1
	|c == 'C' = 2
	|c == 'D' = 3
	|c == 'E' = 4
	|c == 'F' = 5
	|c == 'G' = 6
	|c == 'H' = 7
	|c == 'I' = 8
	|c == 'J' = 9
	|c == 'K' = 10
	|c == 'L' = 11
	|c == 'M' = 12
	|c == 'N' = 13
	|c == 'O' = 14
	|c == 'P' = 15
	|c == 'Q' = 16
	|c == 'R' = 17
	|c == 'S' = 18
	|c == 'T' = 19
	|c == 'U' = 20
	|c == 'V' = 21
	|c == 'W' = 22
	|c == 'X' = 23
	|c == 'Y' = 24
	|c == 'Z' = 25
	|c == '1' = 26
	|c == '2' = 27
	|c == '3' = 28
	|c == '4' = 29
	|c == '5' = 30
	|c == '6' = 31
	|c == '7' = 32
	|c == '8' = 33
	|c == '9' = 34
	|c == '0' = 35
	|otherwise = 35
	
--pre: the index number Int
--post: retuns the character 
indexToChar:: Int -> Char
indexToChar i
	|i == 0 = 'A'
	|i == 1 = 'B'
	|i == 2 = 'C' 
	|i == 3 = 'D' 
	|i == 4 = 'E' 
	|i == 5 = 'F' 
	|i == 6 = 'G'
	|i == 7 = 'H'
	|i == 8 = 'I' 
	|i == 9 = 'J' 
	|i == 10 = 'K' 
	|i == 11 = 'L' 
	|i == 12 = 'M' 
	|i == 13 = 'N' 
	|i == 14 = 'O' 
	|i == 15 = 'P' 
	|i == 16 = 'Q' 
	|i == 17 = 'R' 
	|i == 18 = 'S' 
	|i == 19 = 'T' 
	|i == 20 = 'U' 
	|i == 21 = 'V' 
	|i == 22 = 'W' 
	|i == 23 = 'X' 
	|i == 24 = 'Y' 
	|i == 25 = 'Z' 
	|i == 26 = '1' 
	|i == 27 = '2' 
	|i == 28 = '3' 
	|i == 29 = '4' 
	|i == 30 = '5' 
	|i == 31 = '6' 
	|i == 32 = '7' 
	|i == 33 = '8' 
	|i == 34 = '9' 
	|i == 35 = '0' 
	|otherwise = '0'

--pre: take in an index and the key
--post: retuns the shifted index
rightShift:: Int -> Int -> Int
rightShift index key 
	|key<0 = 0
	|key>0 = (mod (index + key) 35)

--pre: takes in a message and a key
--use map and lambda function in layers: take the message, convert each bit of char into indices, apply rightShift
--post: return the cipher message
decodeCipher:: String -> Int -> String
decodeCipher str key = map indexToChar (map (\ x -> rightShift x key) (map charToIndex str))
	
main = putStrLn(show(decodeCipher "ABCD" 4))	