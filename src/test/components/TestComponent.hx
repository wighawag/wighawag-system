package test.components;

//import components.PositionComponent;
import core.EntityComponent;

class TestComponent implements EntityComponent{

    @owner
    var position : components.PositionComponent;

    public function new() {
    }

}
