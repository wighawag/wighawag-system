package com.wighawag.system;


import msignal.Signal;

class Model extends ComponentOwner{

    public var entities : Array<Entity>;
    public var onEntityAdded : Signal1<Entity>;
    public var onEntityRemoved : Signal1<Entity>;

    private var _updatableComponents : Array<Updatable>;

    public function new(){
        super();
        entities = new Array<Entity>();
        onEntityAdded = new Signal1();
        onEntityRemoved = new Signal1();

    }


    public function setup(modelComponents : Array<ModelComponent>) : Void{
        _updatableComponents = new Array();
        var components = new Array<Component>();
        for (modelComponent in modelComponents){
            if (Std.is(modelComponent, Updatable)){
                _updatableComponents.push(cast modelComponent);
            }
            components.push(modelComponent);
            modelComponent.model = this;
        }


        var failedComponents = initialise(components);

        for (failedComponent in failedComponents){
            trace("systemComponent: " + failedComponent + " failed to find its dependencies, it is disabled");
            if (Std.is(failedComponent, Updatable)){
                _updatableComponents.remove(cast failedComponent);
            }
            cast(failedComponent,ModelComponent).model = null;
        }
    }

    public function update(dt : Float) : Void{
        for (component in _updatableComponents){
            component.update(dt);
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
