package com.wighawag.system;

class EntityType extends ComponentOwner{

    public var id(default, null) : String;

    public function new(id : String = "default") {
        super();
        this.id = id;
    }

    public function setup(typeComponents : Array<EntityTypeComponent>) : Void{
        var components = new Array<Component>();
        for (component in typeComponents){
            components.push(component);
        }
        initialise(components);
    }
}
