package systems;

import components.PositionComponent;
import core.Model;

class Controller extends AbstractSystem{

    public function new(model : Model) {
        super(model, [PositionComponent]);
    }

    override public function update(dt : Float) : Void{


    }
}
