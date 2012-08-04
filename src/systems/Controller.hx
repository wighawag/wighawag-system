package systems;

import com.wighawag.system.Channels;
import com.wighawag.system.SystemComponent;
import components.PositionComponent;
import com.wighawag.system.Entity;

class Controller implements SystemComponent{

    public function new() {

    }

    public function onEntityRegistered(entity : Entity) : Void{
        Report.aDebugInfo(Channels.SYSTEM, "entity registered with Controller", entity);
    }

    public function onEntityUnregistered(entity : Entity) : Void{
        Report.aDebugInfo(Channels.SYSTEM, "entity unregistered with Controller", entity);
    }



}
