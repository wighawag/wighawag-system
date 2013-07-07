/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.system;

@:autoBuild(wighawag.system.macro.SystemComponentMacro.build())
interface SystemComponent extends ModelComponent{
    public var registeredEntities(default, null) : Array<Entity>;
    public function onEntityRegistered(entity : Entity) : Void;
    public function onEntityUnregistered(entity : Entity) : Void;
}
