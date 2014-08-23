package ;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;

class WeddingState extends FlxState
{

	override public function create(): Void
	{
		FlxG.mouse.visible = false;		
		FlxG.cameras.bgColor = FlxColor.BEIGE;
		
		new FlxTimer(2.0, onEndState, 3);
	}
		
	private function onEndState(Timer:FlxTimer): Void
	{
		FlxG.camera.fade(FlxColor.WHITE,.33, false, function() {
				FlxG.switchState(new PlayState());
			});	
	}	
}