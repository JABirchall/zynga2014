package com.zynga.poker.commonUI.rewardBar.views.chevrons
{
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.system.ApplicationDomain;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.filters.DropShadowFilter;
   import caurina.transitions.properties.ColorShortcuts;
   import caurina.transitions.Tweener;
   
   public class ChevronZPWCView extends ChevronBaseView
   {
      
      public function ChevronZPWCView(param1:Number=60, param2:Number=30) {
         super(param1,param2);
      }
      
      private const CHEVRON_TIP_WIDTH:Number = 10;
      
      private const SILHOUETTE_PADDING:Number = 5;
      
      private var _silhouette:MovieClip;
      
      private var _number:MovieClip;
      
      private var _goldBackground:Shape;
      
      override public function createChevronFromDomain(param1:ApplicationDomain, param2:int) : void {
         var _loc3_:Class = param1.getDefinition("chevron_frame_mc") as Class;
         var _loc4_:Sprite = new _loc3_();
         var _loc5_:Shape = new Shape();
         var _loc6_:* = "linear";
         var _loc7_:Array = [100,100];
         var _loc8_:Array = [5131854,1315860];
         var _loc9_:Array = [0,255];
         var _loc10_:Matrix = new Matrix();
         _loc10_.createGradientBox(_chevronWidth,_chevronHeight,90 / 180 * Math.PI);
         _loc5_.graphics.lineStyle(2,13421772);
         _loc5_.graphics.beginGradientFill(_loc6_,_loc8_,_loc7_,_loc9_,_loc10_);
         _loc5_.graphics.moveTo(0,0);
         _loc5_.graphics.lineTo(_chevronWidth,0);
         _loc5_.graphics.lineTo(_chevronWidth + this.CHEVRON_TIP_WIDTH,_chevronHeight >> 1);
         _loc5_.graphics.lineTo(_chevronWidth,_chevronHeight);
         _loc5_.graphics.lineTo(0,_chevronHeight);
         _loc5_.graphics.lineTo(0,0);
         _loc5_.graphics.endFill();
         addChild(_loc5_);
         this._goldBackground = new Shape();
         _loc7_ = [100,100,100];
         _loc8_ = [1971494,3487101,5987258];
         _loc9_ = [0,200,255];
         _loc10_ = new Matrix();
         _loc10_.createGradientBox(_chevronWidth,_chevronHeight,90 / 180 * Math.PI);
         this._goldBackground.graphics.lineStyle(2,16777215,0.5);
         this._goldBackground.graphics.beginGradientFill(_loc6_,_loc8_,_loc7_,_loc9_,_loc10_);
         this._goldBackground.graphics.lineTo(_chevronWidth,0);
         this._goldBackground.graphics.lineTo(_chevronWidth + this.CHEVRON_TIP_WIDTH,_chevronHeight >> 1);
         this._goldBackground.graphics.lineTo(_chevronWidth,_chevronHeight);
         this._goldBackground.graphics.lineTo(0,_chevronHeight);
         this._goldBackground.graphics.lineTo(0,0);
         this._goldBackground.graphics.endFill();
         this._goldBackground.visible = false;
         addChild(this._goldBackground);
         var _loc11_:Shape = new Shape();
         _loc11_.graphics.beginFill(16711680);
         _loc11_.graphics.drawRect(0,0,_chevronWidth + this.CHEVRON_TIP_WIDTH + 5,_chevronHeight);
         _loc11_.graphics.endFill();
         addChild(_loc11_);
         this.mask = _loc11_;
         _loc3_ = param1.getDefinition("figure_container_mc") as Class;
         this._silhouette = new _loc3_();
         this._silhouette.x = this.width >> 1;
         this._silhouette.y = this.height >> 1;
         this._silhouette.filters = [new DropShadowFilter()];
         addChild(this._silhouette);
         _loc3_ = param1.getDefinition("friend_" + param2 + "_mc") as Class;
         this._number = new _loc3_();
         this._number.x = 0;
         this._number.y = 10;
         this._number.filters = [new DropShadowFilter()];
         addChild(this._number);
         this.filters = [new DropShadowFilter()];
      }
      
      override public function goldify() : void {
         ColorShortcuts.init();
         this._goldBackground.x = this._goldBackground.x - this._goldBackground.width;
         this._goldBackground.visible = true;
         Tweener.addTween(this._goldBackground,
            {
               "x":this._goldBackground.x + this._goldBackground.width,
               "time":0.5,
               "delay":1,
               "onComplete":this.goldifyComplete
            });
      }
      
      override protected function goldifyComplete() : void {
         super.goldifyComplete();
         this._silhouette.gotoAndStop(2);
         this._number.gotoAndStop(2);
      }
   }
}
