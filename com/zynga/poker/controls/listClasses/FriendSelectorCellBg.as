package com.zynga.poker.controls.listClasses
{
   import flash.display.Sprite;
   import com.zynga.draw.Box;
   
   public class FriendSelectorCellBg extends Sprite
   {
      
      public function FriendSelectorCellBg() {
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         this.useHandCursor = false;
         var _loc1_:Object = new Object();
         _loc1_.colors = [16777215,13421772,6710886];
         _loc1_.alphas = [1,1,1];
         _loc1_.ratios = [0,248,248];
         var _loc2_:Box = new Box(WIDTH,HEIGHT,_loc1_,false);
         addChild(_loc2_);
      }
      
      public static var WIDTH:Number = 238;
      
      public static var HEIGHT:Number = 59;
   }
}
