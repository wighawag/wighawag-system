package components;

import haxe.macro.Expr;

// TODO use some macros to ype safe the use of accessClass
class AccessClassMacro {
    @:macro public static function build() : Array<Field> {
        var pos = haxe.macro.Context.currentPos();
        var fields = haxe.macro.Context.getBuildFields();

        for (field in fields){
            if (field.name == "accessClass"){

            }
        }

        return fields;
    }
}
