package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class GiftBlock extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		
		//solid = immovable = true;
		solid = true;
		
		makeGraphic(16, 16, FlxColor.YELLOW);
		
		maxVelocity.set(100, 200);
		drag.x = maxVelocity.x * 3;	
		//offset.x = -1;
	}
	
}