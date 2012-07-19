package components;
import renderer.Renderer;
class ViewComponent extends EntityComponent {
    public function new(?requiredComponents : Array<Class<Dynamic>>) {
        super(requiredComponents, ViewComponent);
    }

    public function draw(renderer:Renderer):Void {
        // TO OVERRIDE
    }
}
