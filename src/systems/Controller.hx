package systems;

import wighawag.system.Channels;
import wighawag.system.SystemComponent;
import components.PositionComponent;
import wighawag.system.Entity;

class Controller implements SystemComponent{

    public function new() {

    }

    public function initialise():Void{

    }

    public function onEntityRegistered(entity : Entity) : Void{
        Report.aDebugInfo(Channels.SYSTEM, "entity registered with Controller", entity);
    }

    public function onEntityUnregistered(entity : Entity) : Void{
        Report.aDebugInfo(Channels.SYSTEM, "entity unregistered with Controller", entity);
    }



}
