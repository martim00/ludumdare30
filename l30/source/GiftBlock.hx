package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class GiftBlock extends FlxSprite
{
	private var levelWidth : Int;
	
	public function new(X:Float=0, Y:Float=0, levelWidth : Int) 
	{
		super(X, Y);
		
		//solid = immovable = true;
		solid = true;
		acceleration.y = Constants.GRAVITY;
		
		makeGraphic(16, 16, FlxColor.YELLOW);	
		
		maxVelocity.set(100, 200);
		drag.x = maxVelocity.x * 3;	
		
		this.levelWidth = levelWidth;
	}
	
	override function update() : Void
	{
		
		// clamp...
		if (x >= levelWidth - this.width)
		{
			x = levelWidth - this.width;
		}
		
		if (x < Constants.LEVEL_BEGIN_X )
		{
			x = Constants.LEVEL_BEGIN_X ;
		}
			
		super.update();
	}
	
}