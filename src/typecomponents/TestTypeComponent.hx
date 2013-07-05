package typecomponents;
import wighawag.system.EntityComponent;
import wighawag.system.EntityTypeComponent;
class TestTypeComponent implements EntityTypeComponent{

    public var testMessage : String;

    public function new(message : String) {
        this.testMessage = message;
    }

    public function initialise():Void{

    }

    public function populateEntity(entityComponents : Array<EntityComponent>) : Void{

    }

}
