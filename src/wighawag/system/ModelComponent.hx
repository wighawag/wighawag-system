package wighawag.system;
@:autoBuild(wighawag.system.macro.ModelComponentMacro.build())
interface ModelComponent extends Component{
    public var model(default, set) : Model;
}
