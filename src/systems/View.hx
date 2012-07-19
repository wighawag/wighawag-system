package systems;

import renderer.Renderer;
import core.Model;
import core.Entity;
import components.PositionComponent;
import components.GenericViewComponent;

class View extends AbstractSystem{

    private var _renderer : Renderer;

    public function new(model : Model, renderer : Renderer) {
        super(model, [GenericViewComponent, PositionComponent]);

        _renderer = renderer;

    }

    override public function update(dt : Float) : Void
    {
        _renderer.clear();
        for (entity in _entities){
            var viewComponent : GenericViewComponent = entity.get(GenericViewComponent);
            viewComponent.draw(_renderer);
        }
    }

}
