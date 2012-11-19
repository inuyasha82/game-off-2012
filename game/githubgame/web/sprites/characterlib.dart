library characterlib;

import 'dart:html';
import '../constants.dart';

abstract class GameSprite{
  num _startx;
  num _starty;
  num width;
  num height;
  num posx;
  num posy;
  num directionx;
  num directiony;
  String color;
  String _type;
  
  CanvasRenderingContext2D context;
  CanvasElement canvas;
  
  GameSprite(num x, num y, num width, num height, String color){
    this._startx = x;
    this._starty = y;
    this.posx = x;
    this.posy = y;
    this.width = width;
    this.height = height;
    this.color = color;
    this._type = "np";
    this.directionx = 1;
    this.directiony = 1;
  }      

  void move(num x, num y){
    this.posx +=(x*directionx);
    this.posy +=(y*directiony);
  }
  
  num get startx => this._startx;
  num get starty => this._starty;
  
  num get centery;
  
  set type (String type) {
    _type = type;
  }
  
  bool isPlayer(){
    if(!(_type=='np')) return true;
    return false;
  }    
  
  void draw();
  
  void usermove(num x, num y);
       
}