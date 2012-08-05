package com.wighawag.system;

class EntityType extends ComponentOwner{
    public function new() {
        super();
    }

    public function setup(typeComponents : Array<EntityTypeComponent>) : Void{
        var components = new Array<Component>();
        for (component in typeComponents){
            components.push(component);
        }
        initialise(components);
    }
}
