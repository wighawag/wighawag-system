package core;

@:autoBuild(core.SystemComponentMacro.build())
interface SystemComponent implements ModelComponent, implements Updatable{
    public var registeredEntities(default, null) : Array<Entity>;
    public function onEntityRegistered(entity : Entity) : Void;
    public function onEntityUnregistered(entity : Entity) : Void;
}
