/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.system;

@:autoBuild(wighawag.system.macro.EntityComponentMacro.build())
interface EntityComponent extends Component {

    var entity(default, null) : Entity;
    function attachEntity(entity : Entity) : Bool;
    function detachEntity() : Void;
}
