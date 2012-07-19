package core;
import com.fermmtools.utils.ObjectHash;

// TODO use this as Entity base class (not supported by Haxe yet)
class _ComponentOwner<ComponentSuperType> {

    private var _components : ObjectHash<Dynamic, Dynamic>;

    public function new() {
        _components = new ObjectHash();
    }

    public function get<T : ComponentSuperType>(componentClass : Class<T>) : T {
        return _components.get(componentClass);
    }

    public function add<T : ComponentSuperType>(component :T) {
        _components.set(Type.getClass(component), component);
    }
}
