/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.system;

import haxe.rtti.Meta;
import wighawag.system.ComponentOwner;

@:autoBuild(wighawag.system.macro.ComponentInterdependencyMacro.build())
interface Component {

    public var owner(default, null) : ComponentOwner;
    public var requiredComponents(default, null) : Array<Class<Dynamic>>;

    public function detach() : Void;
    public function attach(componentOwner : ComponentOwner) : Class<Dynamic>;

    public function initialise() : Void;

}
