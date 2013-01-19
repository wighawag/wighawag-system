package com.wighawag.system;

interface EntityTypeComponent implements Component {
    public function populateEntity(entityComponents : Array<EntityComponent>) : Void;
}
