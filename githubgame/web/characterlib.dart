library characterlib;

import 'dart:html';
import 'constants.dart';

class GameSprite{
  num _startx;
  num _starty;
  num width;
  num height;
  String color;
  String _type;
  
  CanvasRenderingContext2D context;
  CanvasElement canvas;
  
  GameSprite(num x, num y, num width, num height, String color){
    this._startx = x;
    this._starty = y;
    this.width = width;
    this.height = height;
    this.color = color;
    this._type = "np";    
  }
  
  
  Rect get rect => new Rect(this._startx, this._starty, this.width, this.height);

  void move(num x, num y){
    this._startx +=x;
    this._starty +=y;
  }
  
  num get startx => this._startx;
  num get starty => this._starty;
  
  set type (String type) {
    _type = type;
  }
  
  bool isPlayer(){
    if(!(_type=='np')) return true;
    return false;
  }
  
  void draw(){    
    context.beginPath();
    context.lineWidth = 2;
    context.fillStyle = color;
    context.strokeStyle = color; 
    context.rect(_startx, _starty, width, height);
    context.fill();  
    context.closePath();  
    context.stroke();
  }
   
}