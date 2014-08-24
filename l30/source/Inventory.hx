package ;
import flixel.group.FlxTypedGroup;

/**
 * ...
 * @author ...
 */
class Inventory
{
	private var items : FlxTypedGroup<Gift> = new FlxTypedGroup<Gift>();

	public function new() 
	{
		
	}
	
	public function addItem(item : Gift) : Void
	{
		items.add(item);
	}
	
}