package systems;
import core.SystemComponent;
import core.Model;
import core.ComponentOwner;
import components.PositionComponent;
import components.AIComponent;

@entities(['components.AIComponent'])
class AISystem implements SystemComponent{

    public function new() {
    }

    public function update(dt : Float) : Void{

        for (entity in entities){
             entity.get(AIComponent).update(dt);
         }
    }

}
