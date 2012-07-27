package systems;

import core.SystemComponent;
import components.PositionComponent;
import core.Entity;

class Controller implements SystemComponent{

    public function new() {

    }

    public function onEntityRegistered(entity : Entity) : Void{
        trace("entity registered with Controller");
    }

    public function onEntityUnregistered(entity : Entity) : Void{
        trace("entity unregistered from Controller");
    }

    public function update(dt : Float) : Void
    {

    }


}
