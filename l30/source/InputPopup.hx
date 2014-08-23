package ;

import flixel.addons.ui.FlxUIPopup;
import flixel.addons.ui.FlxUIText;



/**
 * ...
 * @author ...
 */
class InputPopup extends FlxUIPopup
{
	public override function create():Void {
		_xml_id = "popup_input";
		
		super.create();
		
		var title:FlxUIText = cast _ui.getAsset("title");
		var body:FlxUIText = cast _ui.getAsset("body");
		
		title.text = "No path found -- first run?";
		body.text = "Please browse to your game's assets folder.";
	}
	
	#if sys
		public override function getEvent(id:String, sender:Dynamic, data:Array<Dynamic>, ?params:Array<Dynamic>):Void {
			if (params != null) {
				switch(id) {
					case "click_button":
						var param0:String = Std.string(params[0]);
						if (param0 == "browse") {
							//var path:String = Dialogs.folder("Browse to your game's assets folder!", "MESSAGE!");
							
							//FlxUI.event("choose_path", this, path);
							var parent = castParent();
							close();
							if (parent != null) {
								//parent.getEvent("choose_path", this, path);
							}
						}
				}
			}
		}
	#end
}