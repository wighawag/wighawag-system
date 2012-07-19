package systems;
import core.Model;
import core.Entity;
import components.PositionComponent;
import components.AIComponent;
class AISystem extends AbstractSystem{
    public function new(model : Model) {
        super(model);
    }

    public function update() : Void{
         for (entity in _entities){
             entity.get(AIComponent).update();

             // FOR NOW (TODO)
            var positionComponent = entity.get(PositionComponent);
            positionComponent.x += 10;
             if (positionComponent.x > 200){
                 positionComponent.x = 0;
             }
         }
    }


    override private function hasRequiredComponents(entity : Entity) : Bool{
        return entity.get(AIComponent) != null;
    }
}
