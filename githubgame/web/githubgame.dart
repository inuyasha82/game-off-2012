import 'dart:html'; 
import 'characterlib.dart';
import 'dart:math';

var context;
List<GameSprite> sprites;

void main() { 
  GameSprite maincharacter = new GameSprite(10,10, 70, 70, "red");
  GameSprite secondCharacter = new GameSprite(350,250, 50,50, "yellow");
  query("#text")  
    ..text = "Click me!"
    ..on.click.add(reverseText);
  
  sprites = new List();
  
  window.on.keyDown.add(myKeyDownEvent);
  CanvasElement element = query("canvas");  
  context = element.context2d;
  maincharacter.context = context;
  secondCharacter.context = context;
  maincharacter.type = 'player';
  sprites.add(maincharacter);
  sprites.add(secondCharacter);  
  window.webkitRequestAnimationFrame(animate);   
}

void animate(num time){
  context.clearRect(0,0,350,350);
  for(final sprite in sprites){
    if(!sprite.isPlayer()) sprite.move(-5, 0);
    sprite.draw();
  }
  //sprites.forEach((s) => s.draw());
  window.webkitRequestAnimationFrame(animate);  
}

void reverseText(Event event) {
  var text = query("#text").text;
  var buffer = new StringBuffer();
  for (int i = text.length - 1; i >= 0; i--) {
    buffer.add(text[i]);
  }
  query("#text").text = buffer.toString();
  query("#container").clientWidth;
  query("#container").clientHeight;
}

void myKeyDownEvent(Event event){
  if(event is KeyboardEvent){ 
    KeyboardEvent kevent = event as KeyboardEvent;
    query("#text").text = kevent.keyIdentifier;
    switch(kevent.keyIdentifier){
      case "Up":
        query("#text").text = "Up Pressed";
        sprites.forEach((s) => s.move(0,10));        
        break;
      case "Down":
        query("#text").text = "Down Pressed";
        sprites.forEach((s) => s.move(0,-10));
        break;
      case "Left":
        break;
      case "Right":
        break;
    }
  }
  
  
}