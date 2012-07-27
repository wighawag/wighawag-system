package systems;

import com.wighawag.system.Entity;
import com.wighawag.system.SystemComponent;
import components.AIComponent;

@entities(['components.AIComponent'])
class AISystem implements SystemComponent{

    public function new() {
    }

    public function onEntityRegistered(entity : Entity) : Void{

    }

    public function onEntityUnregistered(entity : Entity) : Void{

    }

    public function update(dt : Float) : Void{

        for (entity in registeredEntities){
             entity.get(AIComponent).update(dt);
         }
    }

}
