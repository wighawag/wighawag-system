package core;

@:autoBuild(core.SystemComponentMacro.build())
interface SystemComponent implements ModelComponent {
    public var model(default, setModel) : Model;
// TODO add entities ?
    public function update(dt : Float) : Void;
}
