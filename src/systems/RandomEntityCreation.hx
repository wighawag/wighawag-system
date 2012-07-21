package systems;
import components.AnotherViewComponent;
import components.AIComponent;
import core.Model;
import core.Entity;
import components.PositionComponent;
import components.GenericViewComponent;
import nme.display.BitmapData;
class RandomEntityCreation extends AbstractSystem {

    private var width : Int;
    private var height : Int;

    public function new(model: Model, width : Int, height : Int) {
        super(model);

        this.width = width;
        this.height = height;
    }

    private var n : Int;
    override public function update(dt : Float) : Void
    {
        if (n < 1000){
            n ++;
            var entity : Entity = createEntity();
            _model.add(entity);
        }
        else
        {
            for (entity in _entities){
                var positionComponent = entity.get(PositionComponent);
                positionComponent.x = Math.random() * (width - 32);
                positionComponent.y = Math.random() * (height - 32);
            }

        }

    }

    private var bitmapData : BitmapData;
    private function createEntity() : Entity{
        var entity : Entity = new Entity();

        if (bitmapData == null){
            bitmapData = new BitmapData(32,32, false, 0xFF0000);
        }
        entity.initialise([
            new AIComponent(),
            new PositionComponent(Math.random() * (width - 32), Math.random() * (height - 32)),
            new AnotherViewComponent(bitmapData)
        ]);
        return entity;
    }

}
