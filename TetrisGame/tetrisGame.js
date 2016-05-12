﻿﻿//==================================================
// EECS 368 - Project 1: Tetris Game
// Author: Vuong Nguyen
// Date: APR 19th, 2016
//==================================================

tetrisGame = {};
tetrisGame.shape = {};
tetrisGame.currentState = [];
tetrisGame.initialized = false;
tetrisGame.isShapeFalling = false;

//pre:Draw the shape by the leftMost block, the second is the next to the right
//Third block is the next to the right, fourth is the next to the rigt
//The order of priority is left most, highest
//post: add a shape object based of the type

tetrisGame.DrawShape = function(type, leftMost) {
	if(!this.initialized){this.Initialize();}
	this.isShapeFalling = true;
	if(type == 0) {
		this.shape = {'type':type, 'leftMost':leftMost, 'second':leftMost+1, 'third':leftMost+2, 'fourth':leftMost+3};	
	} else if (type ==1) {
		this.shape = {'type':type, 'leftMost':leftMost, 'second':leftMost +1, 'third':leftMost+2, 'fourth':leftMost+11};
	} else if(type ==2) {
		this.shape = {'type':type, 'leftMost':leftMost, 'second':leftMost +1, 'third':leftMost+11, 'fourth':leftMost+12};
	} else if(type ==3) {
		this.shape = {'type':type, 'leftMost':leftMost, 'second':leftMost +1, 'third':leftMost-9, 'fourth':leftMost-8};
	} else if(type ==4) {
		this.shape = {'type':type, 'leftMost':leftMost, 'second':leftMost +1, 'third':leftMost+10, 'fourth':leftMost+11};
	} else if(type ==5) {
		this.shape = {'type':type, 'leftMost':leftMost, 'second':leftMost +10, 'third':leftMost+11, 'fourth':leftMost+12};
	} else if(type ==6) {
		this.shape = {'type':type, 'leftMost':leftMost, 'second':leftMost +1, 'third':leftMost+2, 'fourth':leftMost+10};
	}
}

//pre: DrawShape with type and left most block
//post: Add a shape by its type and position is the left most edge
tetrisGame.AddShape = function(type, position, id) {
	if(!this.initialized){this.Initialize();}
	this.isShapeFalling = true;
	
	if(type==0) {
		this.DrawShape(0, position);
	} else if(type==1){
		this.DrawShape(1, position);
	} else if(type==2){
		this.DrawShape(2, position);
	} else if(type==3){
		this.DrawShape(3, position);
	} else if(type==4){
		this.DrawShape(4, position);
	} else if(type==5){
		this.DrawShape(5, position);
	} else if(type==6){
		this.DrawShape(6, position);
	}
	
	this.currentState[this.shape.leftMost] = type;
	this.currentState[this.shape.second] = type;
	this.currentState[this.shape.third] = type;
	this.currentState[this.shape.fourth] = type;
}

//pre: the shape is falling
//post: return false if there is no shape below, true if there is shape below.

tetrisGame.isShapeBelow = function() {
	if(this.currentState[this.shape.leftMost+10]==-1 && this.currentState[this.shape.second+10]== -1 && this.currentState[this.shape.third+10]== -1 && this.currentState[this.shape.fourth+10]== -1) {
		return false;
	} else {
		return true;
	}
}

//post: move every block down 1 unit
//set isShapeFalling false when there are indices of blocks below and the shape hits the bottom
tetrisGame.IncrementTime = function(){
	if(!this.initialized){this.Initialize();}
	
	//Empty the current shape
	this.currentState[this.shape.leftMost]= -1;
	this.currentState[this.shape.second]= -1;
	this.currentState[this.shape.third]= -1;
	this.currentState[this.shape.fourth]= -1;
	
	if(this.shape.leftMost +1 == this.currentState.length) {
		this.isShapeFalling = false;
	}
	
	//get indices below
	if(this.isShapeBelow()) {
		this.isShapeFalling = false;
	}
	else {
		this.shape.leftMost += 10;
		this.shape.second += 10;
		this.shape.third +=10;
		this.shape.fourth +=10;	
	}
	
	//add new shape
	this.currentState[this.shape.leftMost] = this.shape.type;
	this.currentState[this.shape.second] = this.shape.type;
	this.currentState[this.shape.third] = this.shape.type;
	this.currentState[this.shape.fourth] = this.shape.type;
	
	this.ClearRow();
}

//pre: IncrementTime running
//post: clear a filled row when filledBlock count is 10 
tetrisGame.ClearRow = function() {
	var filledBlock = 0;
	for(var i=0; i<20; i++) {
		for(var j=0; j<10; j++) {
			if(this.currentState[i*10+j] != -1) {
				filledBlock++;
			}
		}
		
		if (filledBlock == 10) {
			for(var k=0; k<10; k++) {
				AddToConsole("Find the filled row");
				//this.currentState.splice(i*10, 10);	
			}	
		}
	}
	//reset the filledBlock count
	filledBlock = 0;
}

tetrisGame.GetCurrentState = function() {
	if(!this.initialized){this.Initialize();}	
	
	return this.currentState;
}

//pre: initialized = false;
//post: Clear the board entirely and set initialized to true
//this function is added at the beginning of any other functions
tetrisGame.Initialize = function() {
	for(var i = 0; i < 20; i++)
	{
		for(var j = 0; j < 10; j++)
		{
			this.currentState.push(-1);
		}
	}
	this.initialized = true;
}

tetrisGame.IsShapeFalling = function()
{
	if(!this.initialized){this.Initialize();}
	return this.isShapeFalling;
}