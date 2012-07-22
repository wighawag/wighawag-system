package systems;
import core.ModelComponent;
import core.Component;

class BackgroundComponent implements ModelComponent {
    public function new() {
    }

    public function draw() : Void{
        trace("draw background");
    }
}
