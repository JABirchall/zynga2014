package com.zynga.poker.table.asset.chat
{
   import flash.display.MovieClip;
   import com.zynga.poker.PokerClassProvider;
   
   public class ChatIcon extends MovieClip
   {
      
      public function ChatIcon() {
         super();
         this.ci = PokerClassProvider.getObject("ChatIcon");
         addChild(this.ci);
         this.ciX = PokerClassProvider.getObject("ChatIconX");
         addChild(this.ciX);
         this.ciX.x = 2;
         this.ciX.y = 2;
      }
      
      public var ciX:MovieClip;
      
      public var ci:MovieClip;
   }
}
