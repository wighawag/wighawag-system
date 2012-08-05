package com.wighawag.system;

@:autoBuild(com.wighawag.system.macro.EntityComponentMacro.build())
interface EntityComponent implements Component {

    var entity(default, null) : Entity;
    function attachEntity(entity : Entity) : Bool;
    function detachEntity() : Void;
}
