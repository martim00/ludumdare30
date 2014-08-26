package ;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;

class EndState extends FlxState
{
	private var gamePurposeStarted:Bool = false;
	private var gamePurpose:FlxTypeText;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		// Set a background color
		FlxG.camera.bgColor = 0xFFCCCCFF;
		
		var square:FlxSprite = new FlxSprite(10, 10);
		square.makeGraphic(FlxG.width - 20, FlxG.height - 76, 0xff333333);
		
		gamePurpose = new FlxTypeText(15, 10, FlxG.width - 30, "This game was made for ludum dare 30 by martim00, xportation and fly\n\nThank you =D", 16, true);
		
		gamePurpose.delay = 0.03;
		gamePurpose.showCursor = true;
		gamePurpose.cursorBlinkSpeed = 1.0;
		gamePurpose.autoErase = true;
		gamePurpose.waitTime = 2.0;
		gamePurpose.setTypingVariation(0.75, true);
		gamePurpose.color = 0xFF802896;
		gamePurpose.skipKeys = ["SPACE"];
						
		add(gamePurpose);
		
		super.create();
	}
	
		override public function update():Void
	{
		super.update();
		
		if (!gamePurposeStarted) {
			gamePurposeStarted = true;
			gamePurpose.start();
		}
	}	
}