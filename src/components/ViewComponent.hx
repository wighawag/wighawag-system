package components;

import core.Component;
import renderer.Renderer;

@accessClass
interface ViewComponent implements Component {
    public function draw(renderer:Renderer):Void;
}
