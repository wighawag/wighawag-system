package systems;

import com.wighawag.system.SystemComponent;
import components.PositionComponent;
import com.wighawag.system.Entity;

class Controller implements SystemComponent{

    public function new() {

    }

    public function onEntityRegistered(entity : Entity) : Void{
        trace("entity registered with Controller");
    }

    public function onEntityUnregistered(entity : Entity) : Void{
        trace("entity unregistered from Controller");
    }



}
