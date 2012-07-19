package systems;
import core.Model;
import core.Entity;
import components.PositionComponent;
import components.AIComponent;
class AISystem extends AbstractSystem{
    public function new(model : Model) {
        super(model, [AIComponent]);
    }

    public function update() : Void{
         for (entity in _entities){
             entity.get(AIComponent).update();
         }
    }

}
