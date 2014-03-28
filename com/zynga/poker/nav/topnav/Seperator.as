package com.zynga.poker.nav.topnav
{
   import flash.display.Sprite;
   import com.zynga.draw.ComplexBox;
   
   public class Seperator extends Sprite
   {
      
      public function Seperator() {
         var _loc1_:ComplexBox = null;
         var _loc2_:ComplexBox = null;
         super();
         _loc1_ = new ComplexBox(1,30,657930,{"type":"rect"});
         _loc1_.y = -15;
         _loc1_.x = -1;
         _loc1_.alpha = 1;
         addChild(_loc1_);
         _loc2_ = new ComplexBox(1,30,3620416,{"type":"rect"});
         _loc2_.y = -15;
         _loc2_.x = 0;
         _loc2_.alpha = 1;
         addChild(_loc2_);
      }
   }
}
