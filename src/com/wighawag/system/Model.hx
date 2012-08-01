package com.wighawag.system;


import msignal.Signal;

class Model extends ComponentOwner{

    public var entities : Array<Entity>;
    public var onEntityAdded : Signal1<Entity>;
    public var onEntityRemoved : Signal1<Entity>;

    private var _systemComponents : Array<SystemComponent>;

    public function new(){
        super();
        entities = new Array<Entity>();
        onEntityAdded = new Signal1();
        onEntityRemoved = new Signal1();

    }


    public function setup(modelComponents : Array<ModelComponent>, systemComponents : Array<SystemComponent>) : Void{
        _systemComponents = new Array();
        var components = new Array<Component>();
        for (modelComponent in modelComponents){
            components.push(modelComponent);
            modelComponent.model = this;
        }
        for (systemComponent in systemComponents){
            _systemComponents.push(systemComponent);
            components.push(systemComponent);
            systemComponent.model = this;
        }

        var failedComponents = initialise(components);

        for (failedComponent in failedComponents){
            trace("systemComponent: " + failedComponent + " failed to find its dependencies, it is disabled");
            _systemComponents.remove(cast failedComponent);
            cast(failedComponent,ModelComponent).model = null;
        }
    }

    public function update(dt : Float) : Void{
        for (systemComponent in _systemComponents){
            systemComponent.update(dt);
        }
    }


    public function addEntity(entity : Entity) : Void
    {
        entities.push(entity);
        onEntityAdded.dispatch(entity);
    }

    public function removeEntity(entity : Entity) : Void
    {
        var removed : Bool = entities.remove(entity);
        if (removed){
            onEntityRemoved.dispatch(entity);
        }
    }

}
