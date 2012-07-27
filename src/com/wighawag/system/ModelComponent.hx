package com.wighawag.system;
@:autoBuild(com.wighawag.system.macro.ModelComponentMacro.build())
interface ModelComponent implements Component{
    public var model(default, setModel) : Model;
}
