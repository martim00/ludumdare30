package ;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.util.FlxSpriteUtil;
import flixel.FlxG;
import flixel.util.FlxColor;


/**
 * ...
 * @author ...
 */
class Player extends FlxSprite
{
	private var idle : Bool = false;
	public var id : Int;	
	
	private var bounds : FlxSprite;

	public function new(X:Float=0, Y:Float=0, color : Int, idle : Bool, id : Int) 
	{
		super(X, Y);
		this.makeGraphic(16, 16, color);
		bounds = new FlxSprite(X, Y).makeGraphic(18, 18);		
		
		
		maxVelocity.set(100, 200);
		acceleration.y = Constants.GRAVITY;
		drag.x = maxVelocity.x * 4;	
		
		this.id = id;		
		this.idle = idle;		
	}
	
	public function toggleIdle()
	{
		this.idle = !this.idle;
	}
	
	public function isIdle() : Bool
	{
		return this.idle;
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
			acceleration.x = 0;
		}		
		
		this.bounds.x = x - 1;
		this.bounds.y = y - 1;
		
		super.update();
	}
	
	public function getBounds() : FlxSprite
	{
		return this.bounds;
	}
		
	function isTouchingFloor() : Bool
	{	
		return isTouching(FlxObject.FLOOR);
		//return velocity.y == 0;
	}
	
	
	
}