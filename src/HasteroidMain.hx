package ;

import systems.AISystem;
import systems.RandomEntityCreation;
import core.Model;
import renderer.Renderer;
import systems.View;
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
    private var entityCreation : RandomEntityCreation;
    private var aiSystem : AISystem;

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

        model = new Model();

        renderer = new Renderer(this);
        view = new View(model, renderer);
        entityCreation = new RandomEntityCreation(model, stage.stageWidth, stage.stageHeight);
        aiSystem = new AISystem(model);

        addEventListener(Event.ENTER_FRAME, onEnterFrame);
        #if flash
            addEventListener(Event.RENDER, onRender);
        #end
    }


    private function onEnterFrame(event : Event) : Void{

        var now : Float = Timer.stamp();
        var dt = now - lastTime;
        entityCreation.update(dt);
        aiSystem.update();
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
