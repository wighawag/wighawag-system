package components;

import core.Entity;

class EntityComponent {

    public var owner(default, setOwner) : Entity;
    private var requiredComponents : Array<Class<Dynamic>>;

    private var enabled : Bool;

    public function new(?requiredComponents : Array<Class<Dynamic>>){
        if (requiredComponents != null){
            this.requiredComponents = requiredComponents.copy();
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
