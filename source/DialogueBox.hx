package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'allegro':
				FlxG.sound.playMusic(Paths.music('sound1'), 0);
				FlxG.sound.music.fadeIn(1, 0, 1);
			case 'moderato':
				FlxG.sound.playMusic(Paths.music('sound2'), 0);
				FlxG.sound.music.fadeIn(1, 0, 1);
			case 'finale':
				FlxG.sound.playMusic(Paths.music('sound3'), 0);
				FlxG.sound.music.fadeIn(1, 0, 1);
		}

		switch(PlayState.SONG.song.toLowerCase())
		{
			case 'allegro':
				bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFa14423);
			case 'moderato':
				bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFF6f2544);
			case 'finale':
				bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFF3c6a6f);	
			default:
				bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		}
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

			case 'allegro':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('boxx');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 30, false);
				box.animation.addByIndices('normal', 'Speech Bubble Normal Open', [13], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 325;

			case 'moderato':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('boxx2');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 30, false);
				box.animation.addByIndices('normal', 'Speech Bubble Normal Open', [13], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 325;

			case 'finale':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('boxx3');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 30, false);
				box.animation.addByIndices('normal', 'Speech Bubble Normal Open', [13], "", 24);	
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 325;
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns')
			{
				portraitLeft = new FlxSprite(-20, 40);
				portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
				portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
				portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
				portraitLeft.updateHitbox();
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				portraitLeft.visible = false;
			}
	
		else if (PlayState.SONG.song.toLowerCase()=='allegro' || PlayState.SONG.song.toLowerCase()=='moderato' || PlayState.SONG.song.toLowerCase()=='finale')
			{
				portraitLeft = new FlxSprite(100, 12);
				portraitLeft.frames = Paths.getSparrowAtlas('robot_portraits');
				portraitLeft.animation.addByPrefix('enter1', 'frame base', 24, false);
				portraitLeft.animation.addByPrefix('enter2', 'frame 2', 24, false);
				portraitLeft.animation.addByPrefix('enter3', 'frame 3', 24, false);
				portraitLeft.animation.addByPrefix('enter4', 'frame 4', 24, false);
				portraitLeft.animation.addByPrefix('enter5', 'frame 5', 24, false);
				portraitLeft.animation.addByPrefix('enter6', 'frame 6', 24, false);
				portraitLeft.animation.addByPrefix('enter7', 'frame 7', 24, false);
				portraitLeft.animation.addByPrefix('enter8', 'frame 8', 24, false);
				portraitLeft.animation.addByPrefix('enter9', 'frame 9', 24, false);
				portraitLeft.animation.addByPrefix('enter10', 'frame evil', 24, false);
				portraitLeft.animation.addByPrefix('enter11', 'frame 11', 24, false);
				portraitLeft.setGraphicSize(Std.int(portraitLeft.width * 1));
				portraitLeft.updateHitbox();
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				portraitLeft.visible = false;
			}


		if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns')
			{
				portraitRight = new FlxSprite(0, 40);
				portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
				portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
				portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
				portraitRight.updateHitbox();
				portraitRight.scrollFactor.set();
				add(portraitRight);
				portraitRight.visible = false;
			}	

		else if (PlayState.SONG.song.toLowerCase()=='allegro' || PlayState.SONG.song.toLowerCase()=='moderato' || PlayState.SONG.song.toLowerCase()=='finale')
			{
					portraitRight = new FlxSprite(230, 130);
					portraitRight.frames = Paths.getSparrowAtlas('boyfriendPortrait');
					portraitRight.animation.addByPrefix('enter', 'Portrait Enter instance 1', 24, false);
					portraitRight.setGraphicSize(Std.int(portraitRight.width * 0.75));
					portraitRight.updateHitbox();
					portraitRight.scrollFactor.set();
					add(portraitRight);
					portraitRight.visible = false;
			}	
		
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns')
				portraitLeft.screenCenter(X);

		if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns')
			{
				handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
				add(handSelect);
			}
		else if (PlayState.SONG.song.toLowerCase()=='allegro' || PlayState.SONG.song.toLowerCase()=='moderato' || PlayState.SONG.song.toLowerCase()=='finale')
			{
				handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('al-textbox'));
				add(handSelect);
			}


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns')
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)]
		else if (PlayState.SONG.song.toLowerCase()=='allegro' || PlayState.SONG.song.toLowerCase()=='moderato' || PlayState.SONG.song.toLowerCase()=='finale')
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('allegroText'), 0.6)];
			add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.visible = false;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
		{
			remove(dialogue);
				
			if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns')
				FlxG.sound.play(Paths.sound('clickText'), 0.8)
			else if (PlayState.SONG.song.toLowerCase()=='allegro' || PlayState.SONG.song.toLowerCase()=='moderato' || PlayState.SONG.song.toLowerCase()=='finale')
				FlxG.sound.play(Paths.sound('allegroEnter'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			
			case 'same':
				portraitLeft.visible = true;
			case 'al1':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter1');
				}
				else portraitLeft.animation.play('enter1');
			case 'al2':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter2');
				}
				else portraitLeft.animation.play('enter2');
			case 'al3':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter3');
				}
				else portraitLeft.animation.play('enter3');
			case 'al4':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter4');
				}
				else portraitLeft.animation.play('enter4');
			case 'al5':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter5');
				}
				else portraitLeft.animation.play('enter5');
			case 'al6':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter6');
				}
				else portraitLeft.animation.play('enter6');
			case 'al7':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter7');
				}
				else portraitLeft.animation.play('enter7');
			case 'al8':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter8');
				}	
				else portraitLeft.animation.play('enter8');
			case 'al9':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter9');
				}
				else portraitLeft.animation.play('enter9');
			case 'al10':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter10');
				}
				else portraitLeft.animation.play('enter10');
			case 'al11':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter11');
				}				
				else portraitLeft.animation.play('enter11');
			case 'bf':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
