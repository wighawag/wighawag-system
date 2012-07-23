package core;

import haxe.rtti.Meta;
import core.ComponentOwner;

@:autoBuild(core.ComponentInterdependencyMacro.build())
interface Component {

    public var owner(default, null) : ComponentOwner;
    public var requiredComponents(default, null) : Array<Class<Dynamic>>;

    public function detach() : Void;
    public function attach(componentOwner : ComponentOwner) : Class<Dynamic>;

}
