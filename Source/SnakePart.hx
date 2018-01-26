import flash.display.Sprite;

// Seperate snake part class
class SnakePart {

    public var sprite:Sprite ;
    public function new(){
        sprite = new Sprite() ;
        sprite.graphics.beginFill(0x000000);
        sprite.graphics.drawRoundRect(0, 0, 20, 20, 2);
        sprite.graphics.endFill() ;
    }
}
