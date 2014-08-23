package ;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;


/**
 * ...
 * @author ...
 */
class Player extends FlxSprite
{
	private var idle : Bool = false;
	
	private var inventory : Inventory = new Inventory();

	public function new(X:Float=0, Y:Float=0, color : Int, idle : Bool) 
	{
		super(X, Y);
		this.makeGraphic(16, 16, color);
		maxVelocity.set(100, 200);
		acceleration.y = 200;
		drag.x = maxVelocity.x * 4;
		
		this.idle = idle;		
	}
	
	public function toggleIdle()
	{
		this.idle = !this.idle;
	}
	
	
	override function update() 
	{
		if (!idle) 
		{	
			// Player 1 controls
			acceleration.x = 0;
			
			if (FlxG.keys.pressed.LEFT)
			{
				acceleration.x = -maxVelocity.x * 4;
			}
			
			if (FlxG.keys.pressed.RIGHT)
			{
				acceleration.x = maxVelocity.x * 4;
			}	
			
			if (FlxG.keys.justPressed.UP && isTouchingFloor())
			{
				velocity.y -= maxVelocity.y / 1.5;
			}
			
			
			// clamp...
			if (x >= Constants.LEVEL_WIDTH - this.width)
			{
				x = Constants.LEVEL_WIDTH - this.width;
			}
			
			if (x < Constants.LEVEL_BEGIN_X )
			{
				x = Constants.LEVEL_BEGIN_X ;
			}
			
			
		} else {
			velocity.x = 0;
		}
		
		
		super.update();
	}
	
	public function getInventory() : Inventory
	{
		return this.inventory;
	}
	
	function isTouchingFloor() 
	{	
		return velocity.y == 0;
	}
	
	
	
}