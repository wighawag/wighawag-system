package wighawag.system;

interface EntityTypeComponent extends Component {
    public function populateEntity(entityComponents : Array<EntityComponent>) : Void;
}
