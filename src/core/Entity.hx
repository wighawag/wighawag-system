package core;

import com.fermmtools.utils.ObjectHash;
class Entity {

    private var _components : ObjectHash<Dynamic, Dynamic>;

    public function new() {
        _components = new ObjectHash();
    }

    public function get<T>(componentClass : Class<T>) : T {
        return _components.get(componentClass);
    }

    public function add<T>(component :T) {
        _components.set(Type.getClass(component), component);
    }

}
