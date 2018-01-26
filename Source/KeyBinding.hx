import flash.Lib;
import flash.display.Sprite;
import flash.display.Shape;
import flash.display.Stage;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

// Keybinding class - each player gets assigned a unique key binding
class KeyBinding {

    public var leftKey:UInt ;
    public var upKey:UInt ;
    public var rightKey:UInt ;
    public var downKey:UInt ;

    public function new(leftKey:UInt, upKey:UInt, rightKey:UInt, downKey:UInt)
    {
        this.leftKey = leftKey ;
        this.upKey = upKey ;
        this.rightKey = rightKey ;
        this.downKey = downKey ;
    }
}
