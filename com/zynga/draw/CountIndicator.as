package com.zynga.draw
{
   import flash.display.MovieClip;
   import com.zynga.text.HtmlTextBox;
   import flash.display.Sprite;
   import caurina.transitions.Tweener;
   import flash.filters.DropShadowFilter;
   
   public class CountIndicator extends MovieClip
   {
      
      public function CountIndicator(param1:int) {
         super();
         this.count = param1;
         this.tf = new HtmlTextBox("MainCondensed",param1.toString(),12,16777215,"center");
         this.positionTf();
         this.tf.filters = [new DropShadowFilter(1,90,0,1,3,3,1,3)];
         var _loc2_:Object = new Object();
         _loc2_.colors = [16711680,11141120];
         _loc2_.alphas = [1,1];
         _loc2_.ratios = [0,255];
         _loc2_.rotation = 90;
         var _loc3_:Number = 16;
         var _loc4_:Number = 16;
         this.bg = new Sprite();
         this.bg.graphics.beginFill(6296334,1);
         this.bg.graphics.drawCircle(_loc3_ / 2,_loc4_ / 2,(_loc3_ + _loc4_) / 4);
         this.bg.graphics.endFill();
         this.bg.graphics.beginFill(11413539,1);
         this.bg.graphics.moveTo(1.5,_loc4_ / 3.5);
         this.bg.graphics.curveTo(3,1,_loc3_ / 2,0.5);
         this.bg.graphics.curveTo(_loc3_ - 3,0.5,_loc3_ - 1.5,_loc4_ / 3.5);
         this.bg.graphics.curveTo(_loc3_ - 0.5,_loc4_ / 1.7,_loc3_ / 2,_loc4_ / 1.7);
         this.bg.graphics.curveTo(0.5,_loc4_ / 1.7,1.5,_loc4_ / 3.5);
         this.bg.graphics.endFill();
         this.bg.x = -(_loc3_ / 2);
         this.bg.y = -(_loc4_ / 2);
         addChild(this.bg);
         addChild(this.tf);
      }
      
      public var tf:HtmlTextBox;
      
      public var bg:Sprite;
      
      public var vPad:int = -2;
      
      public var hPad:int = 4;
      
      public var thisColor:uint;
      
      public var count:int = 0;
      
      private function positionTf() : void {
         this.tf.y = 0;
      }
      
      public function updateCount(param1:int) : void {
         this.count = param1;
         this.tf.updateText(param1.toString());
         this.positionTf();
      }
      
      public function updateCountText(param1:int) : void {
         this.count = param1;
         this.tf.updateText(param1.toString() + "X");
         this.positionTf();
      }
      
      public function startBlink() : void {
         Tweener.addTween(this.bg,
            {
               "_Glow_alpha":1,
               "_Glow_color":this.thisColor,
               "_Glow_blurX":5,
               "_Glow_blurY":5,
               "_Glow_quality":3,
               "time":0.25,
               "transition":"easeOutSine"
            });
         Tweener.addTween(this.bg,
            {
               "_Glow_alpha":0,
               "_Glow_blurX":0,
               "_Glow_blurY":0,
               "delay":0.3,
               "time":0.25,
               "transition":"easeOutSine",
               "onComplete":this.startBlink
            });
      }
   }
}
