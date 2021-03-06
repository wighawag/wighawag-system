/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package systems;

import wighawag.system.Updatable;
import wighawag.system.Entity;
import wighawag.system.SystemComponent;
import components.ViewComponent;
import renderer.Renderer;

@entities(['components.ViewComponent', 'components.PositionComponent'])
class View implements SystemComponent implements Updatable{

    @owner
    private var backgroundComponent : BackgroundComponent;

    private var _renderer : Renderer;

    public function new(renderer : Renderer) {
        _renderer = renderer;
    }

    public function initialise():Void{

    }

    public function onEntityRegistered(entity : Entity) : Void{

    }

    public function onEntityUnregistered(entity : Entity) : Void{

    }

    public function update(dt : Float) : Void
    {
        _renderer.clear();
        backgroundComponent.draw();
        for (entity in registeredEntities){
            var viewComponent : ViewComponent = entity.get(ViewComponent);
            viewComponent.draw(_renderer);
        }
    }

}
