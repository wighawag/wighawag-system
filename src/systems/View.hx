package systems;

import core.SystemComponent;
import components.ViewComponent;
import renderer.Renderer;
import core.Model;
import core.Entity;
import components.PositionComponent;
import components.GenericViewComponent;

class View extends AbstractSystem, implements SystemComponent{

    @owner
    private var backgroundComponent : BackgroundComponent;

    private var _renderer : Renderer;

    public function new(renderer : Renderer) {
        super([ViewComponent, PositionComponent]);

        _renderer = renderer;

    }

    public function update(dt : Float) : Void
    {
        // TODO remove this :
        if (!initialised && owner != null){
            setModel(cast owner);
            initialised = true;
        }

        _renderer.clear();
        backgroundComponent.draw();
        for (entity in _entities){
            var viewComponent : ViewComponent = entity.get(ViewComponent);
            viewComponent.draw(_renderer);
        }
    }

}
