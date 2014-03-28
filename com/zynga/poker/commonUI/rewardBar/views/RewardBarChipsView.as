package com.zynga.poker.commonUI.rewardBar.views
{
   import com.zynga.display.SafeImageLoader;
   import flash.display.Sprite;
   import com.zynga.poker.commonUI.rewardBar.views.chevrons.ChevronChipsView;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.net.URLRequest;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.locale.LocaleManager;
   import com.zynga.format.PokerCurrencyFormatter;
   import flash.text.TextFormatAlign;
   import flash.filters.DropShadowFilter;
   import flash.filters.BitmapFilterQuality;
   import caurina.transitions.Tweener;
   import flash.display.BlendMode;
   import com.zynga.text.LinearGradientTextSprite;
   import flash.display.Bitmap;
   import flash.display.LoaderInfo;
   import flash.display.BitmapData;
   
   public class RewardBarChipsView extends RewardBarBaseView
   {
      
      public function RewardBarChipsView(param1:Number, param2:Number, param3:int=5, param4:int=5) {
         super(VIEW_TYPE,param1,this.PRIZE_WIDTH,param2,param3,param4);
      }
      
      public static const VIEW_TYPE:int = 1;
      
      public static const GOLD_GRADIENT_COLORS:Array = [10908465,16770889,16578780,16770889,10908465];
      
      public static const GOLD_GRADIENT_ALPHAS:Array = [100,100,100,100,100];
      
      public static const GOLD_GRADIENT_RATIOS:Array = [0,64,127,192,255];
      
      private const PRIZE_WIDTH:Number = 194;
      
      private const SILHOUETTE_IMG_PATH:String = "img/rewardBar/silhouette.png";
      
      private var _silhouetteLoader:SafeImageLoader;
      
      private var _prizeTextContainer:Sprite;
      
      override protected function createChevrons(param1:int) : void {
         super.createChevrons(param1);
         var _loc2_:Number = (_totalWidth - this.PRIZE_WIDTH) / param1;
         var _loc3_:* = 0;
         while(_loc3_ < param1)
         {
            _chevrons[_loc3_] = new ChevronChipsView(_loc2_,_totalHeight);
            _chevrons[_loc3_].createChevronBackground();
            (_chevrons[_loc3_] as DisplayObjectContainer).x = _loc3_ * _loc2_;
            _loc3_++;
         }
         var _loc4_:int = param1-1;
         while(_loc4_ >= 0)
         {
            _chevronContainer.addChild(_chevrons[_loc4_] as DisplayObjectContainer);
            _loc4_--;
         }
      }
      
      override protected function initAssetLoading() : void {
         this._silhouetteLoader = new SafeImageLoader();
         this._silhouetteLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onSilhouetteComplete,false,0,true);
         this._silhouetteLoader.load(new URLRequest(PokerGlobalData.instance.staticUrlPrefix + this.SILHOUETTE_IMG_PATH));
      }
      
      override protected function displayClaimText(param1:int, param2:int) : void {
         var _loc3_:EmbeddedFontTextField = null;
         _loc3_ = new EmbeddedFontTextField(LocaleManager.localize("flash.mfs.rewardBar.congratulations",{"chips":PokerCurrencyFormatter.numberToCurrency(param1,true,0,false)}),"Main",20,16440137,"left",true);
         _loc3_.width = _chevronContainer.width;
         _loc3_.defaultTextFormat.align = TextFormatAlign.CENTER;
         _loc3_.multiline = false;
         _loc3_.alpha = 0;
         _loc3_.filters = [new DropShadowFilter(3,45,0,1,5,5,1,BitmapFilterQuality.LOW)];
         _loc3_.x = _chevronContainer.x;
         _loc3_.y = _chevronContainer.y;
         addChild(_loc3_);
         Tweener.addTween(_loc3_,
            {
               "alpha":1,
               "time":1,
               "delay":1
            });
      }
      
      override protected function onAllChevronsGold() : void {
         Tweener.addTween(this._prizeTextContainer,
            {
               "alpha":0,
               "time":1,
               "onComplete":this.onPrizeTextFadeOut
            });
      }
      
      private function onPrizeTextFadeOut() : void {
         while(this._prizeTextContainer.numChildren)
         {
            this._prizeTextContainer.removeChildAt(0);
         }
         this._prizeTextContainer = null;
         createClaimButton();
      }
      
      override public function createPrizeText(param1:int) : void {
         var _loc2_:* = 20;
         var _loc3_:* = "Main";
         if(LocaleManager.locale == "tr")
         {
            _loc2_ = 14;
            _loc3_ = "Garuda";
         }
         var _loc4_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.mfs.rewardBar.winUpTo"),"Main",_loc2_,0,"center",true);
         _loc4_.width = this.PRIZE_WIDTH;
         _loc4_.defaultTextFormat.align = TextFormatAlign.CENTER;
         _loc4_.multiline = false;
         var _loc5_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.global.currency",{"amount":PokerCurrencyFormatter.numberToCurrency(param1,true,0,false)}),"Main",40,0,"center",true);
         _loc5_.width = this.PRIZE_WIDTH;
         _loc5_.multiline = false;
         _loc5_.defaultTextFormat.align = TextFormatAlign.CENTER;
         _loc5_.blendMode = BlendMode.LAYER;
         this._prizeTextContainer = new Sprite();
         var _loc6_:Sprite = new LinearGradientTextSprite(_loc4_,GOLD_GRADIENT_COLORS,GOLD_GRADIENT_ALPHAS,GOLD_GRADIENT_RATIOS);
         var _loc7_:Sprite = new LinearGradientTextSprite(_loc5_,GOLD_GRADIENT_COLORS,GOLD_GRADIENT_ALPHAS,GOLD_GRADIENT_RATIOS);
         _loc7_.y = 20;
         this._prizeTextContainer.addChild(_loc6_);
         this._prizeTextContainer.addChild(_loc7_);
         this._prizeTextContainer.x = _chevronContainer.width - 34;
         this._prizeTextContainer.y = _chevronContainer.y - 18;
         var _loc8_:DropShadowFilter = new DropShadowFilter(3,45,0,1,5,5,1,BitmapFilterQuality.LOW);
         this._prizeTextContainer.filters = [_loc8_];
         addChild(this._prizeTextContainer);
      }
      
      private function onSilhouetteComplete(param1:Event) : void {
         this._silhouetteLoader.removeEventListener(Event.COMPLETE,this.onSilhouetteComplete);
         var _loc2_:BitmapData = Bitmap(LoaderInfo(param1.target).content).bitmapData;
         var _loc3_:* = 0;
         while(_loc3_ < _chevrons.length)
         {
            _chevrons[_loc3_].createChevronForeground((_loc3_ + 1) * _chevronIncrement,_loc2_);
            _loc3_++;
         }
         assetsLoaded();
      }
   }
}
