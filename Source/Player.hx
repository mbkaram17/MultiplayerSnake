import flash.Lib;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import KeyBinding;

enum Direction {
  Right;
  Left;
  Up;
  Down;
  Still;
}

class Player {

    public var playerNumber:Int ;

    public var playerSnakeHead:SnakePart ;
    public var playerSnake:Array<SnakePart> ;

    public var currentDirection:Direction = Still;

    public var keyBinding:KeyBinding ;

    public function new(playerNumber:Int, keyBinding:KeyBinding)
    {
        this.playerNumber = playerNumber ;

        playerSnakeHead = new SnakePart() ;
        playerSnake = new Array<SnakePart>() ;
        playerSnake.push(playerSnakeHead) ;

        this.keyBinding = keyBinding ;
    }

    // Change direction of player snake -- only changes if player has that keybinding
    public function changeDirection(key:UInt):Void
    {
        if(key == keyBinding.leftKey && currentDirection != Right)
        {
            currentDirection = Left ;
        }
        else if (key == keyBinding.upKey && currentDirection != Down)
        {
            currentDirection = Up ;
        }
        else if (key == keyBinding.rightKey && currentDirection != Left)
        {
            currentDirection = Right ;
        }
        else if (key == keyBinding.downKey && currentDirection != Up)
        {
            currentDirection = Down ;
        }
    }
}
