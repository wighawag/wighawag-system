package wighawag.system;

import wighawag.system.Component;
import wighawag.system.Component;
import com.fermmtools.utils.ObjectHash;

class ComponentOwner{
    private var _components : ObjectHash<Dynamic, Dynamic>;

    public function new() {
        _components = new ObjectHash();
    }

    public function get<T : Component>(componentClass : Class<T>) : T {
        return _components.get(componentClass);
    }

    public function has(componentClasses : Array<Class<Dynamic>>) : Bool {
        for (componentClass in componentClasses){
            if (get(componentClass) == null){
                return false;
            }
        }
        return true;
    }

    private function initialise(components : Array<Component>) : Array<Component>{
        components = components.copy();

        var componentWithMissingDependencies : Component = null;
        var lengthAtThatpoint = 0;


        var componentsAdded = new ObjectHash<Class<Dynamic>, Dynamic>();
        for (componentClass in _components){
            componentsAdded.set(componentClass, true);
        }
        while (components.length >0){
            var component = components.shift();
            var dependenciesFound = true;
            if (component.requiredComponents != null){
                for (requiredComponent in component.requiredComponents){
                    if (!componentsAdded.exists(requiredComponent)){
                        dependenciesFound = false;
                        components.push(component); // add back to the end of the list
                        if (componentWithMissingDependencies == component && lengthAtThatpoint == components.length){
                            Report.aWarning(Channels.SYSTEM, "Could not resolved dependencies for ", [components]);
                            return components;
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
                component.initialise();
                componentsAdded.set(accessClass, true);
            }
        }

        return components;

    }

    private function add<T : Component>(component :T) : Class<Dynamic> {
        var componentAccessClass = component.attach(this);
        if (componentAccessClass != null){
            _components.set(componentAccessClass, component);
        }
        return componentAccessClass;
    }
}