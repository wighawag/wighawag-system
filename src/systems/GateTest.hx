package systems;
import com.wighawag.system.Entity;
import com.wighawag.system.InGate;
import com.wighawag.system.OutGate;
import com.wighawag.system.SystemComponent;
class GateTest implements SystemComponent, implements InGate, implements OutGate{
    public function new() {
    }

    public function onEntityRegistered(entity:Entity):Void {
    }

    public function onEntityUnregistered(entity:Entity):Void {
    }

    public function canAdd(entity:Entity):Bool {
        return false;
    }

    public function canRemove(entity:Entity):Bool {
        return false;
    }


}
