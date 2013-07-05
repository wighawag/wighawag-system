package test.components;

import wighawag.system.EntityComponent;

class TestComponent implements EntityComponent{

    @owner
    var position : components.PositionComponent;

    public function new() {
    }


    public function initialise():Void{

    }

}
