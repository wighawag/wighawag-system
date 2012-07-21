package components;

import haxe.rtti.Meta;
import core.Entity;

@:autoBuild(components.ComponentInterdependencyMacro.build())
interface EntityComponent {

    public var owner(default, null) : Entity;
    public var requiredComponents(default, null) : Array<Class<Dynamic>>;

    public function detach() : Void;
    public function attach(entity : Entity) : Class<Dynamic>;

}
