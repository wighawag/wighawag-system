/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package components;


import typecomponents.TestTypeComponent;
import wighawag.system.EntityComponent;
class PositionComponent implements EntityComponent{

    //@entityType
    //private var typeComponent : TestTypeComponent;

    public var x : Float;
    public var y : Float;

    public function new(x : Float, y : Float) {
        this.x = x;
        this.y = y;
    }

    public function initialise():Void{

    }
}
