package systems;

import com.fermmtools.utils.ObjectHash;
import core.Model;
import core.Entity;

class AbstractSystem {

    private var _entities : Array<Entity>;
    private var _entityRegistrar : ObjectHash<Entity, Bool>;
    private var _model : Model;

    public function new(model : Model) {
        _entities = new Array();
        _entityRegistrar = new ObjectHash();

        _model = model;
        _model.onEntityAdded.bind(onEntityAdded);
        _model.onEntityRemoved.bind(onEntityRemoved);

        for (entity in _model.entities){
            onEntityAdded(entity);
        }

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
        return false; // override to allow entity to be handle by the system
    }

    /*
    private function registered(entity : Entity) : Void{

    }

    private function unregistered(entity : Entity) : Void{

    }
    */
}
