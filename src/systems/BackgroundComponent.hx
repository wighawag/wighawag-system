package systems;
import core.Component;

class BackgroundComponent implements Component {
    public function new() {
    }

    public function draw() : Void{
        trace("draw background");
    }
}
