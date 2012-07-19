package core;

import hsl.haxe.Signaler;
import hsl.haxe.DirectSignaler;

class Model {

    public var entities : Array<Entity>;
    public var onEntityAdded : Signaler<Entity>;
    public var onEntityRemoved : Signaler<Entity>;

    public function new(){
        entities = new Array<Entity>();
        onEntityAdded = new DirectSignaler<Entity>(this);
        onEntityRemoved = new DirectSignaler<Entity>(this);

    }

    public function add(entity : Entity) : Void
    {
        entities.push(entity);
        onEntityAdded.dispatch(entity);
    }

    public function remove(entity : Entity) : Void
    {
        var removed : Bool = entities.remove(entity);
        if (removed){
            onEntityRemoved.dispatch(entity);
        }
    }

}
