package com.zynga.poker
{
   import flash.events.EventDispatcher;
   import com.zynga.io.IExternalCall;
   import flash.xml.*;
   import com.zynga.poker.events.PokerSoundEvent;
   import flash.media.Sound;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.media.SoundTransform;
   import flash.media.SoundChannel;
   import com.greensock.TweenLite;
   import com.greensock.easing.Linear;
   import com.greensock.OverwriteManager;
   
   public class PokerSoundManager extends EventDispatcher
   {
      
      public function PokerSoundManager() {
         this.handlerMap = new Array();
         this.handlerIgnoreList = new Array();
         super();
      }
      
      private const PROPERTY_SOUND:int = 0;
      
      private const PROPERTY_CHANNEL:int = 1;
      
      private const PROPERTY_DELAY:int = 2;
      
      private const PROPERTY_FADE:int = 3;
      
      private const STATUS_STARTED:int = 0;
      
      private const STATUS_INDEX:int = 1;
      
      public var soundList:XMLList;
      
      public var urlSoundMap:Array;
      
      public var handlerMap:Array;
      
      public var aSound:Array;
      
      public var aSoundStatusLoaded:Array;
      
      public var debugMode:Boolean = false;
      
      private var loaderArr:Array;
      
      private var preloadHandler:String = "";
      
      private var bPreloadRandom:Boolean = false;
      
      private var preloadRandomIndex:int = 0;
      
      private var preloadMuteArr:Array;
      
      private var aSoundGroupNames:Array;
      
      private var handlerIgnoreList:Array;
      
      public var useIgnoreList:Boolean = false;
      
      public var soundXML:XML;
      
      public var externalInterface:IExternalCall;
      
      public function startPokerSoundManager(param1:String) : void {
         this.aSound = new Array();
         this.aSoundGroupNames = new Array();
         this.aSoundStatusLoaded = new Array();
         this.loaderArr = new Array();
         this.urlSoundMap = new Array();
         if(!param1 || (this.debugMode))
         {
            return;
         }
         var _loc2_:String = this.externalInterface.call(param1,"sounds");
         if(_loc2_)
         {
            this.soundXML = new XML(unescape(_loc2_));
            this.parse(this.soundXML);
            return;
         }
         throw new Error("sound xml was empty");
      }
      
      public function parse(param1:XML) : void {
         var _loc5_:XML = null;
         var _loc6_:String = null;
         var _loc7_:* = false;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:XMLList = param1.children();
         _loc2_ = 0;
         while(_loc2_ < _loc4_.length())
         {
            this.soundList = _loc4_[_loc2_].children();
            for each (_loc5_ in this.soundList)
            {
               _loc7_ = false;
               if(this.useIgnoreList)
               {
                  _loc3_ = 0;
                  while(_loc3_ < this.handlerIgnoreList.length)
                  {
                     if(_loc5_.attribute("handler") == this.handlerIgnoreList[_loc3_])
                     {
                        _loc7_ = true;
                        break;
                     }
                     _loc3_++;
                  }
               }
               if(!_loc7_)
               {
                  this.handlerMap.push(_loc5_.attribute("handler"));
                  if(this.urlSoundMap[_loc5_.attribute("handler")] == undefined)
                  {
                     this.urlSoundMap[_loc5_.attribute("handler")] = new Array();
                  }
                  if(_loc5_.attribute("random"))
                  {
                     this.urlSoundMap[_loc5_.attribute("handler")] = _loc5_.attribute("asset").split(",");
                  }
                  else
                  {
                     this.urlSoundMap[_loc5_.attribute("handler")].push(_loc5_.attribute("asset"));
                  }
               }
            }
            this.aSoundGroupNames[_loc2_] = _loc4_[_loc2_].localName();
            _loc6_ = this.aSoundGroupNames[_loc2_];
            this.aSoundStatusLoaded[_loc6_] = new Array();
            this.aSoundStatusLoaded[_loc6_][this.STATUS_STARTED] = false;
            this.aSoundStatusLoaded[_loc6_][this.STATUS_INDEX] = 0;
            _loc2_++;
         }
      }
      
      public function preloadSound(param1:String) : void {
         var _loc2_:int = this.aSoundStatusLoaded[param1][this.STATUS_INDEX];
         var _loc3_:Array = PokerSoundEvent.getGroupByName(param1);
         if(!_loc3_)
         {
            return;
         }
         if(_loc2_ < _loc3_.length)
         {
            this.preloadHandler = _loc3_[_loc2_];
            if(this.urlSoundMap[this.preloadHandler].length > 1)
            {
               this.bPreloadRandom = true;
            }
            else
            {
               this.bPreloadRandom = false;
            }
            this.fetchSound(this.urlSoundMap[this.preloadHandler],param1);
         }
      }
      
      public function loadSoundByGroup(param1:String) : void {
         var _loc2_:Array = PokerSoundEvent.getGroupByName(param1);
         if(!_loc2_ || (this.debugMode))
         {
            return;
         }
         if((this.aSoundStatusLoaded) && (this.aSoundStatusLoaded[param1]) && !this.aSoundStatusLoaded[param1][this.STATUS_STARTED])
         {
            if(!this.aSound[_loc2_[0]])
            {
               this.preloadSound(param1);
            }
         }
      }
      
      public function fetchSound(param1:Array, param2:String) : void {
         this.loaderArr[param2] = new Sound();
         this.loaderArr[param2].addEventListener(Event.COMPLETE,this.soundCache);
         if(this.bPreloadRandom)
         {
            this.loaderArr[param2].load(new URLRequest(param1[this.preloadRandomIndex]));
         }
         else
         {
            this.loaderArr[param2].load(new URLRequest(param1[0]));
         }
      }
      
      public function soundCache(param1:Event) : void {
         var _loc2_:String = null;
         var _loc5_:* = false;
         var _loc6_:Array = null;
         var _loc7_:SoundTransform = null;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < this.aSoundGroupNames.length)
         {
            _loc5_ = false;
            _loc2_ = this.aSoundGroupNames[_loc3_];
            _loc6_ = PokerSoundEvent.getGroupByName(_loc2_);
            if(_loc6_)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc6_.length)
               {
                  if(this.preloadHandler == _loc6_[_loc4_])
                  {
                     _loc5_ = true;
                     break;
                  }
                  _loc4_++;
               }
            }
            if(_loc5_)
            {
               break;
            }
            _loc3_++;
         }
         this.loaderArr[_loc2_].removeEventListener(Event.COMPLETE,this.soundCache);
         if(this.aSound[this.preloadHandler] == undefined)
         {
            this.aSound[this.preloadHandler] = new Array();
         }
         this.aSound[this.preloadHandler][this.PROPERTY_SOUND] = param1.target as Sound;
         this.aSound[this.preloadHandler][this.PROPERTY_CHANNEL] = new SoundChannel();
         this.aSound[this.preloadHandler][this.PROPERTY_DELAY] = new Object();
         this.aSound[this.preloadHandler][this.PROPERTY_DELAY].value = 0.0;
         this.aSound[this.preloadHandler][this.PROPERTY_FADE] = new Object();
         this.aSound[this.preloadHandler][this.PROPERTY_FADE].value = 0.0;
         if(this.preloadHandler == PokerSoundEvent.TABLE_TURN_START || this.preloadHandler == PokerSoundEvent.TABLE_REMIND || this.preloadHandler == PokerSoundEvent.TABLE_HURRY)
         {
            _loc7_ = new SoundTransform(0.1);
            this.aSound[this.preloadHandler][this.PROPERTY_CHANNEL].soundTransform = _loc7_;
         }
         if((this.preloadMuteArr) && this.preloadMuteArr[this.preloadHandler] == true)
         {
            this.muteSoundWithHandler(this.preloadHandler,this.preloadMuteArr[this.preloadHandler]);
         }
         if((this.bPreloadRandom) && this.preloadRandomIndex + 1 < this.urlSoundMap[this.preloadHandler].length)
         {
            this.preloadRandomIndex++;
            this.fetchSound(this.urlSoundMap[this.preloadHandler],_loc2_);
         }
         else
         {
            this.preloadRandomIndex = 0;
            this.aSoundStatusLoaded[_loc2_][this.STATUS_STARTED] = true;
            _loc8_[_loc9_] = this.aSoundStatusLoaded[_loc2_][this.STATUS_INDEX]+1;
            this.preloadSound(_loc2_);
         }
      }
      
      public function playSound(param1:String, param2:Boolean=false) : void {
         var loopValue:int = 0;
         var transform:SoundTransform = null;
         var startOffset:int = 0;
         var inHandler:String = param1;
         var inLooping:Boolean = param2;
         try
         {
            loopValue = inLooping?int.MAX_VALUE:0;
            transform = this.aSound[inHandler][this.PROPERTY_CHANNEL].soundTransform;
            startOffset = inLooping?1:0;
            this.aSound[inHandler][this.PROPERTY_CHANNEL] = this.aSound[inHandler][this.PROPERTY_SOUND].play(startOffset,loopValue,transform);
            this.aSound[inHandler][this.PROPERTY_DELAY].value = 0.0;
         }
         catch(e:Error)
         {
         }
      }
      
      public function directSoundPlay(param1:String, param2:Boolean=false, param3:Number=0.0) : void {
         var inHandler:String = param1;
         var inLooping:Boolean = param2;
         var inDelay:Number = param3;
         if(inDelay)
         {
            try
            {
               TweenLite.to(this.aSound[inHandler][this.PROPERTY_DELAY],inDelay,
                  {
                     "ease":Linear.easeNone,
                     "onComplete":this.playSound,
                     "onCompleteParams":[inHandler,inLooping],
                     "overwrite":OverwriteManager.NONE
                  });
            }
            catch(e:Error)
            {
            }
         }
         else
         {
            this.playSound(inHandler,inLooping);
         }
      }
      
      public function stopSoundWithHandler(param1:String) : void {
         var inHandler:String = param1;
         try
         {
            TweenLite.killTweensOf(this.aSound[inHandler][this.PROPERTY_DELAY]);
            this.aSound[inHandler][this.PROPERTY_DELAY].value = 0.0;
            TweenLite.killTweensOf(this.aSound[inHandler][this.PROPERTY_FADE]);
            this.aSound[inHandler][this.PROPERTY_FADE].value = 0.0;
            this.aSound[inHandler][this.PROPERTY_CHANNEL].stop();
         }
         catch(e:Error)
         {
         }
      }
      
      public function stopSoundWithGroup(param1:Array) : void {
         var _loc2_:* = 0;
         while(_loc2_ < param1.length)
         {
            this.stopSoundWithHandler(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function setSoundVolumeWithHandler(param1:String, param2:Number) : void {
         var inHandler:String = param1;
         var inVolume:Number = param2;
         var transform:SoundTransform = new SoundTransform(inVolume);
         try
         {
            this.aSound[inHandler][this.PROPERTY_CHANNEL].soundTransform = transform;
         }
         catch(e:Error)
         {
         }
      }
      
      public function fadeSoundInWithHandler(param1:String, param2:Number) : void {
         var inHandler:String = param1;
         var inDuration:Number = param2;
         try
         {
            this.aSound[inHandler][this.PROPERTY_FADE].value = 0.0;
            TweenLite.to(this.aSound[inHandler][this.PROPERTY_FADE],inDuration,
               {
                  "ease":Linear.easeNone,
                  "onStart":this.setSoundVolumeWithHandler,
                  "onStartParams":[inHandler,this.aSound[inHandler][this.PROPERTY_FADE].value],
                  "onUpdate":this.setSoundVolumeWithHandler,
                  "onUpdateParams":[inHandler,this.aSound[inHandler][this.PROPERTY_FADE].value],
                  "onComplete":this.setSoundVolumeWithHandler,
                  "onCompleteParams":[inHandler,this.aSound[inHandler][this.PROPERTY_FADE].value]
               });
         }
         catch(e:Error)
         {
         }
      }
      
      public function muteSoundWithHandler(param1:String, param2:Boolean=true) : void {
         var inHandler:String = param1;
         var inMute:Boolean = param2;
         var transform:SoundTransform = new SoundTransform();
         if(inMute)
         {
            transform.volume = 0.0;
         }
         else
         {
            if(this.preloadHandler == PokerSoundEvent.TABLE_TURN_START || this.preloadHandler == PokerSoundEvent.TABLE_REMIND || this.preloadHandler == PokerSoundEvent.TABLE_HURRY)
            {
               transform.volume = 0.1;
            }
            else
            {
               transform.volume = 1;
            }
         }
         try
         {
            TweenLite.killTweensOf(this.aSound[inHandler][this.PROPERTY_FADE]);
         }
         catch(e:Error)
         {
         }
         try
         {
            if(!this.aSound[inHandler])
            {
               if(!this.preloadMuteArr)
               {
                  this.preloadMuteArr = new Array();
               }
               if(inMute)
               {
                  this.preloadMuteArr[inHandler] = inMute;
               }
            }
            else
            {
               this.aSound[inHandler][this.PROPERTY_CHANNEL].soundTransform = transform;
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function muteSoundWithGroup(param1:Array, param2:Boolean=true) : void {
         var _loc3_:* = 0;
         while(_loc3_ < param1.length)
         {
            this.muteSoundWithHandler(param1[_loc3_],param2);
            _loc3_++;
         }
      }
      
      public function handlePokerSoundEvent(param1:PokerSoundEvent) : void {
         switch(param1.controlName)
         {
            case PokerSoundEvent.CNAME_MUTE:
               this.muteSoundWithHandler(param1.handler,Boolean(param1.controlValue));
               break;
            case PokerSoundEvent.CNAME_MUTE_GROUP:
               this.muteSoundWithGroup(PokerSoundEvent.getGroupByName(param1.handler),Boolean(param1.controlValue));
               break;
            case PokerSoundEvent.CNAME_PANNING:
               break;
            case PokerSoundEvent.CNAME_PLAY:
               this.directSoundPlay(param1.handler,false);
               break;
            case PokerSoundEvent.CNAME_PLAY_WITH_DELAY:
               this.directSoundPlay(param1.handler,false,Number(param1.controlValue));
               break;
            case PokerSoundEvent.CNAME_PLAY_LOOPING:
               this.directSoundPlay(param1.handler,true);
               break;
            case PokerSoundEvent.CNAME_PLAY_LOOPING_WITH_DELAY:
               this.directSoundPlay(param1.handler,true,Number(param1.controlValue));
               break;
            case PokerSoundEvent.CNAME_PLAY_SEQUENCE:
               break;
            case PokerSoundEvent.CNAME_STOP:
               this.stopSoundWithHandler(param1.handler);
               break;
            case PokerSoundEvent.CNAME_STOP_GROUP:
               this.stopSoundWithGroup(PokerSoundEvent.getGroupByName(param1.handler));
               break;
            case PokerSoundEvent.CNAME_VOLUME:
               this.setSoundVolumeWithHandler(param1.handler,Number(param1.controlValue));
               break;
            case PokerSoundEvent.CNAME_FADE_IN:
               this.fadeSoundInWithHandler(param1.handler,Number(param1.controlValue));
               break;
            case PokerSoundEvent.CNAME_FADE_OUT:
               break;
         }
         
      }
   }
}
