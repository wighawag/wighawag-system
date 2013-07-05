package wighawag.system;

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

    public function createEntity(entityComponents : Array<EntityComponent>) : Entity{

        entityComponents = entityComponents.copy(); //TODO remove safety copy ?
        for (componentKey in _components){
            var component = _components.get(componentKey); // TODO investigate why I get error when using _components.values()
            component.populateEntity(entityComponents);
        }
        var entity = new Entity();
        entity.setup(entityComponents, this);
        return entity;

    }
}
