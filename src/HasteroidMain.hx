package ;

import core.SystemsEngine;
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
    private var systemManager : SystemsEngine;

    private var lastUpdateTime : Float;

    public static function main() : Void{
        var app : HasteroidMain = new HasteroidMain();
        Lib.current.addChild(app);
    }

    public function new() {
        super();
        lastUpdateTime = Timer.stamp();

        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(event : Event) : Void{
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

        model = new Model();

        var renderer = new Renderer(this);
        var view = new View(model, renderer);
        var entityCreation = new RandomEntityCreation(model, stage.stageWidth, stage.stageHeight);
        var aiSystem = new AISystem(model);

        systemManager = new SystemsEngine([entityCreation, aiSystem, view]);

        addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }


    private function onEnterFrame(event : Event) : Void{
        var now : Float = Timer.stamp();
        var dt = now - lastUpdateTime;
        systemManager.update(dt);
    }
}
