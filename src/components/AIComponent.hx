/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package components;

import wighawag.system.EntityComponent;

class AIComponent implements EntityComponent {

    @owner
    private var positionComponent : PositionComponent;

    public function new() {
    }

    public function initialise():Void{

    }

    public function update(dt : Float) : Void{
        positionComponent.x += 10;
        if (positionComponent.x > 200){
            positionComponent.x = 0;
        }
    }

}
