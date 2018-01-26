import flash.Lib;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

// Player iterator wrapper 
class PlayerIterator {
    var array:Array<Player> ;

    public function new(array:Array<Player>)
    {
        this.array = array ;
    }

    public function iterator()
    {
        return array.iterator() ;
    }
}
