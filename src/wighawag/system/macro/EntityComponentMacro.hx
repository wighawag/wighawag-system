package wighawag.system.macro;
import haxe.macro.Expr;


class EntityComponentMacro {
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


        var constructor : Field;
        var constructorExprs : Array<Expr>;

        var requiredFields : Array<ComponentField> = new Array();

        for (field in fields){
            for(meta in field.meta){
                if (meta.name == "entityType"){
                    switch(field.kind){
                        case FieldType.FVar( complexType, expr ):
                            switch (complexType){
                                case TPath(typePath):
                                    var fullName = "";
                                    if (typePath.pack.length >0) fullName = typePath.pack.join(".") + ".";
                                    requiredFields.push({fieldName : field.name, typeName : fullName + typePath.name});
                                default : trace("not a TypePath");
                            }
                        case FieldType.FProp( get, set, complexType, expr ):
                            switch (complexType){
                                case TPath(typePath):
                                    var fullName = "";
                                    if (typePath.pack.length >0) fullName = typePath.pack.join(".") + ".";
                                    requiredFields.push({fieldName : field.name, typeName : fullName + typePath.name});
                                default : trace("not a TypePath");
                            }

                        case FieldType.FFun( func ): trace("func cannot be components");
                    }
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

        }

        // if there is no constructor
        if (constructor == null){
            context.error("Component need to have a constructor", pos);
            return null;
        }

        // add the required components to the requiredComponents instance field so that the ComponentOwner can check teh dependencies
        addRequiredComponents(constructorExprs, requiredFields);

        var entityProp = FProp("default", "null", TPath({ sub:null, name:"Entity", pack:["wighawag","system"], params:[]}));
        fields.push({ name : "entity", doc : null, meta : null, access : [APublic], kind : entityProp, pos : pos });


        var exprString = "{";
        exprString += "var missingComponents : Array<Class<Dynamic>> = new Array();";


        for (requiredField in requiredFields){
            exprString += "" + requiredField.fieldName + " = anEntity.type.get(" + requiredField.typeName + ");\n";
            exprString += "if ("+ requiredField.fieldName +" == null){\n";
            exprString += "missingComponents.push(" + requiredField.typeName + ");\n";
            exprString += "}\n";
        }


        exprString += "if (missingComponents.length >0){\n";
        // TODO disabel message should be outside
        exprString += '  trace("" + Type.getClass(this) + " disabled as the entity type does not have these required components " + missingComponents);\n';
        exprString += "  return false;\n";
        exprString += "}\n";

        exprString += "entity = anEntity;";
        exprString += "return true;\n";

        exprString += "}\n";

        fields.push(MacroHelper.createFunction(
            "attachEntity",
            [{name : "anEntity", typeName : "wighawag.system.Entity"}],
            "Bool",
            exprString,
            [APublic]
        ));

        fields.push(MacroHelper.createFunction(
            "detachEntity",
            [],
            "Void",
            "{" +
            "entity = null;" +
            "}",
            [APublic]
        ));

        var requiredTypeComponentProp = FProp("default", "null", TPath({ sub:null, name:"Array", pack:[], params:[
        TPType(TPath({ sub:null, name:"Class", pack:[], params:[
        TPType(TPath({ sub:null, name:"Dynamic", pack:[], params:[] }))
        ]}))
        ]}));
        fields.push({ name : "requiredTypeComponents", doc : null, meta : null, access : [APublic], kind : requiredTypeComponentProp, pos : pos });

        return fields;
    }

    private static function addRequiredComponents(constructorExprs, requiredFields : Array<ComponentField>):Void{

        var context = haxe.macro.Context;
        var pos = context.currentPos();

        var componentClasses = new Array<String>();

        for (requiredField in requiredFields){
            componentClasses.push(requiredField.typeName);
        }

        if (componentClasses.length > 0){
            var componentClassArray = "[" + componentClasses.join(",") + "]";
            trace(componentClassArray);
            var newExpr = context.parseInlineString("requiredTypeComponents = " + componentClassArray + "", pos);
            constructorExprs.push(newExpr);
        }

    }
}
