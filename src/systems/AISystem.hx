package systems;
import core.SystemComponent;
import core.Model;
import core.Entity;
import components.PositionComponent;
import components.AIComponent;

class AISystem extends AbstractSystem, implements SystemComponent{

    public function new() {
        super([AIComponent]);
    }

    public function update(dt : Float) : Void{
        // TODO remove this :
        if (!initialised && owner != null){
            setModel(cast owner);
            initialised = true;
        }


        for (entity in _entities){
             entity.get(AIComponent).update(dt);
         }
    }

}
