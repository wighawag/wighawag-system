package systems;

import renderer.Renderer;
import core.Model;
import core.Entity;
import components.PositionComponent;
import components.GenericViewComponent;

class View extends AbstractSystem{

    private var _renderer : Renderer;

    public function new(model : Model, renderer : Renderer) {
        super(model);

        _renderer = renderer;

    }

    public function update() : Void
    {
        _renderer.clear();
        for (entity in _entities){
            var viewComponent : GenericViewComponent = entity.get(GenericViewComponent);
            var positComponent : PositionComponent = entity.get(PositionComponent);
            _renderer.draw(viewComponent.bitmapData, Std.int(positComponent.x), Std.int(positComponent.y));
        }
    }

    override private function hasRequiredComponents(entity : Entity) : Bool{
        return entity.get(GenericViewComponent) != null && entity.get(PositionComponent) != null;
    }

}
