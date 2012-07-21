package components;

import core.Entity;
class AIComponent extends EntityComponent {

    @owner
    private var positionComponent : PositionComponent;

    public function new() {
        super();
    }

    public function update(dt : Float) : Void{
        positionComponent.x += 10;
        if (positionComponent.x > 200){
            positionComponent.x = 0;
        }
    }

}
