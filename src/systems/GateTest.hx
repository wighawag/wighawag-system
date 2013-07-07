/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package systems;
import wighawag.system.Entity;
import wighawag.system.InGate;
import wighawag.system.OutGate;
import wighawag.system.SystemComponent;
class GateTest implements SystemComponent implements InGate implements OutGate{
    public function new() {
    }

    public function initialise():Void{

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
