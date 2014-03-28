package com.zynga.draw
{
   import flash.display.Sprite;
   import flash.display.Graphics;
   import flash.display.GradientType;
   import flash.geom.Matrix;
   import flash.display.LineScaleMode;
   import flash.display.CapsStyle;
   import flash.display.JointStyle;
   import flash.display.SpreadMethod;
   
   public class ComplexBox extends Sprite
   {
      
      public function ComplexBox(param1:Number, param2:Number, param3:*, param4:Object, param5:Boolean=false, param6:Object=null) {
         super();
         this.backing = new Sprite();
         this.updateGraphics(param1,param2,param3,param4,param5,param6);
         addChild(this.backing);
      }
      
      public static function getGradientFill(param1:Object) : Graphics {
         var _loc2_:Sprite = new Sprite();
         var _loc3_:String = GradientType.LINEAR;
         var _loc4_:Array = param1.colors;
         var _loc5_:Array = param1.alphas;
         var _loc6_:Array = param1.ratios;
         var _loc7_:Number = param1.rotation;
         var _loc8_:Number = _loc7_ * Math.PI / 180;
         var _loc9_:Matrix = new Matrix();
         _loc9_.createGradientBox(param1.width,param1.height,_loc8_,0,0);
         return _loc2_.graphics;
      }
      
      public var backing:Sprite;
      
      public function updateGraphics(param1:Number, param2:Number, param3:*, param4:Object, param5:Boolean=false, param6:Object=null) : void {
         var _loc7_:String = null;
         var _loc8_:Array = null;
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         var _loc11_:* = NaN;
         var _loc12_:* = NaN;
         var _loc13_:Matrix = null;
         this.backing.graphics.clear();
         if(param6 != null)
         {
            this.backing.graphics.lineStyle(param6.size,param6.color,1,true,LineScaleMode.NONE,CapsStyle.ROUND,JointStyle.ROUND,15);
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
            _loc7_ = GradientType.LINEAR;
            if(param3.gradient == "radial")
            {
               _loc7_ = GradientType.RADIAL;
            }
            _loc8_ = param3.colors;
            _loc9_ = param3.alphas;
            _loc10_ = param3.ratios;
            _loc11_ = param3.rotation;
            _loc12_ = _loc11_ * Math.PI / 180;
            _loc13_ = new Matrix();
            _loc13_.createGradientBox(param1,param2,_loc12_,0,0);
            this.backing.graphics.beginGradientFill(_loc7_,_loc8_,_loc9_,_loc10_,_loc13_,SpreadMethod.PAD);
         }
         switch(param4.type.toLowerCase())
         {
            case "rect":
               this.backing.graphics.drawRect(0,0,param1,param2);
               break;
            case "roundrect":
               this.backing.graphics.drawRoundRect(0,0,param1,param2,param4.corners);
               break;
            case "complex":
               this.backing.graphics.drawRoundRectComplex(0,0,param1,param2,param4.ul,param4.ur,param4.ll,param4.lr);
               break;
            case "ellipse":
               this.backing.graphics.drawEllipse(0,0,param1,param2);
               break;
         }
         
         if(param5)
         {
            this.backing.x = 0 - param1 / 2;
            this.backing.y = 0 - param2 / 2;
         }
      }
   }
}
