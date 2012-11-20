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
  maincharacter.type = 'player';
  
  secondCharacter.context = context;  

  sprites.add(maincharacter);
  sprites.add(secondCharacter);  
  
  window.requestAnimationFrame(animate);   
}

void animate(num time){  
  enemyCreator(time);
  context.clearRect(0,0,Constants.SCREEN_SIZE_X,Constants.SCREEN_SIZE_Y);  
  for(final sprite in sprites){
    if(!sprite.isPlayer()) {
      sprite.move(5, 0);
      if(player.checkCollison(sprite)){
        player.energy--;  
        sprites.remove(sprite);
      }
      if(!(sprite.posx<0 || sprite.posx>Constants.MAX_X)){ 
               
        sprite.draw();
      } else {        
        sprites.remove(sprite);
      }      
    } else {
      sprite.draw();      
    }
    query('#text').text = "Length: ${sprites.length} Energy: ${player.energy}";
  }
  window.requestAnimationFrame(animate);  
}

void enemyCreator(num time) {
  if((counter%100==0)) {
    num ypos = randomnumbergenerator.nextInt(Constants.MAX_Y-Constants.ENEMY_SIZE_Y);
    Player enemy = new Player(Constants.MAX_X, ypos, Constants.ENEMY_SIZE_X,Constants.ENEMY_SIZE_Y, "blue");
    enemy.context = context;
    enemy.directionx = -1;
    ImageElement image = new ImageElement();
    image.src = "web/sprites/enemy1.png";
    enemy.playerimage = image;
    sprites.add(enemy);    
  }
  counter++;
}

void myKeyDownEvent(Event event){
  if(event is KeyboardEvent){ 
    KeyboardEvent kevent = event as KeyboardEvent;    
    query("#text").text = kevent.keyIdentifier;
    switch(kevent.keyIdentifier){
      case "Up":        
        player.usermove(0,10);        
        break;
      case "Down":        
        player.usermove(0,-10);
        break;
      case "U+0020":        
        Player player = new Player(81, player.centery, 20,Constants.SHOOT_SIZE, "green");
        player.context = context;
        sprites.add(player);
        break;
    }
    //query("#text").text = "${kevent.keyIdentifier} pressed";
  }

}