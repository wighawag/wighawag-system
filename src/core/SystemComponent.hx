package core;

@:autoBuild(core.SystemComponentMacro.build())
interface SystemComponent implements Component {
    public var model(default, setModel) : Model;
    public function update(dt : Float) : Void;
}
