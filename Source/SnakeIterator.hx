import flash.Lib;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

// Snake iterator wrapper
class SnakeIterator {
    var array:Array<SnakePart> ;

    public function new(array:Array<SnakePart>)
    {
        this.array = array ;
    }

    public function iterator()
    {
        return array.iterator() ;
    }
}
