package com.zynga.poker.table.asset
{
   import flash.display.MovieClip;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.poker.PokerClassProvider;
   
   public class InviteInbox extends MovieClip
   {
      
      public function InviteInbox(param1:int) {
         super();
         mouseChildren = false;
         this.enve = PokerClassProvider.getObject("InviteInbox");
         this.enve.scaleX = this.enve.scaleY = 0.6;
         addChild(this.enve);
         this.count = new EmbeddedFontTextField("","Main",15,0,"center");
         this.count.width = 40;
         this.count.height = 28;
         this.count.x = -20;
         this.count.y = -11;
         addChild(this.count);
         this.count.text = param1.toString();
      }
      
      public var count:EmbeddedFontTextField;
      
      public var enve:MovieClip;
   }
}
