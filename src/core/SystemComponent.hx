package core;

interface SystemComponent implements ModelComponent {
    public var model(default, setModel) : Model;
    public function update(dt : Float) : Void;
}
