package core;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.Expr;
class SystemComponentMacro {
    @:macro public static function build() : Array<Field> {
        var context = haxe.macro.Context;
        var pos = context.currentPos();

        // get the Component Class
        var localClass = context.getLocalClass().get();

        // if it is an interface, skip as we are here implementing methods
        if (localClass.isInterface){
            return null;
        }

        var requiredEntityComponentsExprString = "[";
        if (localClass.meta.has("entities")){
            // TODO //trace(localClass.meta.get());
        }
        requiredEntityComponentsExprString += "]";


        // get the fields of the current class
        var fields = context.getBuildFields();

        var constructorExprs : Array<Expr>;
        // get the fields of the current class
        var fields = context.getBuildFields();
        for (field in fields){
            if (field.name == "new"){
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

        if (constructorExprs != null){
            var constructorExpr = "{" +
            "entities = new Array();"+
            "_entityRegistrar = new com.fermmtools.utils.ObjectHash();"+
            "_requiredEntityComponents = " + requiredEntityComponentsExprString  + ";" +
            "}";
            var newExpr = context.parse(constructorExpr, pos);
            constructorExprs.push(newExpr);
        }
        else
        {
            context.error("No Construcotr found", pos);
            return null;
        }


        var modelProp = FProp("default", "setModel", TPath({ sub:null, name:"Model", pack:["core"], params:[]}));
        fields.push({ name : "model", doc : null, meta : null, access : [APublic], kind : modelProp, pos : pos });



        fields.push(MacroHelper.createFunction(
            "setModel",
            [{name : "aModel", typeName : "core.Model"}],
            "core.Model",
            "{" +
            "model = aModel;" +
            "model.onEntityAdded.bind(onEntityAdded);" +
            "model.onEntityRemoved.bind(onEntityRemoved);" +
            "for (entity in model.entities){" +
            "onEntityAdded(entity);"  +
            "}" +
            "return model;" +
            "}"
        ));

        fields.push(MacroHelper.createFunction(
            "onEntityAdded",
            [{name : "entity", typeName : "core.ComponentOwner"}],
            "Void",
            "{" +
            "if (hasRequiredComponents(entity)){" +
            "    entities.push(entity);" +
                "_entityRegistrar.set(entity, true);"+
            "}"+
            "}"
        ));

        fields.push(MacroHelper.createFunction(
            "onEntityRemoved",
            [{name : "entity", typeName : "core.ComponentOwner"}],
            "Void",
            "{" +
            "if (_entityRegistrar.exists(entity))" +
            "{"+
            "    entities.remove(entity);"+
            "    _entityRegistrar.delete(entity);" +
            "}"+
            "}"
        ));

        fields.push(MacroHelper.createFunction(
            "hasRequiredComponents",
            [{name : "entity", typeName : "core.ComponentOwner"}],
            "Bool",
            "{" +
            "for (requiredComponent in _requiredEntityComponents){"+
            "if (entity.get(requiredComponent) == null){" +
            "return false;"+
            "}"+
            "}"+
            "return true;"+
            "}"
        ));


        var entitiesVar = FieldType.FVar(TPath({ sub:null, name:"Array", pack:[], params:[
            TPType(TPath({ sub:null, name:"ComponentOwner", pack:["core"], params:[] }))
        ]}));
        fields.push({ name : "entities", doc : null, meta : null, access : [APrivate], kind : entitiesVar, pos : pos });


        var requiredComponentsVar = FieldType.FVar(TPath({ sub:null, name:"Array", pack:[], params:[
            TPType(TPath({ sub:null, name:"Class", pack:[], params:[
                TPType(TPath({ sub:null, name:"Dynamic", pack:[], params:[] }))
            ] }))
        ]}));
        fields.push({ name : "_requiredEntityComponents", doc : null, meta : null, access : [APrivate], kind : requiredComponentsVar, pos : pos });


        var entityRegistrarVar = FieldType.FVar(TPath({ sub:null, name:"ObjectHash", pack:["com", "fermmtools", "utils"], params:[
            TPType(TPath({ sub:null, name:"ComponentOwner", pack:["core"], params:[] })),
            TPType(TPath({ sub:null, name:"Bool", pack:[], params:[] }))
        ]}));
        fields.push({ name : "_entityRegistrar", doc : null, meta : null, access : [APrivate], kind : entityRegistrarVar, pos : pos });

        return fields;

    }

}