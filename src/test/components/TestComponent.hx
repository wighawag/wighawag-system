/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package test.components;

import wighawag.system.EntityComponent;

class TestComponent implements EntityComponent{

    @owner
    var position : components.PositionComponent;

    public function new() {
    }


    public function initialise():Void{

    }

}
