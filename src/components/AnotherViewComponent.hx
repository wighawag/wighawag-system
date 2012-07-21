package components;

import core.Entity;
import renderer.Renderer;
import nme.display.BitmapData;


class AnotherViewComponent extends ViewComponent{

    @owner
    private var positionComponent : PositionComponent;

    public var bitmapData : BitmapData;

    public function new(bitmapData : BitmapData) {
        super();  // TODO make marco modify this corresponding to the fields with owner metadata
        this.bitmapData = new BitmapData(32,32, false, 0x00FF00);
    }

    override public function draw(renderer:Renderer):Void {
        renderer.draw(bitmapData, Std.int(positionComponent.x), Std.int(positionComponent.y));
    }

}
