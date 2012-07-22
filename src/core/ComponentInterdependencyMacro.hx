package core;

import haxe.macro.Type;
import haxe.macro.Expr;

typedef ComponentField = {
    var field : Field;
    var typeName : String;
}

class ComponentInterdependencyMacro {
    @:macro public static function build() : Array<Field> {

        var context = haxe.macro.Context;
        var pos = context.currentPos();


        var localClass = context.getLocalClass().get();
        var accessClass : String = localClass.name;

        var superClass : ClassType;
        // superClass should never be of type EntityComponent
        // but it can be anything else to provide common stuff for Components

        var superClassRef = localClass.superClass;
        if (superClassRef != null){
            superClass = superClassRef.t.get();
            if(superClass.meta.has("accessClass")){

                trace(" Components should not extends another Components, if they need common stuff they can extends Class which are not themselves Components");
                return null;
            }

        }


        for (intfaceRef in localClass.interfaces){
            var intface  = intfaceRef.t.get();
            var accessClassFound = false;
            if (intface.meta.has("accessClass")){
                if (accessClassFound){
                    context.error("Cannot have multiple interface as accessClass", pos);
                    return null;
                }
                accessClass = intface.name;
                accessClassFound = true;
                trace(intface.module);
                trace("ACCESS CLASS : " + accessClass);
                break;
            }
        }



        var constructor : Field;
        var constructorPosition : Position;
        var constructorExprs : Array<Expr>;
        var requiredComponentField : Field;

        var requiredFields : Array<ComponentField> = new Array();


        var fields = context.getBuildFields();
        for (field in fields){
            for(meta in field.meta){
                if (meta.name == "owner"){
                    requiredFields.push({field : field, typeName : ""});
                }
            }
            if (field.name == "new"){
                constructor = field;
                constructorPosition = constructor.pos;
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

        if (constructor == null){
            return null;
        }

        addRequiredComponents(context, constructor, constructorExprs, requiredFields);

        var attachExpr : Expr;
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

            exprString += "owner = entity;";
            exprString += "return " + accessClass + ";\n";

            exprString += "}\n";

            attachExpr =  context.parse(exprString, constructorPosition);
        }
        else
        {
            trace(accessClass);
            attachExpr = context.parse("{owner = entity; return " + accessClass + ";}", constructorPosition);
        }

        var attachFunction = {
        ret : TPath({ sub:null, name:"Class", pack:[], params:[
        TPType(TPath({ sub:null, name:"Dynamic", pack:[], params:[] }))
        ]}),
        params : [],
        expr : attachExpr,
        args : [{value : null, type : TPath({ sub:null, name:"Entity", pack:["core"], params:[] }), opt : false, name :"entity"}] };

        fields.push({ name : "attach", doc : null, meta : null, access : [APublic], kind : FFun(attachFunction), pos : pos });



        var detachFunction = {
        ret : TPath({ sub:null, name:"Void", pack:[], params:[]}),
        params : [],
        expr : context.parse("{owner = null;}", constructorPosition),
        args : [] };

        fields.push({ name : "detach", doc : null, meta : null, access : [APublic], kind : FFun(detachFunction), pos : pos });


        var ownerProp = FProp("default", "null", TPath({ sub:null, name:"Entity", pack:["core"], params:[]}));
        fields.push({ name : "owner", doc : null, meta : null, access : [APublic], kind : ownerProp, pos : pos });


        //Array<Class<Dynamic>>

        var requiredComponentProp = FProp("default", "null", TPath({ sub:null, name:"Array", pack:[], params:[
            TPType(TPath({ sub:null, name:"Class", pack:[], params:[
                TPType(TPath({ sub:null, name:"Dynamic", pack:[], params:[] }))
            ]}))
        ]}));
        fields.push({ name : "requiredComponents", doc : null, meta : null, access : [APublic], kind : requiredComponentProp, pos : pos });

        return fields;
    }

    private static function addRequiredComponents(context, constructor, constructorExprs, requiredFields : Array<ComponentField>):Void{

        var componentClasses = new Array<String>();

        for (requiredField in requiredFields){
            switch(requiredField.field.kind){
                case FieldType.FVar( complexType, expr ):
                    switch (complexType){
                        case TPath(typePath):
                            var nn = "";
                            if (typePath.pack.length >0) nn = typePath.pack.join(".") + ".";
                            requiredField.typeName = nn + typePath.name;
                            componentClasses.push(requiredField.typeName);
                        default : trace("not a TypePath");
                    }

                case FieldType.FProp( get, set, complexType, expr ):
                    switch (complexType){
                        case TPath(typePath):
                            var nn = "";
                            if (typePath.pack.length >0) nn = typePath.pack.join(".") + ".";
                            requiredField.typeName = nn + typePath.name;
                            componentClasses.push(requiredField.typeName);
                        default : trace("not a TypePath");
                    }
                case FieldType.FFun( func ): trace("func cannot be components");
            }
        }

        if (componentClasses.length > 0){
            var componentClassArray = "[" + componentClasses.join(",") + "]";
            trace(componentClassArray);
            var posInfos = context.getPosInfos(constructor.pos);
            var nextPos = context.makePosition({min:posInfos.max , max:posInfos.max+1, file:posInfos.file});
            var newExpr = context.parseInlineString("requiredComponents = " + componentClassArray + "", nextPos);
            constructorExprs.push(newExpr);
        }

    }
}
