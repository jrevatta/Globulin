package
{
	import flash.display.Bitmap;
	
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.core.starling.StarlingState;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	import citrus.utils.objectmakers.ObjectMaker2D;
	import citrus.view.starlingview.AnimationSequence;
	import citrus.input.controller;

	
	import feathers.core.FeathersControl;
	
	import starling.core.Starling;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	
	public class GameState extends  StarlingState
	{
		
		
		//[Embed(source="globulin_0.png")]
		//private var globulin:Class;
		
		[Embed(source="run3.png")]
		private var heroAnimBitmap:Class;
		
		[Embed(source="run3.xml",mimeType="application/octet-stream")]
		private var heroAnimXML:Class;
		
		
		[Embed(source="bacteria_0.png")]
		private var bacteria:Class;
		
		[Embed(source="mapa6.tmx", mimeType="application/octet-stream")]
		private var tileMap:Class;
		
		[Embed(source="tilemap_05.png")]
		private var tileView:Class;

		
		[Embed(source="moneda.png")]
		private var moneda:Class;
		//override public function 
	
	
		
		public function GameState()
		{
			super();
			var objects:Array = [Hero, Platform, Enemy, Coin];
		}
		

			
		override public function initialize(): void
		{
			super.initialize();
			
			var physics: Box2D = new Box2D("box2d");
			//physics.visible = true;
			
			add(physics);
			
			
			var bitmapView:Bitmap = new tileView();
			bitmapView.name = "tilemap_05.png";
			
			ObjectMaker2D.FromTiledMap(XML(new tileMap()),[bitmapView]);
			
			/*
			
			var floor:Platform = new Platform("floor",{x:512, y:748, width: 1024, height:40});
			floor.view = new Quad(1024, 40, 0X00000);			
			add(floor);
			
			var p1:Platform = new Platform("p1", {x:874, y:151, width:300, height:40});
			p1.view = new Quad(300,40, 0x00000);
			add(p1);
			
			var hero:Hero = new Hero("hero", {x:50, y:50, width:70, height:70});
			*/
			var hero:Hero = getObjectByName("hero") as Hero;
			hero.jumpHeight = 13;
			
			var ta:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new heroAnimBitmap()),XML(new heroAnimXML()));
			var animationSeq:AnimationSequence = new AnimationSequence(ta,["hurt","idle","jump","walk"],"idle",24);			
			hero.view = animationSeq;
			
		
			
			//add(hero);
			
			//var enemy:Enemy = new Enemy("enemy", {x:900, y:700, height:70, leftBound:10, rightBound:1000}); 
			var enemy:Enemy = getObjectByName("enemy") as Enemy;
			enemy.view = new bacteria();
			enemy.leftBound = 10;
			enemy.rightBound = 1000;
			enemy.x = 400;
			enemy.y = 700;
			
			//add(enemy);
			
			//add(Coin);
			var coin:Coin = getObjectByName("coin") as Coin;
			coin.view = new moneda();
			coin.onBeginContact.add(function(c:b2Contact):void{
				trace("score up!");
				
			
			});
			
		
			
		}
		
		override public function update(timeDelta:Number):void{
			super.update(timeDelta);
			//aqui controlamos los limites del escenario.
			var hero:Hero = getObjectByName("hero") as Hero;
			if (hero.x <= 0) hero.x = 10;
			if (hero.x >= 1024) hero.x = 1004;	

				
		}
		
		
	}
}