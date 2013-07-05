package components;


import typecomponents.TestTypeComponent;
import wighawag.system.EntityComponent;
class PositionComponent implements EntityComponent{

    //@entityType
    //private var typeComponent : TestTypeComponent;

    public var x : Float;
    public var y : Float;

    public function new(x : Float, y : Float) {
        this.x = x;
        this.y = y;
    }

    public function initialise():Void{

    }
}
