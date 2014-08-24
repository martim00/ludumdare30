package;

import flixel.addons.text.FlxTypeText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	private var gamePurposeStarted:Bool = false;
	private var gamePurpose:FlxTypeText;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		// Set a background color
		FlxG.cameras.bgColor = 0xff131c1b;
		
		var square:FlxSprite = new FlxSprite(10, 10);
		square.makeGraphic(FlxG.width - 20, FlxG.height - 76, 0xff333333);
		
		gamePurpose = new FlxTypeText(15, 10, FlxG.width - 30, "You were separated and now you need to stay together.\n\n'Space' switch between the players\n'X' send a gift to the other\nArrow keys to move\n\n\nPress 'Enter' to start...", 16, true);
		
		gamePurpose.delay = 0.05;
		gamePurpose.showCursor = true;
		gamePurpose.cursorBlinkSpeed = 1.0;
		gamePurpose.autoErase = true;
		gamePurpose.waitTime = 2.0;
		gamePurpose.setTypingVariation(0.75, true);
		//gamePurpose.useDefaultSound = true;
		gamePurpose.color = 0x8811EE11;
		gamePurpose.skipKeys = ["SPACE"];
						
		add(gamePurpose);
		
		super.create();
	}
		
	private function onComplete(Text:String):Void
	{
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
				
		if (FlxG.keys.anyJustPressed(["ENTER"]))
		{
			FlxG.camera.fade(FlxColor.WHITE,.33, false, function() {
				FlxG.switchState(new PlayState());
			});
		}
		
		if (!gamePurposeStarted) {
			gamePurposeStarted = true;
			gamePurpose.start();
		}
	}	
}