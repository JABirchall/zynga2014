package com.zynga.draw
{
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.display.LineScaleMode;
   import flash.display.CapsStyle;
   import flash.display.JointStyle;
   import flash.display.GradientType;
   import flash.display.SpreadMethod;
   
   public class Box extends Sprite
   {
      
      public function Box(param1:Number, param2:Number, param3:*, param4:Boolean=true, param5:Boolean=false, param6:Number=0, param7:Boolean=false, param8:uint=0, param9:Number=0) {
         var _loc10_:String = null;
         var _loc11_:Array = null;
         var _loc12_:Array = null;
         var _loc13_:Array = null;
         var _loc14_:* = NaN;
         var _loc15_:Matrix = null;
         super();
         this.backing = new Sprite();
         if(param7 == true)
         {
            this.backing.graphics.lineStyle(param9,param8,1,true,LineScaleMode.NONE,CapsStyle.ROUND,JointStyle.ROUND,15);
         }
         if(param3 is uint)
         {
            this.backing.graphics.beginFill(param3,1);
         }
         if(param3 == null)
         {
            this.backing.graphics.beginFill(0,1);
         }
         if(!(param3 is uint) && !(param3 == null))
         {
            _loc10_ = GradientType.LINEAR;
            _loc11_ = param3.colors;
            _loc12_ = param3.alphas;
            _loc13_ = param3.ratios;
            _loc14_ = 90 * Math.PI / 180;
            _loc15_ = new Matrix();
            _loc15_.createGradientBox(param1,param2,_loc14_,0,0);
            this.backing.graphics.beginGradientFill(_loc10_,_loc11_,_loc12_,_loc13_,_loc15_,SpreadMethod.PAD);
         }
         if(param5 == true)
         {
            this.backing.graphics.drawRoundRect(0,0,param1,param2,param6);
         }
         else
         {
            if(param5 == false)
            {
               this.backing.graphics.drawRect(0,0,param1,param2);
            }
         }
         if(param4)
         {
            this.backing.x = 0 - param1 / 2;
            this.backing.y = 0 - param2 / 2;
         }
         addChild(this.backing);
      }
      
      public var backing:Sprite;
   }
}
