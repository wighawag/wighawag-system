package components;
import renderer.Renderer;
class ViewComponent extends EntityComponent {
    public function new() {
        super(ViewComponent);
    }

    public function draw(renderer:Renderer):Void {
        // TO OVERRIDE
    }
}
