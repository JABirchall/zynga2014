package com.zynga.poker.table.asset
{
   import flash.display.MovieClip;
   import com.zynga.poker.PokerClassProvider;
   
   public class HandIcon extends MovieClip
   {
      
      public function HandIcon() {
         super();
         this.handGfx = PokerClassProvider.getObject("handGfx");
         addChild(this.handGfx);
         this.handGfx.gotoAndStop(1);
      }
      
      private var handGfx:MovieClip;
      
      public function toggler(param1:Boolean) : void {
         if(param1)
         {
            this.handGfx.gotoAndStop(2);
         }
         else
         {
            if(!param1)
            {
               this.handGfx.gotoAndStop(1);
            }
         }
      }
   }
}
