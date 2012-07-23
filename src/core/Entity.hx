package core;

class Entity extends ComponentOwner{
    public function new() {
        super();
    }

    public function setup(entityComponents : Array<EntityComponent>) : Void{
        var components = new Array<Component>();
        for (component in entityComponents){
            components.push(component);
        }
        initialise(components);
    }
}
