package systems;

import com.fermmtools.utils.ObjectHash;
import core.Model;
import core.Entity;

class AbstractSystem {

    private var _entities : Array<Entity>;
    private var _entityRegistrar : ObjectHash<Entity, Bool>;
    private var _model : Model;
    private var _requiredComponents : Array<Class<Dynamic>>;

    public function new(model : Model, ?requiredComponents : Array<Class<Dynamic>>) {
        _entities = new Array();
        _entityRegistrar = new ObjectHash();

        if (requiredComponents != null){
            _requiredComponents = requiredComponents.copy();
        }
        else{
            _requiredComponents = new Array();
        }

        _model = model;
        _model.onEntityAdded.bind(onEntityAdded);
        _model.onEntityRemoved.bind(onEntityRemoved);

        for (entity in _model.entities){
            onEntityAdded(entity);
        }

    }

    public function update(dt : Float) : Void{
        throw "need override"; // TODO better than that ?
    }

    private function onEntityAdded(entity : Entity) : Void{
        if (hasRequiredComponents(entity)){
            _entities.push(entity);
            _entityRegistrar.set(entity, true);
            // TODO add listenner to components being removed  ?
        }
        else
        {
            // TODO add listenner to components being added ???
        }
    }

    private function onEntityRemoved(entity : Entity) : Void{
        if (_entityRegistrar.exists(entity))
        {
            _entities.remove(entity);
            _entityRegistrar.delete(entity);
        }
        // TODO remove listenner on components when listenners added

    }

    private function hasRequiredComponents(entity : Entity) : Bool{
        for (requiredComponent in _requiredComponents){
            if (entity.get(requiredComponent) == null){
                return false;
            }
        }
        return true;
    }

}
