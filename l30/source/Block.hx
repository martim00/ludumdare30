package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class Block extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0, color : Int) 
	{
		super(X, Y);
		
		solid = immovable = true;
		
		makeGraphic(16, 16, color);
		
		
	}
	
}