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
  int directionx;
  int directiony;
  String color;
  String _type;
  num _id;
  
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
    this._id = GlobalValues.idGenerator++;
  }      

  void move(num x, num y){
    this.remove();
    this.posx +=(x*directionx);
    this.posy +=(y*directiony);
    this.draw();
  }
  
  num get startx => this._startx;
  num get starty => this._starty;
  num get id => this._id;  
  num get centery;
  
  set type (String type) {
    _type = type;
  }
  
  bool isPlayer(){
    if(!(_type=='np')) return true;
    return false;
  }    
  
  void draw();
  void remove();
  
  void usermove(num x, num y);
       
}