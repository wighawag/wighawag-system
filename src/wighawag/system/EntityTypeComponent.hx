/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.system;

interface EntityTypeComponent extends Component {
    public function populateEntity(entityComponents : Array<EntityComponent>) : Void;
}
