import 'dart:html';
import 'sprites/characterlib.dart';
import 'sprites/player.dart';
import 'constants.dart';
import 'dart:math';

var context;
Set<GameSprite> sprites;
int counter= 0;
var randomnumbergenerator;
Player player;

var gameMatrix = new List(); 

void main() { 
  var maincharacter = new Player(10,10, 70, 70, "red");
  var secondCharacter = new Player(Constants.MAX_X,250, 50,50, "yellow");
  player = maincharacter;
  
  sprites = new Set();
  randomnumbergenerator = new Random();
  window.on.keyDown.add(myKeyDownEvent);
  CanvasElement element = query("canvas");  
  context = element.context2d;
  maincharacter.context = context;
  secondCharacter.context = context;
  maincharacter.type = 'player';
  sprites.add(maincharacter);
  sprites.add(secondCharacter);  
  window.requestAnimationFrame(animate);   
}

void animate(num time){  
  enemyCreator(time);
  //update_background();
  context.clearRect(0,0,Constants.SCREEN_SIZE_X,Constants.SCREEN_SIZE_Y);  
  for(final sprite in sprites){
    if(!sprite.isPlayer()) {
      sprite.move(5, 0);
      if(player.checkCollison(sprite)){
        player.energy--;
        sprites.remove(sprite);
      }
      if(!(sprite.posx<0)){ 
        query('#text').text = " Posx1: ${sprite.posx.toString()} Length: ${sprites.length} Energy: ${player.energy}";        
        sprite.draw();
      } else {
        query('#text').text = "Destroyed";
        sprites.remove(sprite);
      }      
    } else {
      sprite.draw();
      query('#text').text = " Time: $counter Length: ${sprites.length} Energy: ${player.energy}";
    }
  }
  window.requestAnimationFrame(animate);  
}

void enemyCreator(num time) {

  if((counter%100==0)) {
    num ypos = randomnumbergenerator.nextInt(300);
    Player enemy = new Player(Constants.MAX_X, ypos, 20,20, "blue");
    enemy.context = context;
    enemy.directionx = -1;
    sprites.add(enemy);    
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
        sprites.forEach((s) => s.usermove(0,10));        
        break;
      case "Down":
        query("#text").text = "Down Pressed";
        sprites.forEach((s) => s.usermove(0,-10));
        break;
      case "Left":
        break;
      case "Right":
        break;
      case "U+0020":
        query("#text").text = "Space pressed";
        Player player = new Player(81, player.centery, 20,Constants.SHOOT_SIZE, "green");
        player.context = context;
        sprites.add(player);
        break;
    }
  }

}