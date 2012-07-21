package components;

import haxe.rtti.Meta;
import core.Entity;

@:autoBuild(components.ComponentInterdependencyMacro.build())
class EntityComponent {

    public var owner(default, null) : Entity;
    public var requiredComponents(default, null) : Array<Class<Dynamic>>;

    private var accessClass(default, null) : Class<Dynamic>;

    public function new(?accessClass : Class<Dynamic>){

        if (accessClass == null){
            this.accessClass = Type.getClass(this);
        }
        else
        {
            if (Std.is(this, accessClass)){
                this.accessClass = accessClass;
            }
            else
            {
                trace("trying to set accessClass to a Class (" + accessClass + ") that is not the current instance's base class : " + Type.getClass(this));
            }
        }


    }

    public function detach() : Void{
        owner = null;
    }

    public function attach(entity : Entity) : Class<Dynamic>{
        if (requiredComponents != null){
            var missingComponents : Array<Class<Dynamic>> = new Array();
            for (requiredComponent in requiredComponents){
                var component = entity.get(requiredComponent);   // TODO set the fields (@owner)
                if (component == null){
                    missingComponents.push(requiredComponent);
                }
            }

            if (missingComponents.length >0)
            {
                trace("" + Type.getClass(this) + " disabled as the owner does not have these required components " + missingComponents);
                return null;
            }
        }

        owner = entity;
        return accessClass;
    }

}
