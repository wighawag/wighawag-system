package core;
import haxe.macro.Expr;
class ModelComponentMacro {
    @:macro public static function build() : Array<Field> {
        var context = haxe.macro.Context;
        var pos = context.currentPos();

        // get the Component Class
        var localClass = context.getLocalClass().get();

        // if it is an interface, skip as we are here implementing methods
        if (localClass.isInterface){
            return null;
        }

        // get the fields of the current class
        var fields = context.getBuildFields();


        var modelProp = FProp("default", "setModel", TPath({ sub:null, name:"Model", pack:["core"], params:[]}));
        fields.push({ name : "model", doc : null, meta : null, access : [APublic], kind : modelProp, pos : pos });

        var setModelPresent = false;
        for (field in fields){
            if (field.name == "setModel"){
                setModelPresent = true;
            }
        }
        if(!setModelPresent){
            fields.push(MacroHelper.createFunction(
                "setModel",
                [{name : "aModel", typeName : "core.Model"}],
                "core.Model",
                "{" +
                "model = aModel;" +
                "return model;" +
                "}"
            ));
        }


        return fields;
    }
}
