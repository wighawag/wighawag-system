package components;
class PositionComponent extends EntityComponent{

    public var x : Float;
    public var y : Float;

    public function new(x : Float, y : Float) {
        super();
        this.x = x;
        this.y = y;
    }
}
