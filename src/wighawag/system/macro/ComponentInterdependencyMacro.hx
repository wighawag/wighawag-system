/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.system.macro;

import haxe.macro.Type;
import haxe.macro.Expr;


class ComponentInterdependencyMacro {
    @:macro public static function build() : Array<Field> {

        var context = haxe.macro.Context;
        var pos = context.currentPos();

        // get the Component Class
        var localClass = context.getLocalClass().get();

        // if it is an interface, skip as we are here implementing methods
        if (localClass.isInterface){
            return null;
        }

        // Make sure the component does not extend other components
        var superClass : ClassType;
        var superClassRef = localClass.superClass;
        if (superClassRef != null){
            superClass = superClassRef.t.get();


            var errorMessage = "Components cannot extends another Component, if they need common stuff they can both extends a Class which is not itself a Component";

            var superFields = superClass.fields.get();
            for (superField in superFields){
                if (superField.name == "owner" ){
                    context.error(errorMessage, pos);
                    return null;
                }
            }
            if(superClass.meta.has("accessClass")){
                context.error(errorMessage, pos);
                return null;
            }
        }

        // get the accessClass from the interfaces if available
        // the accessClass allow to hide implementation details of components by accessing it through an interface Definition
        var accessClass : String = null;
        for (intfaceRef in localClass.interfaces){
            var intface  = intfaceRef.t.get();
            if (intface.meta.has("accessClass")){
                if (accessClass != null){
                    context.error("Cannot have multiple interfaces as accessClass", pos);
                    return null;
                }
                accessClass = intface.name;
            }
        }

        // fall back on itself
        if (accessClass == null){
            accessClass = localClass.name;
        }



        var constructor : Field;
        var constructorExprs : Array<Expr>;

        var requiredFields : Array<ComponentField> = new Array();

        // get the fields of the current class
        var fields = context.getBuildFields();

        // find any components dependencies (@owner) and save them
        // find the constructor and get the expression to modify it later
        for (field in fields){
            for(meta in field.meta){
                if (meta.name == "owner"){
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


        // implement attach so that it assing the component field to the corresponding sibling components from the owner
        var attachExpr : Expr;
        // The check for missing components should not be necessary anymore as ComponentOwner does the checking
        if (requiredFields.length > 0) {
            var exprString = "{";
            exprString += "var missingComponents : Array<Class<Dynamic>> = new Array();";


            for (requiredField in requiredFields){
                exprString += "" + requiredField.fieldName + " = componentOwner.get(" + requiredField.typeName + ");\n";
                exprString += "if ("+ requiredField.fieldName +" == null){\n";
                exprString += "missingComponents.push(" + requiredField.typeName + ");\n";
                exprString += "}\n";
            }


            exprString += "if (missingComponents.length >0){\n";
            exprString += '  trace("" + Type.getClass(this) + " disabled as the owner does not have these required components " + missingComponents);\n';
            exprString += "  return null;\n";
            exprString += "}\n";

            exprString += "owner = componentOwner;";
            exprString += "return " + accessClass + ";\n";

            exprString += "}\n";

            attachExpr =  context.parse(exprString, pos);
        }
        else
        {
            trace(accessClass);
            attachExpr = context.parse("{owner = componentOwner; return " + accessClass + ";}", pos);
        }

        var attachFunction = {
        ret : TPath({ sub:null, name:"Class", pack:[], params:[
            TPType(TPath({ sub:null, name:"Dynamic", pack:[], params:[] }))
        ]}),
        params : [],
        expr : attachExpr,
        args : [{value : null, type : TPath({ sub:null, name:"ComponentOwner", pack:["wighawag","system"], params:[] }), opt : false, name :"componentOwner"}] };

        fields.push({ name : "attach", doc : null, meta : null, access : [APublic], kind : FFun(attachFunction), pos : pos });



        var detachFunction = {
        ret : TPath({ sub:null, name:"Void", pack:[], params:[]}),
        params : [],
        expr : context.parse("{owner = null;}", pos),
        args : [] };

        fields.push({ name : "detach", doc : null, meta : null, access : [APublic], kind : FFun(detachFunction), pos : pos });


        var ownerProp = FProp("default", "null", TPath({ sub:null, name:"ComponentOwner", pack:["wighawag","system"], params:[]}));
        fields.push({ name : "owner", doc : null, meta : null, access : [APublic], kind : ownerProp, pos : pos });


        var requiredComponentProp = FProp("default", "null", TPath({ sub:null, name:"Array", pack:[], params:[
            TPType(TPath({ sub:null, name:"Class", pack:[], params:[
                TPType(TPath({ sub:null, name:"Dynamic", pack:[], params:[] }))
            ]}))
        ]}));
        fields.push({ name : "requiredComponents", doc : null, meta : null, access : [APublic], kind : requiredComponentProp, pos : pos });

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
            var newExpr = context.parseInlineString("requiredComponents = " + componentClassArray + "", pos);
            constructorExprs.push(newExpr);
        }

    }
}
