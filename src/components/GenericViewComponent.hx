package components;
import renderer.Renderer;
import nme.display.BitmapData;
class GenericViewComponent implements ViewComponent{

    @owner
    private var positionComponent : PositionComponent;

    public var bitmapData : BitmapData;

    public function new(bitmapData : BitmapData) {
        this.bitmapData = bitmapData;
    }

    public function initialise():Void{

    }

    public function draw(renderer:Renderer):Void {
        renderer.draw(bitmapData, Std.int(positionComponent.x), Std.int(positionComponent.y));
    }

}
