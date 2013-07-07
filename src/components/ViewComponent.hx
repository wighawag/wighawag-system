/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package components;

import wighawag.system.EntityComponent;
import renderer.Renderer;

@accessClass
interface ViewComponent extends EntityComponent {
    public function draw(renderer:Renderer):Void;
}
