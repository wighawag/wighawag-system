package test.components;

//import components.PositionComponent;
import core.Component;

class TestComponent implements Component{

    @owner
    var position : components.PositionComponent;

    public function new() {
    }

}
