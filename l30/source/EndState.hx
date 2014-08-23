package ;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;

class EndState extends FlxState
{

	override public function create(): Void
	{
		FlxG.mouse.visible = false;		
		FlxG.cameras.bgColor = FlxColor.CYAN;
	}
	
}