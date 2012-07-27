package systems;

import com.wighawag.system.Entity;
import com.wighawag.system.SystemComponent;
import components.ViewComponent;
import renderer.Renderer;

@entities(['components.ViewComponent', 'components.PositionComponent'])
class View implements SystemComponent{

    @owner
    private var backgroundComponent : BackgroundComponent;

    private var _renderer : Renderer;

    public function new(renderer : Renderer) {
        _renderer = renderer;
    }

    public function onEntityRegistered(entity : Entity) : Void{

    }

    public function onEntityUnregistered(entity : Entity) : Void{

    }

    public function update(dt : Float) : Void
    {
        _renderer.clear();
        backgroundComponent.draw();
        for (entity in registeredEntities){
            var viewComponent : ViewComponent = entity.get(ViewComponent);
            viewComponent.draw(_renderer);
        }
    }

}
