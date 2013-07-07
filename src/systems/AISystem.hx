/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package systems;

import wighawag.system.Updatable;
import wighawag.system.Entity;
import wighawag.system.SystemComponent;
import components.AIComponent;

@entities(['components.AIComponent'])
class AISystem implements SystemComponent implements Updatable{

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

    public function initialise():Void{

    }

}
