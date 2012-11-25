package systems;
import com.wighawag.system.Updatable;
import com.wighawag.system.SystemComponent;
import test.components.TestComponent;
import components.AnotherViewComponent;
import components.AIComponent;
import com.wighawag.system.Model;
import com.wighawag.system.Entity;
import com.wighawag.system.ComponentOwner;
import components.PositionComponent;
import components.GenericViewComponent;
import nme.display.BitmapData;

class RandomEntityCreation implements SystemComponent, implements Updatable{

    private var width : Int;
    private var height : Int;

    private var n : Int;

    public function new(width : Int, height : Int) {
        this.width = width;
        this.height = height;
        this.n = 0;
    }

    public function initialise():Void{

    }

    public function onEntityRegistered(entity : Entity) : Void{

    }

    public function onEntityUnregistered(entity : Entity) : Void{

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
        if (n ==3){
            entity.setup([
            new AIComponent(),
            new PositionComponent(Math.random() * (width - 32), Math.random() * (height - 32)),
            new TestComponent()
            ]);
            return entity;
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
