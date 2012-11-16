import 'dart:html'; 
import 'sprites/characterlib.dart';
import 'sprites/player.dart';
import 'dart:math';

var context;
Set<GameSprite> sprites;
int counter= 0;

void main() { 
  var maincharacter = new Player(10,10, 70, 70, "red");
  var secondCharacter = new Player(400,250, 50,50, "yellow");
  
  sprites = new Set();
  
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
  enemyCreator(time);
  context.clearRect(0,0,400,400);  
  for(final sprite in sprites){
    if(!sprite.isPlayer()) {
      sprite.move(5, 0);
      // sprite.isOutside(0);
      if(!(sprite.posx<0)){ 
        query('#text').text = " Posx: ${sprite.posx.toString()} Length: ${sprites.length}";
        sprite.draw();
      } else {
        query('#text').text = "Destroyed";
        sprites.remove(sprite);
      }      
    } else {
      sprite.draw();
      query('#text').text = " Time: $counter Length: ${sprites.length}";
    }
  }
  window.webkitRequestAnimationFrame(animate);  
}

void enemyCreator(num time) {

  if((counter%100==0)) { 
    Player player = new Player(400, 100, 20,20, "blue");
    player.context = context;
    player.directionx = -1;
    sprites.add(player);    
  }
  counter++;
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
      case "U+0020":
        query("#text").text = "Space pressed";
        Player player = new Player(0, 100, 20,20, "blue");
        player.context = context;
        sprites.add(player);
        break;
    }
  }
  
  
}