package systems;

import com.fermmtools.utils.ObjectHash;
import core.Model;
import core.Entity;

class AbstractSystem {

    private var _entities : Array<Entity>;
    private var _entityRegistrar : ObjectHash<Entity, Bool>;
    public var model(default, setModel) : Model;
    private var _requiredEntityComponents : Array<Class<Dynamic>>;

    private var initialised : Bool;

    public function new(?requiredEntityComponents : Array<Class<Dynamic>>) {
        _entities = new Array();
        _entityRegistrar = new ObjectHash();

        if (requiredEntityComponents != null){
            _requiredEntityComponents = requiredEntityComponents.copy();
        }
        else{
            _requiredEntityComponents = new Array();
        }
    }

    private function setModel(aModel : Model) : Model{
        model = aModel;
        model.onEntityAdded.bind(onEntityAdded);
        model.onEntityRemoved.bind(onEntityRemoved);

        for (entity in model.entities){
            onEntityAdded(entity);
        }

        return model;

    }

    private function onEntityAdded(entity : Entity) : Void{
        if (hasRequiredComponents(entity)){
            _entities.push(entity);
            _entityRegistrar.set(entity, true);
        }
    }

    private function onEntityRemoved(entity : Entity) : Void{
        if (_entityRegistrar.exists(entity))
        {
            _entities.remove(entity);
            _entityRegistrar.delete(entity);
        }
    }

    private function hasRequiredComponents(entity : Entity) : Bool{
        for (requiredComponent in _requiredEntityComponents){
            if (entity.get(requiredComponent) == null){
                return false;
            }
        }
        return true;
    }

}
