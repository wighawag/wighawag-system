/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package components;

import renderer.Renderer;
import flash.display.BitmapData;


class AnotherViewComponent implements ViewComponent{

    @owner
    private var positionComponent : PositionComponent;

    public var bitmapData : BitmapData;

    public function new(bitmapData : BitmapData) {
        this.bitmapData = new BitmapData(32,32, false, 0x00FF00);
    }

    public function initialise():Void{

    }

    public function draw(renderer:Renderer):Void {
        renderer.draw(bitmapData, Std.int(positionComponent.x), Std.int(positionComponent.y));
    }

}
