package ;

import hasteroid.Model;
import hasteroid.Renderer;
import hasteroid.View;
import nme.display.Shape;
import nme.display.Bitmap;
import nme.display.BitmapData;
import haxe.Timer;
import nme.Lib;
import nme.display.Sprite;
import nme.events.Event;

class HasteroidMain extends Sprite{

    private var model : Model;
    private var view : View;
    private var renderer : Renderer;

    private var lastTime : Float;

    public static function main() : Void{
        var app : HasteroidMain = new HasteroidMain();
        Lib.current.addChild(app);
    }

    public function new() {
        super();
        lastTime = Timer.stamp();

        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(event : Event) : Void{
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

        model = new Model(stage.stageWidth, stage.stageHeight);
        renderer = new Renderer(this);
        view = new View(model, renderer);

        addEventListener(Event.ENTER_FRAME, onEnterFrame);
        #if flash
            addEventListener(Event.RENDER, onRender);
        #end
    }


    private function onEnterFrame(event : Event) : Void{

        var now : Float = Timer.stamp();
        var dt = now - lastTime;
        model.update(dt);
        #if flash
            stage.invalidate();
        #else
            view.update();
        #end
    }

    #if flash
    private function onRender(event : Event) : Void{
        view.update();
    }
    #end

}
