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

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		this.makeGraphic(10, 10, FlxColor.BLUE);
		maxVelocity.set(100, 200);
		acceleration.y = 200;
		drag.x = maxVelocity.x * 4;
		
		//offset.set(1, 1);
		
		
	}
	
	override function update() 
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
		
		super.update();
	}
	
	function isTouchingFloor() 
	{	
		return velocity.y == 0;
	}
	
	
	
}