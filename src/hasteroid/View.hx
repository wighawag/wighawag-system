package hasteroid;

import components.PositionComponent;
import components.GraphicsComponent;
class View {

    private var _model : Model;
    private var _renderer : Renderer;

    public function new(model : Model, renderer : Renderer) {
        _model = model;
        _renderer = renderer;

        _model.onEntityAdded.bind(onEntityAdded);
    }

    private function onEntityAdded(entity : Entity) : Void{

    }


    public function update() : Void
    {
        _renderer.clear();
        var entities : Array<Entity> = _model.entities;
        for (entity in entities){
            var graphicsComponent : GraphicsComponent = entity.get(GraphicsComponent);
            var positComponent : PositionComponent = entity.get(PositionComponent);
            _renderer.draw(graphicsComponent.bitmapData, Std.int(positComponent.x), Std.int(positComponent.y));
        }
    }
}
