package components;
import core.Entity;
import renderer.Renderer;
import nme.display.BitmapData;
class GenericViewComponent extends ViewComponent{

    @owner
    private var positionComponent : PositionComponent;

    public var bitmapData : BitmapData;

    public function new(bitmapData : BitmapData) {
        super();
        this.bitmapData = bitmapData;
    }

    override public function draw(renderer:Renderer):Void {
        renderer.draw(bitmapData, Std.int(positionComponent.x), Std.int(positionComponent.y));
    }

}
