{-----------------------------------------------------------------------------------------
-------------------------------------- LOTUS SUDOKU  -------------------------------------
------------------------------------------------------------------------------------------
---- Authors: Blaine Harris, Vuong Nguyen -----
---- Assignment: Lotus Sudoku Solver - Project 2
---- Class: EECS 368
---- Due Date: 05/03/16
------------------------------------------------------------------------------------------}

import Data.List.Split
import Data.List

test1 = drawBoard [0,1,0,7,6,0,0,4,0,0,1,0,0,0,0,0,6,0,0,5,0,0,0,0,0,0,0,5,0,0,0,0,0,2,0,2,0,0,0,0,0,0,0,4,0,0,0,0,0]
test2 = drawBoard [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0]
unsolve = drawBoard [0,0,3,7,6,1,4,4,0,5,1,7,0,0,0,2,6,0,4,5,3,1,0,0,2,0,0,5,6,0,7,0,0,2,3,2,3,0,7,6,0,0,0,4,5,6,1,7,0]							  

main = do
  putStrLn $show (lotusSolver test1)
  
  
  
--pre: take in an array of size 49
--post: break it into 2D array with row and col indices.
drawBoard :: [Int] -> [[Int]]
drawBoard xs = chunksOf 7 xs


{----------------------------------------------------------------------------------------------------------
--------------------------------------------------SOLVER functions-----------------------------------------
------------------------------------------------------------------------------------------------------------}

--pre: Take in the board
--post: call the solver to solve and return the solution
lotusSolver:: [[Int]] -> [Int]
lotusSolver board = concat (solvedBoard)
   where solvedBoard = solver 0 0 board (getPossibles 0 0 board)
   
   
--pre: Take in the row, col, the initial board, the possible values 
--post: returns the solved board  
solver:: Int ->Int -> [[Int]] ->[Int] -> [[Int]]
solver 6 6 board [] = [[]]
solver 6 6 board (x:[]) = insertToBoard 6 6 board x 
solver 6 6 board (x:_) = [[]]
solver row col board [] = if board!!row!!col > 0 then solver (nextRow row col board) (nextCol row col board) board (getPossibles (nextRow row col board) (nextCol row col board) board) else [[]]
solver row col board (x:xs) 
   |solvedNext == [[]] = solver row col board xs
   |otherwise = solvedNext
   where { solvedNext = solverNext row col (insertToBoard row col board x) ;
		   solverNext row col board = solver (nextRow row col board) (nextCol row col board) board (getPossibles (nextRow row col board) (nextCol row col board) board)
         } 


{--pre: take in row, col, the board 
--post: return the next empty slot (row, col) -}

nextRow:: Int -> Int -> [[Int]] -> Int		 
nextRow row col board = (fst (getNextEmpty row col board))

nextCol:: Int -> Int -> [[Int]] -> Int
nextCol row col board = (snd (getNextEmpty row col board)) 

getNextEmpty:: Int -> Int -> [[Int]] -> (Int,Int)
getNextEmpty row col board 
   |row == 6 && col == 6  = (6,6)
   |board!!(fst (nextIndex row col))!!(snd(nextIndex row col)) == 0  = nextIndex row col
   |otherwise = getNextEmpty (fst (nextIndex row col)) (snd(nextIndex row col)) board
   where nextIndex row col = if (col==6) then (row+1,0) else (row,col+1)


--pre: Take in the row&col position, the value and the board
--post: return the updated board
insertToBoard:: Int -> Int -> [[Int]] -> Int -> [[Int]]
insertToBoard row col board value = (take row board) ++ [(take col getCol)++ [value]++ (drop (col+1) getCol)] ++ (drop (row+1) board)
   where getCol = board!!row
--------------------------------------------------------------------------------------------------  
  
  
  
  
  
{------------------------------------------------CHECKERS-----------------------------------------
--------------------------------------------------------------------------------------------------
-- Checker functions
-- Check for duplicate and valid values from 1 to 7
-- MAIN function: isSolved returns True if the board is solved
--------------------------------------------------------------------------------------------------}

--pre: Take in the board
--Use isValid to check all the rings and arcs
--post: true if the board is solved
isSolved:: [[Int]] -> Bool
isSolved board = if ((isValid 0 0 board)&&(isValid 0 1 board)&&(isValid 0 2 board)&&(isValid 0 3 board)&&(isValid 0 4 board)&&(isValid 0 5 board)&&(isValid 0 6 board)&&
                     (isValid 1 0 board)&&(isValid 2 0 board)&&(isValid 3 0 board)&&(isValid 4 0 board)&&(isValid 5 0 board)&&(isValid 6 0 board))
                 then True
				 else False

--pre: take in the row&col position, the board and the new value
--Check ring and both arcs if the new value is valid (no duplicate and 1-7)
--post: return True if the value is valid, False if it's duplicate or not in range
isValid:: Int -> Int -> [[Int]] -> Bool
isValid row col board = if ((isDuplicate left)|| (isDuplicate right)|| (isDuplicate circle)||
                           (not (inRange left)) || (not (inRange right))||(not (inRange circle)))
						then False
						else True
						   where { left = getLeftArc row col board ;
						         right = getRightArc row col board ;
							     circle = getCircle row board }      
								 
--pre: take in a list of Int length 7 
--post: return true if one of the value occurs twice, false if each val is unique.
isDuplicate:: [Int] -> Bool
isDuplicate xs = if (length xs == length (nub xs)) then False else True

--pre: Take in a list (a ring or an arc)
--post: True if the value is from 1 to 7
inRange:: [Int] -> Bool
inRange xs = if ((length (filter (>7) xs)) > 0) || ((length (filter (<=0) xs)) > 0) 		
             then False
             else True 		
			 
-------------------------------------------------------------------------------------------------------		






{-------------------------------------------GETTER functions-------------------------------------------
-------------------------------------------------------------------------------------------------------
-- Getters
-- Get the left arc, right arc and rings
-- Get Possibles values of an entry
-------------------------------------------------------------------------------------------------------}	

--pre: take in the row [Int] and col [Int] numbers, the board [[Int]]
--post: return all the possible values for that index [Int]
getPossibles :: Int -> Int -> [[Int]] -> [Int]
getPossibles row col board =  if board!!row!!col > 0 then [] else [1,2,3,4,5,6,7] \\ (filter (\n->n /= 0) ((getLeftArc row col board) ++ (getRightArc row col board) ++ (getCircle row board)))

--pre: take in the row and column numbers and the board 2D array
--post: returns the value at index (row,column)
getVal:: Int -> Int -> [[Int]] -> Int
getVal row col board = (board!!row)!!col 


--pre: take in the row number Int, the board [[Int]]
--post: return a circle [Int] related to the row number
getCircle :: Int -> [[Int]] -> [Int]
getCircle row board
  |row==6 = (board!!6!!0):(board!!6!!1):(board!!6!!2):(board!!6!!3):(board!!6!!4):(board!!6!!5):(board!!6!!6):[]
  |row==5 = (board!!5!!0):(board!!5!!1):(board!!5!!2):(board!!5!!3):(board!!5!!4):(board!!5!!5):(board!!5!!6):[]
  |row==4 = (board!!4!!0):(board!!4!!1):(board!!4!!2):(board!!4!!3):(board!!4!!4):(board!!4!!5):(board!!4!!6):[]
  |row==3 = (board!!3!!0):(board!!3!!1):(board!!3!!2):(board!!3!!3):(board!!3!!4):(board!!3!!5):(board!!3!!6):[]
  |row==2 = (board!!2!!0):(board!!2!!1):(board!!2!!2):(board!!2!!3):(board!!2!!4):(board!!2!!5):(board!!2!!6):[]
  |row==1 = (board!!1!!0):(board!!1!!1):(board!!1!!2):(board!!1!!3):(board!!1!!4):(board!!1!!5):(board!!1!!6):[]
  |row==0 = (board!!0!!0):(board!!0!!1):(board!!0!!2):(board!!0!!3):(board!!0!!4):(board!!0!!5):(board!!0!!6):[]
  |otherwise = [0,0,0,0,0,0,0]
  
  
--pre: take in the row and col numbers, the board
--post: return a left arc [Int] associated with the index (row,col)
getLeftArc:: Int -> Int -> [[Int]] -> [Int]
getLeftArc row col board
  |row==0 && col==6 = (board!!0!!6):(board!!1!!6):(board!!2!!0):(board!!3!!0):(board!!4!!1):(board!!5!!1):(board!!6!!2):[]
  |row==0 && col==5 = (board!!0!!5):(board!!1!!5):(board!!2!!6):(board!!3!!6):(board!!4!!0):(board!!5!!0):(board!!6!!1):[]
  |row==0 && col==4 = (board!!0!!4):(board!!1!!4):(board!!2!!5):(board!!3!!5):(board!!4!!6):(board!!5!!6):(board!!6!!0):[]
  |row==0 && col==3 = (board!!0!!3):(board!!1!!3):(board!!2!!4):(board!!3!!4):(board!!4!!5):(board!!5!!5):(board!!6!!6):[]
  |row==0 && col==2 = (board!!0!!2):(board!!1!!2):(board!!2!!3):(board!!3!!3):(board!!4!!4):(board!!5!!4):(board!!6!!5):[]
  |row==0 && col==1 = (board!!0!!1):(board!!1!!1):(board!!2!!2):(board!!3!!2):(board!!4!!3):(board!!5!!3):(board!!6!!4):[]
  |row==0 && col==0 = (board!!0!!0):(board!!1!!0):(board!!2!!1):(board!!3!!1):(board!!4!!2):(board!!5!!2):(board!!6!!3):[]
  |row==1 && col==6 = (board!!0!!6):(board!!1!!6):(board!!2!!0):(board!!3!!0):(board!!4!!1):(board!!5!!1):(board!!6!!2):[]
  |row==1 && col==5 = (board!!0!!5):(board!!1!!5):(board!!2!!6):(board!!3!!6):(board!!4!!0):(board!!5!!0):(board!!6!!1):[]
  |row==1 && col==4 = (board!!0!!4):(board!!1!!4):(board!!2!!5):(board!!3!!5):(board!!4!!6):(board!!5!!6):(board!!6!!0):[]
  |row==1 && col==3 = (board!!0!!3):(board!!1!!3):(board!!2!!4):(board!!3!!4):(board!!4!!5):(board!!5!!5):(board!!6!!6):[]
  |row==1 && col==2 = (board!!0!!2):(board!!1!!2):(board!!2!!3):(board!!3!!3):(board!!4!!4):(board!!5!!4):(board!!6!!5):[]
  |row==1 && col==1 = (board!!0!!1):(board!!1!!1):(board!!2!!2):(board!!3!!2):(board!!4!!3):(board!!5!!3):(board!!6!!4):[]
  |row==1 && col==0 = (board!!0!!0):(board!!1!!0):(board!!2!!1):(board!!3!!1):(board!!4!!2):(board!!5!!2):(board!!6!!3):[]
  |row==2 && col==6 = (board!!0!!5):(board!!1!!5):(board!!2!!6):(board!!3!!6):(board!!4!!0):(board!!5!!0):(board!!6!!1):[]
  |row==2 && col==5 = (board!!0!!4):(board!!1!!4):(board!!2!!5):(board!!3!!5):(board!!4!!6):(board!!5!!6):(board!!6!!0):[]
  |row==2 && col==4 = (board!!0!!3):(board!!1!!3):(board!!2!!4):(board!!3!!4):(board!!4!!5):(board!!5!!5):(board!!6!!6):[]
  |row==2 && col==3 = (board!!0!!2):(board!!1!!2):(board!!2!!3):(board!!3!!3):(board!!4!!4):(board!!5!!4):(board!!6!!5):[]
  |row==2 && col==2 = (board!!0!!1):(board!!1!!1):(board!!2!!2):(board!!3!!2):(board!!4!!3):(board!!5!!3):(board!!6!!4):[]
  |row==2 && col==1 = (board!!0!!0):(board!!1!!0):(board!!2!!1):(board!!3!!1):(board!!4!!2):(board!!5!!2):(board!!6!!3):[]
  |row==2 && col==0 = (board!!0!!6):(board!!1!!6):(board!!2!!0):(board!!3!!0):(board!!4!!1):(board!!5!!1):(board!!6!!2):[]
  |row==3 && col==6 = (board!!0!!5):(board!!1!!5):(board!!2!!6):(board!!3!!6):(board!!4!!0):(board!!5!!0):(board!!6!!1):[]
  |row==3 && col==5 = (board!!0!!4):(board!!1!!4):(board!!2!!5):(board!!3!!5):(board!!4!!6):(board!!5!!6):(board!!6!!0):[]
  |row==3 && col==4 = (board!!0!!3):(board!!1!!3):(board!!2!!4):(board!!3!!4):(board!!4!!5):(board!!5!!5):(board!!6!!6):[]
  |row==3 && col==3 = (board!!0!!2):(board!!1!!2):(board!!2!!3):(board!!3!!3):(board!!4!!4):(board!!5!!4):(board!!6!!5):[]
  |row==3 && col==2 = (board!!0!!1):(board!!1!!1):(board!!2!!2):(board!!3!!2):(board!!4!!3):(board!!5!!3):(board!!6!!4):[]
  |row==3 && col==1 = (board!!0!!0):(board!!1!!0):(board!!2!!1):(board!!3!!1):(board!!4!!2):(board!!5!!2):(board!!6!!3):[]
  |row==3 && col==0 = (board!!0!!6):(board!!1!!6):(board!!2!!0):(board!!3!!0):(board!!4!!1):(board!!5!!1):(board!!6!!2):[]
  |row==4 && col==6 = (board!!0!!4):(board!!1!!4):(board!!2!!5):(board!!3!!5):(board!!4!!6):(board!!5!!6):(board!!6!!0):[]
  |row==4 && col==5 = (board!!0!!3):(board!!1!!3):(board!!2!!4):(board!!3!!4):(board!!4!!5):(board!!5!!5):(board!!6!!6):[]
  |row==4 && col==4 = (board!!0!!2):(board!!1!!2):(board!!2!!3):(board!!3!!3):(board!!4!!4):(board!!5!!4):(board!!6!!5):[]
  |row==4 && col==3 = (board!!0!!1):(board!!1!!1):(board!!2!!2):(board!!3!!2):(board!!4!!3):(board!!5!!3):(board!!6!!4):[]
  |row==4 && col==2 = (board!!0!!0):(board!!1!!0):(board!!2!!1):(board!!3!!1):(board!!4!!2):(board!!5!!2):(board!!6!!3):[]
  |row==4 && col==1 = (board!!0!!6):(board!!1!!6):(board!!2!!0):(board!!3!!0):(board!!4!!1):(board!!5!!1):(board!!6!!2):[]
  |row==4 && col==0 = (board!!0!!5):(board!!1!!5):(board!!2!!6):(board!!3!!6):(board!!4!!0):(board!!5!!0):(board!!6!!1):[]
  |row==5 && col==6 = (board!!0!!4):(board!!1!!4):(board!!2!!5):(board!!3!!5):(board!!4!!6):(board!!5!!6):(board!!6!!0):[]
  |row==5 && col==5 = (board!!0!!3):(board!!1!!3):(board!!2!!4):(board!!3!!4):(board!!4!!5):(board!!5!!5):(board!!6!!6):[]
  |row==5 && col==4 = (board!!0!!2):(board!!1!!2):(board!!2!!3):(board!!3!!3):(board!!4!!4):(board!!5!!4):(board!!6!!5):[]
  |row==5 && col==3 = (board!!0!!1):(board!!1!!1):(board!!2!!2):(board!!3!!2):(board!!4!!3):(board!!5!!3):(board!!6!!4):[]
  |row==5 && col==2 = (board!!0!!0):(board!!1!!0):(board!!2!!1):(board!!3!!1):(board!!4!!2):(board!!5!!2):(board!!6!!3):[]
  |row==5 && col==1 = (board!!0!!6):(board!!1!!6):(board!!2!!0):(board!!3!!0):(board!!4!!1):(board!!5!!1):(board!!6!!2):[]
  |row==5 && col==0 = (board!!0!!5):(board!!1!!5):(board!!2!!6):(board!!3!!6):(board!!4!!0):(board!!5!!0):(board!!6!!1):[]
  |row==6 && col==6 = (board!!0!!3):(board!!1!!3):(board!!2!!4):(board!!3!!4):(board!!4!!5):(board!!5!!5):(board!!6!!6):[]
  |row==6 && col==5 = (board!!0!!2):(board!!1!!2):(board!!2!!3):(board!!3!!3):(board!!4!!4):(board!!5!!4):(board!!6!!5):[]
  |row==6 && col==4 = (board!!0!!1):(board!!1!!1):(board!!2!!2):(board!!3!!2):(board!!4!!3):(board!!5!!3):(board!!6!!4):[]
  |row==6 && col==3 = (board!!0!!0):(board!!1!!0):(board!!2!!1):(board!!3!!1):(board!!4!!2):(board!!5!!2):(board!!6!!3):[]
  |row==6 && col==2 = (board!!0!!6):(board!!1!!6):(board!!2!!0):(board!!3!!0):(board!!4!!1):(board!!5!!1):(board!!6!!2):[]
  |row==6 && col==1 = (board!!0!!5):(board!!1!!5):(board!!2!!6):(board!!3!!6):(board!!4!!0):(board!!5!!0):(board!!6!!1):[]
  |row==6 && col==0 = (board!!0!!4):(board!!1!!4):(board!!2!!5):(board!!3!!5):(board!!4!!6):(board!!5!!6):(board!!6!!0):[]
  |otherwise = [0,0,0,0,0,0,0]


--pre: take in the row and col numbers, the board
--post: return a right arc [Int] associated with the index (row,col)
getRightArc:: Int -> Int -> [[Int]] -> [Int]
getRightArc row col board
  |row==0 && col==6 = (board!!0!!6):(board!!1!!5):(board!!2!!5):(board!!3!!4):(board!!4!!4):(board!!5!!3):(board!!6!!3):[]
  |row==0 && col==5 = (board!!0!!5):(board!!1!!4):(board!!2!!4):(board!!3!!3):(board!!4!!3):(board!!5!!2):(board!!6!!2):[]
  |row==0 && col==4 = (board!!0!!4):(board!!1!!3):(board!!2!!3):(board!!3!!2):(board!!4!!2):(board!!5!!1):(board!!6!!1):[]
  |row==0 && col==3 = (board!!0!!3):(board!!1!!2):(board!!2!!2):(board!!3!!1):(board!!4!!1):(board!!5!!0):(board!!6!!0):[]
  |row==0 && col==2 = (board!!0!!2):(board!!1!!1):(board!!2!!1):(board!!3!!0):(board!!4!!0):(board!!5!!6):(board!!6!!6):[]
  |row==0 && col==1 = (board!!0!!1):(board!!1!!0):(board!!2!!0):(board!!3!!6):(board!!4!!6):(board!!5!!5):(board!!6!!5):[]
  |row==0 && col==0 = (board!!0!!0):(board!!1!!6):(board!!2!!6):(board!!3!!5):(board!!4!!5):(board!!5!!4):(board!!6!!4):[]
  |row==1 && col==6 = (board!!0!!0):(board!!1!!6):(board!!2!!6):(board!!3!!5):(board!!4!!5):(board!!5!!4):(board!!6!!4):[]
  |row==1 && col==5 = (board!!0!!6):(board!!1!!5):(board!!2!!5):(board!!3!!4):(board!!4!!4):(board!!5!!3):(board!!6!!3):[]
  |row==1 && col==4 = (board!!0!!5):(board!!1!!4):(board!!2!!4):(board!!3!!3):(board!!4!!3):(board!!5!!2):(board!!6!!2):[]
  |row==1 && col==3 = (board!!0!!4):(board!!1!!3):(board!!2!!3):(board!!3!!2):(board!!4!!2):(board!!5!!1):(board!!6!!1):[]
  |row==1 && col==2 = (board!!0!!3):(board!!1!!2):(board!!2!!2):(board!!3!!1):(board!!4!!1):(board!!5!!0):(board!!6!!0):[]
  |row==1 && col==1 = (board!!0!!2):(board!!1!!1):(board!!2!!1):(board!!3!!0):(board!!4!!0):(board!!5!!6):(board!!6!!6):[]
  |row==1 && col==0 = (board!!0!!1):(board!!1!!0):(board!!2!!0):(board!!3!!6):(board!!4!!6):(board!!5!!5):(board!!6!!5):[]
  |row==2 && col==6 = (board!!0!!0):(board!!1!!6):(board!!2!!6):(board!!3!!5):(board!!4!!5):(board!!5!!4):(board!!6!!4):[]
  |row==2 && col==5 = (board!!0!!6):(board!!1!!5):(board!!2!!5):(board!!3!!4):(board!!4!!4):(board!!5!!3):(board!!6!!3):[]
  |row==2 && col==4 = (board!!0!!5):(board!!1!!4):(board!!2!!4):(board!!3!!3):(board!!4!!3):(board!!5!!2):(board!!6!!2):[]
  |row==2 && col==3 = (board!!0!!4):(board!!1!!3):(board!!2!!3):(board!!3!!2):(board!!4!!2):(board!!5!!1):(board!!6!!1):[]
  |row==2 && col==2 = (board!!0!!3):(board!!1!!2):(board!!2!!2):(board!!3!!1):(board!!4!!1):(board!!5!!0):(board!!6!!0):[]
  |row==2 && col==1 = (board!!0!!2):(board!!1!!1):(board!!2!!1):(board!!3!!0):(board!!4!!0):(board!!5!!6):(board!!6!!6):[]
  |row==2 && col==0 = (board!!0!!1):(board!!1!!0):(board!!2!!0):(board!!3!!6):(board!!4!!6):(board!!5!!5):(board!!6!!5):[]
  |row==3 && col==6 = (board!!0!!1):(board!!1!!0):(board!!2!!0):(board!!3!!6):(board!!4!!6):(board!!5!!5):(board!!6!!5):[]
  |row==3 && col==5 = (board!!0!!0):(board!!1!!6):(board!!2!!6):(board!!3!!5):(board!!4!!5):(board!!5!!4):(board!!6!!4):[]
  |row==3 && col==4 = (board!!0!!6):(board!!1!!5):(board!!2!!5):(board!!3!!4):(board!!4!!4):(board!!5!!3):(board!!6!!3):[]
  |row==3 && col==3 = (board!!0!!5):(board!!1!!4):(board!!2!!4):(board!!3!!3):(board!!4!!3):(board!!5!!2):(board!!6!!2):[]
  |row==3 && col==2 = (board!!0!!4):(board!!1!!3):(board!!2!!3):(board!!3!!2):(board!!4!!2):(board!!5!!1):(board!!6!!1):[]
  |row==3 && col==1 = (board!!0!!3):(board!!1!!2):(board!!2!!2):(board!!3!!1):(board!!4!!1):(board!!5!!0):(board!!6!!0):[]
  |row==3 && col==0 = (board!!0!!2):(board!!1!!1):(board!!2!!1):(board!!3!!0):(board!!4!!0):(board!!5!!6):(board!!6!!6):[]
  |row==4 && col==6 = (board!!0!!1):(board!!1!!0):(board!!2!!0):(board!!3!!6):(board!!4!!6):(board!!5!!5):(board!!6!!5):[]
  |row==4 && col==5 = (board!!0!!0):(board!!1!!6):(board!!2!!6):(board!!3!!5):(board!!4!!5):(board!!5!!4):(board!!6!!4):[]
  |row==4 && col==4 = (board!!0!!6):(board!!1!!5):(board!!2!!5):(board!!3!!4):(board!!4!!4):(board!!5!!3):(board!!6!!3):[]
  |row==4 && col==3 = (board!!0!!5):(board!!1!!4):(board!!2!!4):(board!!3!!3):(board!!4!!3):(board!!5!!2):(board!!6!!2):[]
  |row==4 && col==2 = (board!!0!!4):(board!!1!!3):(board!!2!!3):(board!!3!!2):(board!!4!!2):(board!!5!!1):(board!!6!!1):[]
  |row==4 && col==1 = (board!!0!!3):(board!!1!!2):(board!!2!!2):(board!!3!!1):(board!!4!!1):(board!!5!!0):(board!!6!!0):[]
  |row==4 && col==0 = (board!!0!!2):(board!!1!!1):(board!!2!!1):(board!!3!!0):(board!!4!!0):(board!!5!!6):(board!!6!!6):[]
  |row==5 && col==6 = (board!!0!!2):(board!!1!!1):(board!!2!!1):(board!!3!!0):(board!!4!!0):(board!!5!!6):(board!!6!!6):[]
  |row==5 && col==5 = (board!!0!!1):(board!!1!!0):(board!!2!!0):(board!!3!!6):(board!!4!!6):(board!!5!!5):(board!!6!!5):[]
  |row==5 && col==4 = (board!!0!!0):(board!!1!!6):(board!!2!!6):(board!!3!!5):(board!!4!!5):(board!!5!!4):(board!!6!!4):[]
  |row==5 && col==3 = (board!!0!!6):(board!!1!!5):(board!!2!!5):(board!!3!!4):(board!!4!!4):(board!!5!!3):(board!!6!!3):[]
  |row==5 && col==2 = (board!!0!!5):(board!!1!!4):(board!!2!!4):(board!!3!!3):(board!!4!!3):(board!!5!!2):(board!!6!!2):[]
  |row==5 && col==1 = (board!!0!!4):(board!!1!!3):(board!!2!!3):(board!!3!!2):(board!!4!!2):(board!!5!!1):(board!!6!!1):[]
  |row==5 && col==0 = (board!!0!!3):(board!!1!!2):(board!!2!!2):(board!!3!!1):(board!!4!!1):(board!!5!!0):(board!!6!!0):[]
  |row==6 && col==6 = (board!!0!!2):(board!!1!!1):(board!!2!!1):(board!!3!!0):(board!!4!!0):(board!!5!!6):(board!!6!!6):[]
  |row==6 && col==5 = (board!!0!!1):(board!!1!!0):(board!!2!!0):(board!!3!!6):(board!!4!!6):(board!!5!!5):(board!!6!!5):[]
  |row==6 && col==4 = (board!!0!!0):(board!!1!!6):(board!!2!!6):(board!!3!!5):(board!!4!!5):(board!!5!!4):(board!!6!!4):[]
  |row==6 && col==3 = (board!!0!!6):(board!!1!!5):(board!!2!!5):(board!!3!!4):(board!!4!!4):(board!!5!!3):(board!!6!!3):[]
  |row==6 && col==2 = (board!!0!!5):(board!!1!!4):(board!!2!!4):(board!!3!!3):(board!!4!!3):(board!!5!!2):(board!!6!!2):[]
  |row==6 && col==1 = (board!!0!!4):(board!!1!!3):(board!!2!!3):(board!!3!!2):(board!!4!!2):(board!!5!!1):(board!!6!!1):[]
  |row==6 && col==0 = (board!!0!!3):(board!!1!!2):(board!!2!!2):(board!!3!!1):(board!!4!!1):(board!!5!!0):(board!!6!!0):[]
  |otherwise = [0,0,0,0,0,0,0]

  
  
  
{-- WORK CITATION -------------------------------------------------------------------------------------
-- sudoku.hs from Wynand van Dyk on Github
-- https://gist.github.com/wvandyk/3638996
------------------------------------------------------------------------------------------------------}  