package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class InventoryView extends FlxSprite
{
	private var model : Inventory;

	public function new(X:Float, Y:Float, inventory : Inventory) 
	{
		super(X, Y);
		
		this.makeGraphic(16, 64, FlxColor.GRAY);
		
		this.model = inventory;
	}
	
	override function update() : Void
	{
		super.update();
	}
	
}