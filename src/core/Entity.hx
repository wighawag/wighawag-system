package core;

import components.EntityComponent;
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

    public function initialise(components : Array<EntityComponent>) : Void{
        components = components.copy();

        var componentWithMissingDependencies : EntityComponent = null;
        var lengthAtThatpoint = 0;

        var componentsAdded = new ObjectHash<Class<Dynamic>, Bool>();
        while (components.length >0){
            var component = components.shift();
            var dependenciesFound = true;
            if (component.requiredComponents != null){
                for (requiredComponent in component.requiredComponents){
                    if (!componentsAdded.exists(requiredComponent)){
                        dependenciesFound = false;
                        components.push(component); // add back to the end of the list
                        if (componentWithMissingDependencies == component && lengthAtThatpoint == components.length){
                            trace("Could not resolved dependencies for " + components);
                            return;
                        }
                        if (componentWithMissingDependencies == null){
                            componentWithMissingDependencies = component;
                            lengthAtThatpoint = components.length;
                        }
                        break;
                    }
                }
            }

            if (dependenciesFound){
                componentWithMissingDependencies = null;
                var accessClass = add(component);
                componentsAdded.set(accessClass, true);
            }
        }

    }

    private function add<T : EntityComponent>(component :T) : Class<Dynamic> {
        var componentAccessClass = component.attach(this);
        if (componentAccessClass != null){
            _components.set(componentAccessClass, component);
        }
        return componentAccessClass;
    }
}