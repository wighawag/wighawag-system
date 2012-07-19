package core;

import systems.AbstractSystem;

class SystemsEngine {

    private var _systems : Array<AbstractSystem>;

    public function new(systems : Array<AbstractSystem>) {
        _systems = systems.copy();
    }

    public function update(dt : Float) : Void{
        for (system in _systems){
            system.update(dt);
        }
    }
}
