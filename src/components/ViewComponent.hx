package components;

import com.wighawag.system.EntityComponent;
import renderer.Renderer;

@accessClass
interface ViewComponent implements EntityComponent {
    public function draw(renderer:Renderer):Void;
}
