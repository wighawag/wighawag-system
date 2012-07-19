package core;

import com.fermmtools.utils.ObjectHash;
import components.EntityComponent;

//class Entity extends ComponentOwner<EntityComponent>{
//
//   public function new(){
//       super();
//   }
//
//}

class Entity{
    private var _components : ObjectHash<Dynamic, Dynamic>;

    public function new() {
        _components = new ObjectHash();
    }

    public function get<T : EntityComponent>(componentClass : Class<T>) : T {
        return _components.get(componentClass);
    }

    public function add<T : EntityComponent>(component :T) {
        _components.set(Type.getClass(component), component);
        component.owner = this;
    }
}