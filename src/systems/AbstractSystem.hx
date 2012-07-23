package systems;

import com.fermmtools.utils.ObjectHash;
import core.Model;
import core.ComponentOwner;

class AbstractSystem {

    private var _entities : Array<ComponentOwner>;
    private var _entityRegistrar : ObjectHash<ComponentOwner, Bool>;
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

    private function onEntityAdded(entity : ComponentOwner) : Void{
        if (hasRequiredComponents(entity)){
            _entities.push(entity);
            _entityRegistrar.set(entity, true);
        }
    }

    private function onEntityRemoved(entity : ComponentOwner) : Void{
        if (_entityRegistrar.exists(entity))
        {
            _entities.remove(entity);
            _entityRegistrar.delete(entity);
        }
    }

    private function hasRequiredComponents(entity : ComponentOwner) : Bool{
        for (requiredComponent in _requiredEntityComponents){
            if (entity.get(requiredComponent) == null){
                return false;
            }
        }
        return true;
    }

}
