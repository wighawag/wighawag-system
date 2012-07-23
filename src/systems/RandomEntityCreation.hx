package systems;
import core.SystemComponent;
import test.components.TestComponent;
import components.AnotherViewComponent;
import components.AIComponent;
import core.Model;
import core.Entity;
import core.ComponentOwner;
import components.PositionComponent;
import components.GenericViewComponent;
import nme.display.BitmapData;

class RandomEntityCreation implements SystemComponent{

    private var width : Int;
    private var height : Int;

    private var n : Int;

    public function new(width : Int, height : Int) {
        this.width = width;
        this.height = height;
        this.n = 0;
    }


    public function update(dt : Float) : Void
    {
        if (n < 1000){
            n ++;
            var entity : Entity = createEntity();
            model.addEntity(entity);
        }
        else
        {
            for (entity in registeredEntities){
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
        entity.setup([
            new AIComponent(),
            new PositionComponent(Math.random() * (width - 32), Math.random() * (height - 32)),
            new AnotherViewComponent(bitmapData),
            new TestComponent()
        ]);
        return entity;
    }

}
