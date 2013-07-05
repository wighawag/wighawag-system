package wighawag.system;

@:autoBuild(wighawag.system.macro.SystemComponentMacro.build())
interface SystemComponent extends ModelComponent{
    public var registeredEntities(default, null) : Array<Entity>;
    public function onEntityRegistered(entity : Entity) : Void;
    public function onEntityUnregistered(entity : Entity) : Void;
}
