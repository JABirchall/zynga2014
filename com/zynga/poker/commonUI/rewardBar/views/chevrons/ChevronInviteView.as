package com.zynga.poker.commonUI.rewardBar.views.chevrons
{
   import flash.display.Bitmap;
   import flash.display.Shape;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.filters.DropShadowFilter;
   import flash.filters.BitmapFilterQuality;
   import flash.display.BlendMode;
   import caurina.transitions.properties.ColorShortcuts;
   import caurina.transitions.Tweener;
   
   public class ChevronInviteView extends ChevronBaseView
   {
      
      public function ChevronInviteView(param1:Number=60, param2:Number=30) {
         this.BLUE_GRADIENT_COLORS = [62951,8781813,13238267,8781813,62951];
         this.GRADIENT_ALPHAS = [100,100,100,100,100];
         this.GRADIENT_RATIOS = [0,64,127,192,255];
         super(param1,param2);
      }
      
      public static const GOLD_TWEEN_COMPLETE:String = "goldTweenComplete";
      
      private const CHEVRON_TIP_WIDTH:Number = 20;
      
      private const SILHOUETTE_PADDING:Number = 5;
      
      private const SILHOUETTE_COLOR:uint = 14606046;
      
      private const CIRCLE_RADIUS:Number = 10;
      
      private const BLUE_GRADIENT_COLORS:Array;
      
      private const GRADIENT_ALPHAS:Array;
      
      private const GRADIENT_RATIOS:Array;
      
      private var _silhouette:Bitmap;
      
      private var _circle:Shape;
      
      private var _incrementText:EmbeddedFontTextField;
      
      private var _goldBackground:Shape;
      
      override public function createChevronBackground(param1:BitmapData=null) : void {
         var _loc2_:Shape = new Shape();
         var _loc3_:* = "linear";
         var _loc4_:Array = [2236962,10066329];
         var _loc5_:Array = [100,100];
         var _loc6_:Array = [0,255];
         var _loc7_:Matrix = new Matrix();
         _loc7_.createGradientBox(_chevronWidth,_chevronHeight,90 / 180 * Math.PI);
         _loc2_.graphics.lineStyle(2,13421772);
         _loc2_.graphics.beginGradientFill(_loc3_,_loc4_,_loc5_,_loc6_,_loc7_);
         _loc2_.graphics.moveTo(0,0);
         _loc2_.graphics.lineTo(_chevronWidth,0);
         _loc2_.graphics.lineTo(_chevronWidth + this.CHEVRON_TIP_WIDTH,_chevronHeight / 2);
         _loc2_.graphics.lineTo(_chevronWidth,_chevronHeight);
         _loc2_.graphics.lineTo(0,_chevronHeight);
         _loc2_.graphics.lineTo(0,0);
         _loc2_.graphics.endFill();
         addChild(_loc2_);
         this._goldBackground = new Shape();
         this._goldBackground.graphics.lineStyle(2,16777215,0.5);
         this._goldBackground.graphics.beginGradientFill(_loc3_,this.BLUE_GRADIENT_COLORS,this.GRADIENT_ALPHAS,this.GRADIENT_RATIOS,_loc7_);
         this._goldBackground.graphics.moveTo(0,0);
         this._goldBackground.graphics.lineTo(_chevronWidth,0);
         this._goldBackground.graphics.lineTo(_chevronWidth + this.CHEVRON_TIP_WIDTH,_chevronHeight / 2);
         this._goldBackground.graphics.lineTo(_chevronWidth,_chevronHeight);
         this._goldBackground.graphics.lineTo(0,_chevronHeight);
         this._goldBackground.graphics.lineTo(0,0);
         this._goldBackground.graphics.endFill();
         this._goldBackground.visible = false;
         addChild(this._goldBackground);
         var _loc8_:Shape = new Shape();
         _loc8_.graphics.beginFill(16711680);
         _loc8_.graphics.drawRect(0,0,_chevronWidth + this.CHEVRON_TIP_WIDTH + 5,_chevronHeight);
         _loc8_.graphics.endFill();
         addChild(_loc8_);
         this.mask = _loc8_;
         var _loc9_:DropShadowFilter = new DropShadowFilter(4,45,0,1,4,4,1,BitmapFilterQuality.LOW);
         this.filters = [_loc9_];
      }
      
      override public function createChevronForeground(param1:int, param2:BitmapData=null) : void {
         this._silhouette = new Bitmap(param2,"auto",true);
         this._silhouette.height = this._silhouette.width = this.height - this.SILHOUETTE_PADDING;
         this._silhouette.x = this.width / 2 - this._silhouette.width;
         this._silhouette.y = this._silhouette.y + this.SILHOUETTE_PADDING;
         addChild(this._silhouette);
         this._circle = new Shape();
         this._circle.graphics.beginFill(this.SILHOUETTE_COLOR);
         this._circle.graphics.drawCircle(0,0,this.CIRCLE_RADIUS);
         this._circle.graphics.endFill();
         this._circle.x = this._silhouette.x + this._silhouette.width + this.SILHOUETTE_PADDING * 2;
         this._circle.y = this._silhouette.y + this._silhouette.height / 2 - this.SILHOUETTE_PADDING / 2;
         addChild(this._circle);
         this._incrementText = new EmbeddedFontTextField(String(param1),"Main",11,0,"center",true);
         this._incrementText.height = this._incrementText.width = this._circle.height;
         this._incrementText.blendMode = BlendMode.LAYER;
         this._incrementText.x = this._circle.x - this.CIRCLE_RADIUS-1;
         this._incrementText.y = this._circle.y - this.CIRCLE_RADIUS + 1;
         addChild(this._incrementText);
      }
      
      override public function goldify() : void {
         ColorShortcuts.init();
         this._goldBackground.x = this._goldBackground.x - this._goldBackground.width;
         this._goldBackground.visible = true;
         Tweener.addTween(this._silhouette,
            {
               "_color":3815994,
               "time":0.5,
               "delay":1
            });
         Tweener.addTween(this._circle,
            {
               "_color":3815994,
               "time":0.5,
               "delay":1
            });
         Tweener.addTween(this._incrementText,
            {
               "_color":16777215,
               "time":0.5,
               "delay":1
            });
         Tweener.addTween(this._goldBackground,
            {
               "x":this._goldBackground.x + this._goldBackground.width,
               "time":0.5,
               "delay":1,
               "onComplete":goldifyComplete
            });
      }
   }
}
