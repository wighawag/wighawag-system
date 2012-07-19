package components;

import core.Entity;
class AIComponent extends EntityComponent {

    public function new() {
        super([PositionComponent]);
    }

    public function update(dt : Float) : Void{
        if (!enabled){
            return;
        }
        var positionComponent = owner.get(PositionComponent);
        positionComponent.x += 10;
        if (positionComponent.x > 200){
            positionComponent.x = 0;
        }
    }

}
