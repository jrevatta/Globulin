package
{
	//import flash.display.Sprite;
	
	import citrus.core.starling.StarlingCitrusEngine;
	
	[SWF(width="1024", height = "768", frameRate="60", backgroundcolor="#CCCCCC")]
	public class globulin_citrus01 extends StarlingCitrusEngine
	{
		public function globulin_citrus01()
		{
			setUpStarling();
			state = new GameState();
			
			
		}
	}
}