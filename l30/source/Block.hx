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
		
		this.collisonXDrag = false;
		
		makeGraphic(16, 16, color);
		//offset.x = -1;
		//offset.y = -1;
		
		//this.drag.x = 1;
	//	this.drag.y = 1;
		
	}
	
}