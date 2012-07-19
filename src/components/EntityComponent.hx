package components;

import core.Entity;

class EntityComponent {

    public var owner(default, setOwner) : Entity;
    private var requiredComponents : Array<Class<Dynamic>>;

    private var enabled : Bool;

    public var accessClass(default, null) : Class<Dynamic>;

    public function new(?requiredComponents : Array<Class<Dynamic>>, ?accessClass : Class<Dynamic>){
        if (requiredComponents != null){
            this.requiredComponents = requiredComponents.copy();
        }
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

    private function setOwner(entity : Entity) : Entity{
        owner = entity;

        enabled = true;

        if (requiredComponents != null){
            var missingComponents : Array<Class<Dynamic>> = new Array();
            for (requiredComponent in requiredComponents){
                if (entity.get(requiredComponent) == null){
                    missingComponents.push(requiredComponent);
                }
            }

            if (missingComponents.length >0)
            {
                trace("disabled as the owner does not have these required components " + missingComponents);
                enabled = false;
            }
        }

        return owner;
    }

}
