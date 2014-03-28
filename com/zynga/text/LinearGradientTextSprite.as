package com.zynga.text
{
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.display.Shape;
   import flash.display.BlendMode;
   
   public class LinearGradientTextSprite extends Sprite
   {
      
      public function LinearGradientTextSprite(param1:EmbeddedFontTextField, param2:Array, param3:Array, param4:Array, param5:Boolean=true) {
         super();
         if(param1.width < param1.textWidth)
         {
            param1.width = param1.textWidth * 1.1;
         }
         if(param1.height < param1.textHeight || param1.height == 100)
         {
            param1.height = param1.textHeight * 1.1;
         }
         param1.cacheAsBitmap = true;
         addChild(param1);
         var _loc6_:Matrix = new Matrix();
         var _loc7_:Number = param5?90 / 180 * Math.PI:0;
         _loc6_.createGradientBox(param1.textWidth,param1.textHeight,_loc7_);
         var _loc8_:Shape = new Shape();
         _loc8_.graphics.beginGradientFill("linear",param2,param3,param4,_loc6_);
         _loc8_.graphics.drawRect(0,0,param1.width,param1.height);
         _loc8_.graphics.endFill();
         _loc8_.cacheAsBitmap = true;
         addChild(_loc8_);
         _loc8_.mask = param1;
         blendMode = BlendMode.LAYER;
      }
   }
}
