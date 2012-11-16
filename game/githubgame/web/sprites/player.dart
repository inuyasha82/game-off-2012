library characterlib;

import 'characterlib.dart';

class Player extends GameSprite {
  
  var energy;
  
  Player(num x, num y, num width, num height, String color) : super(x,y,width,height,color){
    energy = 5;
  }
  
  void draw(){
    context.beginPath();
    context.lineWidth = 2;
    context.fillStyle = color;
    context.strokeStyle = color; 
    context.rect(posx, posy, width, height);    
    context.fill();  
    context.closePath();  
    context.stroke();
  }
  
  num get centery => posy + height/2 ;     
  
  void usermove(num x, num y){
    if(isPlayer()){
      this.move(x, y);
    }
  }
    
}
