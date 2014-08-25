package ;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.addons.effects.FlxGlitchSprite;

class WeddingState extends FlxState
{
	private var glitch:FlxGlitchSprite;
	
	override public function create(): Void
	{
		#if flash //flash only works with mp3 files
		FlxG.sound.playMusic(AssetPaths.play_state_song__mp3, 1, true);
		#else //for martim that compiles for neko
		FlxG.sound.playMusic(AssetPaths.play_state_song__ogg, 1, true);
		#end
				
		var target:FlxSprite = new FlxSprite(0, 0, AssetPaths.wedding__png);		
		glitch = new FlxGlitchSprite(target);
		add(glitch);
								
		FlxG.mouse.visible = false;
		
		new FlxTimer(1.0, onEndState);
		
		super.create();
	}
		
	private function onEndState(Timer:FlxTimer): Void
	{
		FlxG.camera.fade(FlxColor.WHITE,.33, false, function() {
				FlxG.switchState(new MenuState());
			});	
	}	
}