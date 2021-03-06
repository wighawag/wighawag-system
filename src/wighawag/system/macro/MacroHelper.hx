/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.system.macro;
import haxe.macro.Expr;
using StringTools;

class MacroHelper {


    public static function createFunction(name : String, args : Array<{name : String, typeName : String}>, returnType : String, exprString : String, ?access : Array<Access>) : Field {
        if (access == null){
            access = [APrivate];
        }

        var context = haxe.macro.Context;
        var pos = context.currentPos();
        var expr = context.parse(exprString, pos);

        var argsArray = [];
        for (arg in args){
            argsArray.push({value : null, type : TPath({ sub:null, name:breakType(arg.typeName).name, pack:breakType(arg.typeName).pack, params:[] }), opt : false, name :arg.name});
        }

        var func = {
        ret : TPath({ sub:null, name:breakType(returnType).name, pack:breakType(returnType).pack, params:[]}),
        params : [],
        expr : expr,
        args : argsArray
        };
        return { name : name, doc : null, meta : null, access : access, kind : FFun(func), pos : pos };


    }

    public static function breakType(typeName : String) : {pack : Array<String>, name : String}{

        if (typeName.lastIndexOf(".") == -1){
            return {pack : [], name : typeName};
        }
        var t = {pack : [], name : ""};
        t.name = typeName.substring(typeName.lastIndexOf(".") + 1);
        t.pack = typeName.substring(0,typeName.lastIndexOf(".") ).split(".");
        return t;
    }
}
