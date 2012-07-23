package core;

@:autoBuild(core.SystemComponentMacro.build())
interface SystemComponent implements ModelComponent {
    public var registeredEntities(default, null) : Array<Entity>;
    public function update(dt : Float) : Void;
}
