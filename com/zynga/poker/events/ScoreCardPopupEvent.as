package com.zynga.poker.events
{
   public class ScoreCardPopupEvent extends PopupEvent
   {
      
      public function ScoreCardPopupEvent(param1:String, param2:Object=null) {
         this.zid = param1;
         this.userData = param2;
         super(ScoreCardPopupEvent.TYPE_SHOW_SCORECARD);
      }
      
      public static const TYPE_SHOW_SCORECARD:String = "ScoreCardPopupEvent.showScoreCard";
      
      public var zid:String;
      
      public var userData:Object;
   }
}
