package com.wighawag.system;

@:autoBuild(com.wighawag.system.macro.SystemComponentMacro.build())
interface SystemComponent implements ModelComponent{
    public var registeredEntities(default, null) : Array<Entity>;
    public function onEntityRegistered(entity : Entity) : Void;
    public function onEntityUnregistered(entity : Entity) : Void;
}
