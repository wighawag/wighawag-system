/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package systems;
import wighawag.system.Updatable;
import wighawag.system.SystemComponent;
import test.components.TestComponent;
import components.AnotherViewComponent;
import components.AIComponent;
import wighawag.system.Model;
import wighawag.system.Entity;
import wighawag.system.ComponentOwner;
import components.PositionComponent;
import components.GenericViewComponent;
import flash.display.BitmapData;

class RandomEntityCreation implements SystemComponent implements Updatable{

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
