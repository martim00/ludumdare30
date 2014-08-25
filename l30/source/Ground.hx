package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Ground extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0, width : Int) 
	{
		super(X, Y);
		
		solid = immovable = true;
		
		//makeGraphic(FlxG.width, 16, FlxColor.GREEN);
		makeGraphic(width, 16, FlxColor.GREEN);
	}
	
}