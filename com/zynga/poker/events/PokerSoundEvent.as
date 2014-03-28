package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class PokerSoundEvent extends Event
   {
      
      public function PokerSoundEvent(param1:String, param2:String="", param3:*=null) {
         super(ON_SOUND_REQUEST);
         this.handler = param1;
         this.controlName = param2;
         this.controlValue = param3;
      }
      
      public static const ON_SOUND_REQUEST:String = "onSoundRequest";
      
      public static const GROUP_SCRATCHERS:String = "scratchers";
      
      public static const GROUP_TABLE:String = "table";
      
      public static const GROUP_VIDEO_POKER:String = "videoPoker";
      
      public static const GROUP_SLOTS:String = "slots";
      
      public static const SCRATCHERS_WIN:String = "onScratchersWin";
      
      public static const SCRATCHERS_LOST:String = "onScratchersLose";
      
      public static const SCRATCHERS_SCRATCH:String = "onScratchersScratchCard";
      
      public static const TABLE_CARD_FLIP:String = "soundCardFlip";
      
      public static const TABLE_DEAL:String = "playSound_Deal";
      
      public static const TABLE_SHUFFLE:String = "onShuffle";
      
      public static const TABLE_CALL:String = "sndCall";
      
      public static const TABLE_FOLD:String = "FOLD_PRESSED";
      
      public static const TABLE_RAISE:String = "sndRaise";
      
      public static const TABLE_YOU_WIN:String = "sndYouWin";
      
      public static const TABLE_YOU_LOSE:String = "sndYouLose";
      
      public static const TABLE_WIN_CHIPS:String = "sndWinChips";
      
      public static const TABLE_CHECK:String = "sndCheck";
      
      public static const TABLE_GASP:String = "sndGasp";
      
      public static const TABLE_TURN_START:String = "sndTurnStart";
      
      public static const TABLE_REMIND:String = "PlayRemindSound";
      
      public static const TABLE_HURRY:String = "playHurrySound";
      
      public static const TABLE_USER_LOST:String = "onUserLost";
      
      public static const VIDEO_POKER_CLICK:String = "VP_Click";
      
      public static const VIDEO_POKER_DEAL:String = "VP_Deal";
      
      public static const VIDEO_POKER_FLIP:String = "VP_Flip";
      
      public static const VIDEO_POKER_HITOM:String = "VP_Hitom";
      
      public static const VIDEO_POKER_HOLD:String = "VP_Hold";
      
      public static const VIDEO_POKER_LOSE:String = "VP_Lose";
      
      public static const VIDEO_POKER_LOWTOM:String = "VP_Lowtom";
      
      public static const VIDEO_POKER_POP:String = "VP_Pop";
      
      public static const VIDEO_POKER_SIMPLE_CLICK:String = "VP_SimpleClick";
      
      public static const VIDEO_POKER_SWOOSH:String = "VP_Swoosh";
      
      public static const VIDEO_POKER_WIN:String = "VP_Win";
      
      public static const SLOTS_WIN:String = "sndSlotsWin";
      
      public static const SLOTS_PULL:String = "sndSlotsPull";
      
      public static const SLOTS_REEL_ONE:String = "sndReelOne";
      
      public static const SLOTS_REEL_TWO:String = "sndReelTwo";
      
      public static const SLOTS_REEL_THREE:String = "sndReelThree";
      
      private static const SOUNDS_TABLE:Array;
      
      private static const SOUND_SCRATCHERS:Array;
      
      private static const SOUND_VIDEO_POKER:Array;
      
      private static const SOUND_HANDLERS:Array;
      
      private static const SOUND_SLOTS:Array;
      
      public static const CNAME_MUTE:String = "mute";
      
      public static const CNAME_MUTE_GROUP:String = "muteGroup";
      
      public static const CNAME_PANNING:String = "panning";
      
      public static const CNAME_PLAY:String = "play";
      
      public static const CNAME_PLAY_WITH_DELAY:String = "playWithDelay";
      
      public static const CNAME_PLAY_LOOPING:String = "playLooping";
      
      public static const CNAME_PLAY_LOOPING_WITH_DELAY:String = "playLoopingWithDelay";
      
      public static const CNAME_PLAY_SEQUENCE:String = "playSequence";
      
      public static const CNAME_STOP:String = "stop";
      
      public static const CNAME_STOP_GROUP:String = "stopGroup";
      
      public static const CNAME_VOLUME:String = "volume";
      
      public static const CNAME_FADE_IN:String = "fadeIn";
      
      public static const CNAME_FADE_OUT:String = "fadeOut";
      
      public static function getGroupByName(param1:String) : Array {
         var _loc2_:Array = null;
         switch(param1)
         {
            case GROUP_TABLE:
               _loc2_ = SOUND_HANDLERS[0];
               break;
            case GROUP_SCRATCHERS:
               _loc2_ = SOUND_HANDLERS[1];
               break;
            case GROUP_VIDEO_POKER:
               _loc2_ = SOUND_HANDLERS[2];
               break;
            case GROUP_SLOTS:
               _loc2_ = SOUND_HANDLERS[3];
               break;
         }
         
         return _loc2_;
      }
      
      public var handler:String;
      
      public var controlName:String;
      
      public var controlValue;
      
      override public function clone() : Event {
         return new PokerSoundEvent(this.handler,this.controlName,this.controlValue);
      }
      
      override public function toString() : String {
         return formatToString("PokerSoundEvent","type","bubbles","cancelable","eventPhase","handler");
      }
   }
}
