library characterlib;

import 'characterlib.dart';
import 'dart:html';


class GameObject extends GameSprite {
  
  ImageElement objectimage;
  num currectx,currecty;
  
  GameObject(num x, num y, num width, num height) : super(x,y,width,height, "red"){
    ImageElement element = new ImageElement();
    currectx=0;
    currecty=0;    
   
    element.src = "web/sprites/hearts.png";
    objectimage=element;
  }
  
  void update(num value){
    currectx = value*40;
    currecty = 0;    
  }
  
  void draw(){
    if(context!=null){
      context.beginPath();
      if(objectimage!=null){
        context.drawImage(objectimage, currectx, currecty, 40, 40, 300, 0, 40, 40);
      } else {
        context.lineWidth = 2;
        context.fillStyle = color;
        context.strokeStyle = color;
        context.rect(300, 0, 40, 40);
      }
      context.fill();
      context.closePath();      
      context.stroke();
    }
  }
  
}