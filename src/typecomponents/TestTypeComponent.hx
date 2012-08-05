package typecomponents;
import com.wighawag.system.EntityTypeComponent;
class TestTypeComponent implements EntityTypeComponent{

    public var testMessage : String;

    public function new(message : String) {
        this.testMessage = message;
    }

}
