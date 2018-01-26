import flash.Lib;
import flash.display.Sprite;
import flash.display.Shape;
import flash.display.Stage;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import GameManager ;

// Main class - Sets up important game data, starts the game manager
class Main {

    public static var numPlayers:Int = 2;
    public static var snakeSpeed:Float = 24; // The amount the snake moves per frame
    public static var frameSpeed:Float = 8 ; // How often a frame is updated i.e. every 8 frames
    public static var keyBindings:Array<KeyBinding> ;

    public static function main()
    {
        var gameManager:GameManager = new GameManager(numPlayers, snakeSpeed, frameSpeed) ;
        gameManager.startGame() ;
    }

    // Key bindings created and added to list
    public static function createKeyBindings():Array<KeyBinding>
    {
        keyBindings = new Array<KeyBinding>() ;

        var keyBinding1:KeyBinding = new KeyBinding(Keyboard.A, Keyboard.W, Keyboard.D, Keyboard.S) ;
        var keyBinding2:KeyBinding = new KeyBinding(Keyboard.J, Keyboard.I, Keyboard.L, Keyboard.K) ;
        var keyBinding3:KeyBinding = new KeyBinding(Keyboard.F, Keyboard.T, Keyboard.H, Keyboard.G) ;

        keyBindings.push(keyBinding1) ;
        keyBindings.push(keyBinding2) ;
        keyBindings.push(keyBinding3) ;

        return keyBindings ;
    }
}
