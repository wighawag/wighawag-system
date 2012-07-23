package test.components;

import core.EntityComponent;

class TestComponent implements EntityComponent{

    @owner
    var position : components.PositionComponent;

    public function new() {
    }

}
