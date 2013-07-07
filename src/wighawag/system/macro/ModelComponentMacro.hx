/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.system.macro;
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


        var setModelPresent = false;
        var modelPresent = false;
        for (field in fields){
            if (field.name == "set_model"){
                setModelPresent = true;
            }
            if (field.name == "model"){
                modelPresent = true;
            }
        }

        if (!modelPresent){
            var modelProp = FProp("default", "set", TPath({ sub:null, name:"Model", pack:["wighawag","system"], params:[]}));
            fields.push({ name : "model", doc : null, meta : null, access : [APublic], kind : modelProp, pos : pos });
        }

        if(!setModelPresent){
            fields.push(MacroHelper.createFunction(
                "set_model",
                [{name : "aModel", typeName : "wighawag.system.Model"}],
                "wighawag.system.Model",
                "{" +
                "model = aModel;" +
                "return model;" +
                "}"
            ));
        }


        return fields;
    }
}
