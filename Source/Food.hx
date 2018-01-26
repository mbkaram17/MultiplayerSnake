import flash.display.Sprite;

// Food class
class Food {

    public var sprite:Sprite ;
    public function new()
    {
        sprite = new Sprite() ;
        sprite.graphics.beginFill(0x00FF00);
        sprite.graphics.drawCircle(0, 0, 10);
        sprite.graphics.endFill() ;
    }
}
