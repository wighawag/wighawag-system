package com.wighawag.system;

import haxe.rtti.Meta;
import com.wighawag.system.ComponentOwner;

@:autoBuild(com.wighawag.system.macro.ComponentInterdependencyMacro.build())
interface Component {

    public var owner(default, null) : ComponentOwner;
    public var requiredComponents(default, null) : Array<Class<Dynamic>>;

    public function detach() : Void;
    public function attach(componentOwner : ComponentOwner) : Class<Dynamic>;

    public function initialise() : Void;

}
