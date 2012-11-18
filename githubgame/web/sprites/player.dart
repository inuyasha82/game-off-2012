library characterlib;

import 'characterlib.dart';
import 'dart:html';

class Player extends GameSprite {
  
  var energy;
  ImageElement playerimage;
  
  Player(num x, num y, num width, num height, String color) : super(x,y,width,height,color){
    energy = 5;
  }   
  
  void draw(){
    context.beginPath();
    context.lineWidth = 2;
    context.fillStyle = color;
    context.strokeStyle = color;
    if(playerimage==null){
      context.rect(posx, posy, width, height);
    } else {
      context.drawImage(playerimage, posx, posy, width, height);
    }
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
  
  bool checkCollison(GameSprite sprite){
    if(sprite.posx > posx && sprite.posx < posx + this.width) {
      if(sprite.posy > posy && sprite.posy < posy + this.height){
        return true;
      }      
    }
    return false;
  }
    
}
