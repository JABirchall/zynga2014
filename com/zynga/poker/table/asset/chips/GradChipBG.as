package com.zynga.poker.table.asset.chips
{
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.display.GradientType;
   import flash.display.SpreadMethod;
   
   public class GradChipBG extends Sprite
   {
      
      public function GradChipBG() {
         super();
         this.backing = new Sprite();
         this._boxBack = new Matrix();
         addChild(this.backing);
      }
      
      public var backing:Sprite;
      
      private var _boxBack:Matrix;
      
      public function updateBacking(param1:Number, param2:Object, param3:Number) : void {
         var _loc4_:Number = param3 * Math.PI / 180;
         this._boxBack.createGradientBox(param1,param1,_loc4_,0,0);
         this.backing.graphics.clear();
         this.backing.graphics.beginGradientFill(GradientType.LINEAR,param2.colors,param2.alphas,param2.ratios,this._boxBack,SpreadMethod.PAD);
         this.backing.graphics.drawEllipse(0,0,param1,param1);
         this.backing.x = this.backing.y = -(param1 >> 1);
      }
   }
}
