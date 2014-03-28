package com.zynga.poker.controls.listClasses
{
   import flash.display.Sprite;
   import com.zynga.draw.Box;
   
   public class FriendSelectorTileListSkin extends Sprite
   {
      
      public function FriendSelectorTileListSkin() {
         super();
         var _loc1_:Object = new Object();
         _loc1_.colors = [16777215];
         _loc1_.alphas = [1];
         var _loc2_:Box = new Box(WIDTH,HEIGHT,_loc1_,false);
         addChild(_loc2_);
      }
      
      public static var WIDTH:Number = 50;
      
      public static var HEIGHT:Number = 50;
   }
}
