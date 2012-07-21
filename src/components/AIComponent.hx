package components;

class AIComponent implements EntityComponent {

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
