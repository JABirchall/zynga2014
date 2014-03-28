package com.zynga.poker.minigame.minigameHelper
{
   import flash.display.DisplayObject;
   import com.zynga.text.EmbeddedFontTextField;
   
   public class MinigameUtils extends Object
   {
      
      public function MinigameUtils() {
         super();
      }
      
      public static const HIGHLOW:String = "HighLow";
      
      public static const _suits:Array = ["S","C","H","D"];
      
      public static const _cards:Array = ["A","K","2","3"];
      
      public static const fadeoutTime:Number = 0.25;
      
      public static const LOSE:String = "loss";
      
      public static const WIN:String = "win";
      
      public static const TIE:String = "tie";
      
      public static const REMATCH:String = "rematch";
      
      public static const RESUME:String = "resume";
      
      public static const GAME:String = "Game";
      
      public static const ERROR:String = "Error";
      
      public static const SELECTOR:String = "Selector";
      
      public static const PLAYERONE:String = "P1";
      
      public static const PLAYERTWO:String = "P2";
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
      
      public static const CARDFAN:String = "cardfan";
      
      public static const CARDINPLACE:String = "cardinplace";
      
      public static const MAX_PAYOUT:Number = 10000;
      
      public static const MAX_STREAK:Number = 20;
      
      public static const JS_ERROR:String = "JSError";
      
      public static const ALL_TIME_RECEIVED:String = "MiniGameAllTimeReceivedLimitError";
      
      public static const ALL_TIME_STARTED:String = "MiniGameAllTimeStartedLimitError";
      
      public static const GAME_ALREADY_START:String = "MiniGameAlreadyStartedError";
      
      public static const DAILY_RECEIVED:String = "MiniGameDailyReceivedLimitError";
      
      public static const GAME_RECEIVED:String = "MiniGameReceivedLimitError";
      
      public static const DAILY_STARTED:String = "MiniGameDailyStartedLimitError";
      
      public static const CHIP_LIMIT:String = "MiniGameChipLimitError";
      
      public static const CORRECTGUESS:String = "finish";
      
      public static const WRONGGUESS:String = "wrongGuess";
      
      public static const SELECTED_ACTION:String = "MINIGAME_ICON_SELECTED";
      
      public static function setObjectProperty(param1:DisplayObject, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void {
         param1.x = param2;
         param1.y = param3;
         param1.scaleX = param4;
         param1.scaleY = param5;
         param1.alpha = param6;
         param1.visible = true;
      }
      
      public static function setEmbeddedProperty(param1:DisplayObject, param2:EmbeddedFontTextField, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:String) : void {
         param1.x = param3;
         param1.y = param4;
         param1.scaleX = param5;
         param1.scaleY = param6;
         param1.alpha = param7;
         param1.visible = true;
         param2.text = param8;
      }
      
      public static function generateRandomCard() : String {
         return _cards[int(Math.random() * _cards.length)] + _suits[int(Math.random() * _suits.length)];
      }
      
      public static function generateName(param1:String, param2:int) : String {
         if(param1)
         {
            if(param1.length > param2)
            {
               return param1.slice(0,param2) + "...";
            }
            return param1;
         }
         return "";
      }
   }
}
