/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.system;
@:autoBuild(wighawag.system.macro.ModelComponentMacro.build())
interface ModelComponent extends Component{
    public var model(default, set) : Model;
}
