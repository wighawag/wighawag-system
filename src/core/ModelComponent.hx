package core;
@:autoBuild(core.ModelComponentMacro.build())
interface ModelComponent implements Component{
    public var model(default, setModel) : Model;
}
