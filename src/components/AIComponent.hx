package components;

import core.Component;
class AIComponent implements Component {

    @owner
    private var positionComponent : PositionComponent;

    public function new() {
    }

    public function update(dt : Float) : Void{
        positionComponent.x += 10;
        if (positionComponent.x > 200){
            positionComponent.x = 0;
        }
    }

}
