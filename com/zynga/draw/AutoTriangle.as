package com.zynga.draw
{
   import flash.display.Sprite;
   
   public class AutoTriangle extends Sprite
   {
      
      public function AutoTriangle() {
         super();
      }
      
      public static function make(param1:uint, param2:int=6) : Sprite {
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.beginFill(param1,1);
         _loc3_.graphics.lineTo(param2,param2 / 2);
         _loc3_.graphics.lineTo(0,param2);
         _loc3_.graphics.lineTo(0,0);
         _loc3_.graphics.endFill();
         return _loc3_;
      }
      
      public static function makeLeft(param1:uint, param2:int=6) : Sprite {
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.beginFill(param1,1);
         _loc3_.graphics.lineTo(param2,param2 / 2);
         _loc3_.graphics.lineTo(param2,-param2 / 2);
         _loc3_.graphics.lineTo(0,0);
         _loc3_.graphics.endFill();
         return _loc3_;
      }
   }
}
