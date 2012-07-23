package systems;

import core.SystemComponent;
import components.ViewComponent;
import renderer.Renderer;
import core.Model;
import core.Entity;
import components.PositionComponent;
import components.GenericViewComponent;

@entities(['components.ViewComponent', 'components.PositionComponent'])
class View implements SystemComponent{

    @owner
    private var backgroundComponent : BackgroundComponent;

    private var _renderer : Renderer;

    public function new(renderer : Renderer) {
        _renderer = renderer;
    }

    public function update(dt : Float) : Void
    {
        _renderer.clear();
        backgroundComponent.draw();
        for (entity in entities){
            var viewComponent : ViewComponent = entity.get(ViewComponent);
            viewComponent.draw(_renderer);
        }
    }

}
