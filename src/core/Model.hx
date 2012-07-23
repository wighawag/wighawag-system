package core;

import hsl.haxe.Signaler;
import hsl.haxe.DirectSignaler;

class Model extends ComponentOwner{

    public var entities : Array<ComponentOwner>;
    public var onEntityAdded : Signaler<ComponentOwner>;
    public var onEntityRemoved : Signaler<ComponentOwner>;

    private var _systemComponents : Array<SystemComponent>;

    public function new(){
        super();
        entities = new Array<ComponentOwner>();
        onEntityAdded = new DirectSignaler<ComponentOwner>(this);
        onEntityRemoved = new DirectSignaler<ComponentOwner>(this);

    }


    public function setup(modelComponents : Array<ModelComponent>, systemComponents : Array<SystemComponent>) : Void{
        _systemComponents = new Array();
        var components = new Array<Component>();
        for (modelComponent in modelComponents){
            components.push(modelComponent);
        }
        for (systemComponent in systemComponents){
            _systemComponents.push(systemComponent);
            components.push(systemComponent);
            systemComponent.model = this; // TODO use setModel and do not allow normal setter
        }

        var failedComponents = initialise(components);

        for (failedComponent in failedComponents){
            trace("systemComponent: " + failedComponent + " failed to find its dependencies, it is disabled");
            _systemComponents.remove(cast failedComponent);
        }
    }

    public function update(dt : Float) : Void{
        for (systemComponent in _systemComponents){
            systemComponent.update(dt);
        }
    }


    public function addEntity(entity : ComponentOwner) : Void
    {
        entities.push(entity);
        onEntityAdded.dispatch(entity);
    }

    public function removeEntity(entity : ComponentOwner) : Void
    {
        var removed : Bool = entities.remove(entity);
        if (removed){
            onEntityRemoved.dispatch(entity);
        }
    }

}
