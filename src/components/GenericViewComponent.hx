package components;
import core.Entity;
import renderer.Renderer;
import nme.display.BitmapData;
class GenericViewComponent extends ViewComponent{

    public var bitmapData : BitmapData;
    public function new(bitmapData : BitmapData) {
        super([PositionComponent]);
        this.bitmapData = bitmapData;
    }

    override public function draw(renderer:Renderer):Void {
        var positComponent : PositionComponent = owner.get(PositionComponent);
        renderer.draw(bitmapData, Std.int(positComponent.x), Std.int(positComponent.y));
    }

}