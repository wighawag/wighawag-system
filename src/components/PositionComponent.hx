package components;


import core.EntityComponent;
class PositionComponent implements EntityComponent{

    public var x : Float;
    public var y : Float;

    public function new(x : Float, y : Float) {
        this.x = x;
        this.y = y;
    }
}
