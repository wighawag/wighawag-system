/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.system;

import typecomponents.TestTypeComponent;
class Entity extends ComponentOwner{

    public var type(default, null) : EntityType;

    public function new() {
        super();
    }

    public function setup(entityComponents : Array<EntityComponent>, ?type : EntityType) : Void{
        if (type == null){
            type = new EntityType();
        }
        this.type = type;
        var components = new Array<Component>();
        for (component in entityComponents){
            var success = component.attachEntity(this);
            if (success){
                components.push(component);
            }
            else{
                component.detachEntity();
            }
        }

        initialise(components);

    }

}
