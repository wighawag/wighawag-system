package wighawag.system;

import msignal.Signal;

class Model extends ComponentOwner{

    public var entities : Array<Entity>;
    private var entitiesSet : Map<Entity, Bool>;

    public var onEntityAdded : Signal1<Entity>;
    public var onEntityRemoved : Signal1<Entity>;

    private var _updatableComponents : Array<Updatable>;
    private var _inGateComponents : Array<InGate>;
    private var _outGateComponents : Array<OutGate>;

    public function new(){
        super();
        entities = new Array<Entity>();
        entitiesSet = new Map();
        onEntityAdded = new Signal1();
        onEntityRemoved = new Signal1();

        _updatableComponents = new Array();
        _inGateComponents = new Array();
        _outGateComponents = new Array();
    }


    public function setup(modelComponents : Array<ModelComponent>) : Void{
        var components = new Array<Component>();
        for (modelComponent in modelComponents){
            if (Std.is(modelComponent, Updatable)){
                _updatableComponents.push(cast modelComponent);
            }
            if (Std.is(modelComponent, InGate)){
                _inGateComponents.push(cast modelComponent);
            }
            if (Std.is(modelComponent, OutGate)){
                _outGateComponents.push(cast modelComponent);
            }
            components.push(modelComponent);
            modelComponent.model = this;
        }

        var failedComponents = initialise(components);

        for (failedComponent in failedComponents){
            Report.aWarning(Channels.SYSTEM, "systemComponent failed to find its dependencies, it is disabled ", failedComponent);
            if (Std.is(failedComponent, Updatable)){
                _updatableComponents.remove(cast failedComponent);
            }
            if (Std.is(failedComponent, InGate)){
                _inGateComponents.remove(cast failedComponent);
            }
            if (Std.is(failedComponent, OutGate)){
                _outGateComponents.remove(cast failedComponent);
            }
            cast(failedComponent,ModelComponent).model = null;
        }
    }

    public function update(dt : Float) : Void{
        for (component in _updatableComponents){
            component.update(dt);
        }
    }

    public function canAdd(entity : Entity) : Bool{
        for (gate in _inGateComponents){
            if (!gate.canAdd(entity)){
                return false;
            }
        }
        return true;
    }

    public function canRemove(entity : Entity) : Bool{
        for (gate in _outGateComponents){
            if (!gate.canRemove(entity)){
                return false;
            }
        }
        return true;
    }

    public function addEntity(entity : Entity, ?checkGate = true) : Bool
    {
        if (!checkGate || canAdd(entity)){
            if (entitiesSet.exists(entity)){
                return false;
            }
            entities.push(entity);
            entitiesSet.set(entity, true);
            onEntityAdded.dispatch(entity);
            return true;
        }
        return false;
    }

    public function removeEntity(entity : Entity, ?checkGate = true) : Bool
    {
        if (!checkGate || canRemove(entity)){
            var removed : Bool = entities.remove(entity);
            if (removed){
                entitiesSet.remove(entity);
                onEntityRemoved.dispatch(entity);
                return true;
            }
        }
        return false;
    }

}
