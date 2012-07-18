package hasteroid;

import nme.geom.Rectangle;
import nme.display.BitmapData;
import nme.display.BitmapData;
import components.PositionComponent;
import components.GraphicsComponent;
import hsl.haxe.Signaler;
import hsl.haxe.DirectSignaler;

class Model {


    public var entities : Array<Entity>;
    public var onEntityAdded : Signaler<Entity>;

    private var width : Int;
    private var height : Int;

    public function new(width : Int, height : Int) {

        this.width = width;
        this.height = height;
        entities = new Array<Entity>();
        onEntityAdded = new DirectSignaler<Entity>(this);

    }

    private var n : Int;
    public function update(dt : Float) : Void
    {
        if (n < 1000){
            n ++;
            var entity : Entity = createEntity();
            entities.push(entity);
            onEntityAdded.dispatch(entity);
        }
        else
        {
            for (entity in entities){
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
            //bitmapData.fillRect(new Rectangle(0,0,32,32),0xFF0000);
        }

        entity.add(new GraphicsComponent(bitmapData));
        entity.add(new PositionComponent(Math.random() * (width - 32), Math.random() * (height - 32)));
        return entity;
    }

}
