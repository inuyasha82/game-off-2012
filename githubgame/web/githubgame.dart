import 'dart:html';
import 'sprites/characterlib.dart';
import 'sprites/player.dart';
import 'sprites/gameobject.dart';
import 'constants.dart';
import 'dart:math';

var context;
Set<GameSprite> sprites;
int counter= 0;
var randomnumbergenerator;
Player player;
GameObject heart;

void main() { 
  var maincharacter = new Player(12,12, 70, 70, "red");
  player = maincharacter;
  
  sprites = new Set();
  randomnumbergenerator = new Random();
  window.on.keyDown.add(myKeyDownEvent);
  
  CanvasElement element = query("canvas");  
  context = element.context2d;
  
  maincharacter.context = context;
  maincharacter.type = 'player';
  ImageElement playerimage = new ImageElement();
  playerimage.src = "web/sprites/mainplayer.png";
  maincharacter.playerimage = playerimage;
  
  heart = new GameObject(0,0,40,40);
  heart.context = context;

  sprites.add(maincharacter);  
  window.requestAnimationFrame(start);
  window.requestAnimationFrame(animate);  
}

void start(num time){
  player.draw();  
}

void animate(num time){  
  enemyCreator(time); 
  for(final sprite in sprites){
    if(!sprite.isPlayer()) {
      sprite.move(5, 0);      
      if(player.checkCollison(sprite)){
        player.energy--;
        heart.update(1);
        sprite.remove();
        player.draw();
        sprites.remove(sprite);        
      }
      if(!(sprite.posx<0 || sprite.posx>Constants.MAX_X)){        
        heart.draw();        
      } else {
        sprite.remove();
        sprites.remove(sprite);
      }      
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
    //query("#text").text = kevent.keyIdentifier;
    //query("#text").text = kevent.keyCode.toString();
    switch(kevent.keyCode){
      case 38:                
        player.usermove(0,10);        
        break;
      case 40:        
        player.usermove(0,-10);
        break;
      case 32:        
        Player player = new Player(85, player.centery, 20,Constants.SHOOT_SIZE, "green");
        player.context = context;
        sprites.add(player);
        break;
    }
  }

}