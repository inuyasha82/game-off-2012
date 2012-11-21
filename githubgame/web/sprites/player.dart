library characterlib;

import 'characterlib.dart';
import '../constants.dart';
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
      if(posy + y + height< Constants.MAX_Y && posy + y > 0 ){
        this.move(x, y);
      }
    }
  }
  
  void remove(){    
    context.clearRect(posx-1, posy-1, width+2, height+2);        
  }
  
  bool checkCollison(GameSprite sprite){
    if(sprite.posx > posx && sprite.posx < posx + this.width) {
      if(sprite.posy > posy && sprite.posy < posy+this.height/2 + this.height ){
        return true;
      }      
    }
    return false;
  }
    
}
