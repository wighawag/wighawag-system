package renderer;

import flash.geom.Point;
import flash.geom.Rectangle;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

class Renderer {

    private var _sprite : Sprite;
    private var _bitmapData : BitmapData;
    private var _bitmap : Bitmap;

    public function new(sprite : Sprite) {
        _sprite = sprite;


        _bitmapData = new BitmapData(sprite.stage.stageWidth, sprite.stage.stageHeight,false, 0x00);

        _bitmap = new Bitmap(_bitmapData);
        _sprite.addChild(_bitmap);
    }

    private var rectangle : Rectangle;
    private var point : Point;
    public function draw(bitmapData : BitmapData, x : Int, y : Int) : Void{
        if (rectangle == null) {
            rectangle = new Rectangle();
        }
        if (point == null){
            point = new Point();
        }

        rectangle.width = bitmapData.width;
        rectangle.height = bitmapData.height;
        point.x = x;
        point.y = y;
        _bitmapData.copyPixels(bitmapData, rectangle, point);
    }

    public function clear() : Void{
        _bitmapData.fillRect(new Rectangle(0,0,_bitmapData.width, _bitmapData.height), 0x000001); // 1 (nt black since html5 assume white
    }

}
