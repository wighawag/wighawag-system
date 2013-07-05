package components;

import wighawag.system.EntityComponent;
import renderer.Renderer;

@accessClass
interface ViewComponent extends EntityComponent {
    public function draw(renderer:Renderer):Void;
}
