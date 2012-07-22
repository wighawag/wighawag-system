package systems;

import core.SystemComponent;
import components.PositionComponent;
import core.Model;

class Controller extends AbstractSystem, implements SystemComponent{

    public function new() {
        super([PositionComponent]);
    }

    public function update(dt : Float) : Void{
        // TODO remove this :
        if (!initialised && owner != null){
            setModel(cast owner);
            initialised = true;
        }

    }
}
