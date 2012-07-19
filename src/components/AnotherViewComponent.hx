package components;

import renderer.Renderer;
import nme.display.BitmapData;


class AnotherViewComponent extends ViewComponent{

    public var bitmapData : BitmapData;
    public function new(bitmapData : BitmapData) {
        super([PositionComponent]);
        this.bitmapData = new BitmapData(32,32, false, 0x00FF00);
    }

    override public function draw(renderer:Renderer):Void {
        var positComponent : PositionComponent = owner.get(PositionComponent);
        renderer.draw(bitmapData, Std.int(positComponent.x), Std.int(positComponent.y));
    }
}
