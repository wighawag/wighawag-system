package components;

import haxe.macro.Expr;

class ComponentInterdependencyMacro {
    @:macro public static function build() : Array<Field> {

        var context = haxe.macro.Context;
        var pos = context.currentPos();

        var constructor : Field;
        var constructorExprs : Array<Expr>;
        var requiredComponentField : Field;

        var requiredFields : Array<{field : Field, typeName : String}> = new Array();


        var fields = context.getBuildFields();
        for (field in fields){
            for(meta in field.meta){
                if (meta.name == "owner"){
                    requiredFields.push({field : field, typeName : ""});
                }
            }
            if (field.name == "new"){
                constructor = field;
                switch(field.kind){
                    case FieldType.FFun( func ):
                        switch (func.expr.expr){
                            case EBlock(exprs): constructorExprs = exprs;
                            default : trace( "not a block ");
                        }

                    default : trace("constructor should be a function");
                }
            }
            else
            {
                trace(" - " + field.name);
            }

        }


        for (requiredField in requiredFields){
            switch(requiredField.field.kind){
                case FieldType.FVar( complexType, expr ):
                    switch (complexType){
                        case TPath(typePath): requiredField.typeName = typePath.name;
                        default : trace("not a TypePath");
                    }
                    addRequiredComponents(context, constructor, constructorExprs);
                case FieldType.FProp( get, set, complexType, expr ):
                    switch (complexType){
                        case TPath(typePath): requiredField.typeName = typePath.name;
                        default : trace("not a TypePath");
                    }
                    addRequiredComponents(context, constructor, constructorExprs);
                case FieldType.FFun( func ): trace("func cannot be components");
            }
        }

        // The check for missing components should not be necessary anymore as Entity does the checking
        if (requiredFields.length > 0) {
            var exprString = "{";
            exprString += "var missingComponents : Array<Class<Dynamic>> = new Array();";


            for (requiredField in requiredFields){
                exprString += "" + requiredField.field.name + " = entity.get(" + requiredField.typeName + ");\n";
                exprString += "if ("+ requiredField.field.name +" == null){\n";
                exprString += "missingComponents.push(" + requiredField.typeName + ");\n";
                exprString += "}\n";
            }


            exprString += "if (missingComponents.length >0){\n";
            exprString += '  trace("" + Type.getClass(this) + " disabled as the owner does not have these required components " + missingComponents);\n';
            exprString += "  return null;\n";
            exprString += "}\n";

            exprString += "return accessClass;\n";

            exprString += "}\n";

            var expr =  context.parse(exprString, constructor.pos);
            var func = {
                        ret : TPath({ sub:null, name:"Class", pack:[], params:[
                            TPType(TPath({ sub:null, name:"Dynamic", pack:[], params:[] }))
                            ]}),
                        params : [],
                        expr : expr,
                        args : [{value : null, type : TPath({ sub:null, name:"Entity", pack:[], params:[] }), opt : false, name :"entity"}] };
            fields.push({ name : "attach", doc : null, meta : null, access : [AOverride], kind : FFun(func), pos : pos });
        }

        return fields;
    }

    private static function addRequiredComponents(context, constructor, constructorExprs):Void{
        var posInfos = context.getPosInfos(constructor.pos);
        var nextPos = context.makePosition({min:posInfos.max , max:posInfos.max+1, file:posInfos.file});
        var newExpr = context.parseInlineString("requiredComponents = [PositionComponent]", nextPos);
        constructorExprs.push(newExpr);
    }
}
