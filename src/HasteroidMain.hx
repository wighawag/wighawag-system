package ;

import systems.GateTest;
import systems.Controller;
import systems.BackgroundComponent;
import systems.AISystem;
import systems.RandomEntityCreation;
import com.wighawag.system.Model;
import renderer.Renderer;
import systems.View;
import nme.display.Shape;
import nme.display.Bitmap;
import nme.display.BitmapData;
import haxe.Timer;
import nme.Lib;
import nme.display.Sprite;
import nme.events.Event;

//import mconsole.Printer;
//import mconsole.LogLevel;

class HasteroidMain extends Sprite{

    private var model : Model;

    private var lastUpdateTime : Float;

    public static function main() : Void{

        var app : HasteroidMain = new HasteroidMain();
        Lib.current.addChild(app);

        Console.start();

    }

    public function new() {
        super();
        lastUpdateTime = Timer.stamp();

        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(event : Event) : Void{
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

        var renderer = new Renderer(this);
        var view = new View(renderer);
        var entityCreation = new RandomEntityCreation(stage.stageWidth, stage.stageHeight);
        var aiSystem = new AISystem();
        var controllerSystem = new Controller();

        model = new Model();
        model.setup([new BackgroundComponent(), /*new GateTest(),*/ controllerSystem, view, entityCreation, aiSystem]);

        addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }


    private function onEnterFrame(event : Event) : Void{
        var now : Float = Timer.stamp();
        var dt = now - lastUpdateTime;
        model.update(dt);
    }
}
