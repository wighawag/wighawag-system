package wighawag.system;

@:autoBuild(wighawag.system.macro.EntityComponentMacro.build())
interface EntityComponent extends Component {

    var entity(default, null) : Entity;
    function attachEntity(entity : Entity) : Bool;
    function detachEntity() : Void;
}
