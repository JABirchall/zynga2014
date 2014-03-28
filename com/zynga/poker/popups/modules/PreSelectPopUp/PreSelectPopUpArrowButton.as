package com.zynga.poker.popups.modules.PreSelectPopUp
{
   import flash.display.MovieClip;
   import com.zynga.poker.PokerClassProvider;
   
   public class PreSelectPopUpArrowButton extends MovieClip
   {
      
      public function PreSelectPopUpArrowButton(param1:uint=1) {
         super();
         this.assets = PokerClassProvider.getObject("preSelectArrow") as MovieClip;
         this.graphics.beginFill(8355711);
         if(param1 == ORIENTATION_LEFT)
         {
            this.graphics.drawRoundRectComplex(0,0,35,50,0,5,0,5);
            this.assets.x = 10;
            this.assets.y = 12;
         }
         else
         {
            this.graphics.drawRoundRectComplex(0,0,35,50,5,0,5,0);
            this.assets.rotation = 180;
            this.assets.x = 25;
            this.assets.y = 38;
         }
         this.graphics.endFill();
         addChild(this.assets);
         this.buttonMode = true;
      }
      
      public static const ORIENTATION_LEFT:uint = 1;
      
      public static const ORIENTATION_RIGHT:uint = 2;
      
      public var assets:MovieClip;
   }
}
