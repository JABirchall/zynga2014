package com.zynga.poker.commonUI.rewardBar.views
{
   import com.zynga.display.SafeAssetLoader;
   import flash.system.ApplicationDomain;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.filters.ColorMatrixFilter;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.locale.LocaleManager;
   import com.zynga.format.PokerCurrencyFormatter;
   import flash.text.TextFormatAlign;
   import caurina.transitions.Tweener;
   import com.zynga.poker.commonUI.rewardBar.views.chevrons.ChevronZPWCView;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.lobbycontroller.ShowLobbyBannerCommand;
   import com.zynga.poker.PokerGlobalData;
   
   public class RewardBarZPWCView extends RewardBarBaseView
   {
      
      public function RewardBarZPWCView(param1:Number, param2:Number, param3:int=6, param4:int=5) {
         this.SWF_URL = PokerGlobalData.instance.sRootURL + "img/rewardBar/zpwc_mfs.swf";
         this._swfLoaded = false;
         super(VIEW_TYPE,param1,this.PRIZE_WIDTH,param2,param3,param4);
      }
      
      public static const VIEW_TYPE:int = 2;
      
      private const PRIZE_WIDTH:Number = 230;
      
      private const SWF_URL:String;
      
      private var _swfLoader:SafeAssetLoader;
      
      private var _swfLoaded:Boolean;
      
      private var _domain:ApplicationDomain;
      
      private var _logo:MovieClip;
      
      override protected function initAssetLoading() : void {
         this._swfLoader = new SafeAssetLoader();
         this._swfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onAssetComplete,false,0,true);
         this._swfLoader.load(new URLRequest(this.SWF_URL));
      }
      
      private function onAssetComplete(param1:Event) : void {
         this._swfLoaded = true;
         this._swfLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onAssetComplete);
         this._domain = param1.target.applicationDomain;
         this.initRewardBar();
         assetsLoaded();
      }
      
      private function initRewardBar() : void {
         var _loc3_:Sprite = null;
         var _loc4_:Sprite = null;
         var _loc1_:Class = this._domain.getDefinition("braclet_mc") as Class;
         var _loc2_:MovieClip = new _loc1_();
         _loc2_.rotation = -30;
         _loc3_ = new Sprite();
         _loc3_.graphics.beginFill(0,1);
         _loc3_.graphics.drawRect(-100,-100,160,160);
         _loc3_.graphics.endFill();
         _loc4_ = new Sprite();
         _loc4_.x = 520;
         _loc4_.y = 0;
         _loc4_.mask = _loc3_;
         _loc4_.addChild(_loc3_);
         _loc4_.addChild(_loc2_);
         addChild(_loc4_);
         _loc1_ = this._domain.getDefinition("zpwc_logo_mc") as Class;
         this._logo = new _loc1_();
         this._logo.x = 425;
         this._logo.y = 10;
         this._logo.filters = [new DropShadowFilter()];
         addChild(this._logo);
         var _loc5_:Number = 0.5;
         var _loc6_:ColorMatrixFilter = new ColorMatrixFilter(new Array(0.4,0,0,0,0,0,0.4,0,0,0,0,0,0.4,0,0,0,0,0,1,0));
         _loc1_ = this._domain.getDefinition("ticket_mc") as Class;
         var _loc7_:* = new _loc1_();
         _loc7_.width = _loc7_.width * _loc5_;
         _loc7_.height = _loc7_.height * _loc5_;
         _loc7_.rotation = 160;
         _loc7_.x = 400;
         _loc7_.y = 30;
         _loc7_.filters = [_loc6_];
         addChild(_loc7_);
         _loc6_ = new ColorMatrixFilter(new Array(0.55,0,0,0,0,0,0.55,0,0,0,0,0,0.55,0,0,0,0,0,1,0));
         var _loc8_:* = new _loc1_();
         _loc8_.width = _loc8_.width * _loc5_;
         _loc8_.height = _loc8_.height * _loc5_;
         _loc8_.rotation = 125;
         _loc8_.x = 395;
         _loc8_.y = 23;
         _loc8_.filters = [_loc6_];
         addChild(_loc8_);
         _loc6_ = new ColorMatrixFilter(new Array(0.7,0,0,0,0,0,0.7,0,0,0,0,0,0.7,0,0,0,0,0,1,0));
         var _loc9_:* = new _loc1_();
         _loc9_.width = _loc9_.width * _loc5_;
         _loc9_.height = _loc9_.height * _loc5_;
         _loc9_.rotation = 90;
         _loc9_.x = 390;
         _loc9_.y = 20;
         _loc9_.filters = [_loc6_];
         addChild(_loc9_);
         _loc6_ = new ColorMatrixFilter(new Array(0.85,0,0,0,0,0,0.85,0,0,0,0,0,0.85,0,0,0,0,0,1,0));
         var _loc10_:* = new _loc1_();
         _loc10_.width = _loc10_.width * _loc5_;
         _loc10_.height = _loc10_.height * _loc5_;
         _loc10_.rotation = 55;
         _loc10_.x = 385;
         _loc10_.y = 22;
         _loc10_.filters = [_loc6_];
         addChild(_loc10_);
         var _loc11_:* = new _loc1_();
         _loc11_.width = _loc11_.width * _loc5_;
         _loc11_.height = _loc11_.height * _loc5_;
         _loc11_.rotation = 15;
         _loc11_.x = 380;
         _loc11_.y = 28;
         addChild(_loc11_);
         _loc1_ = this._domain.getDefinition("chips_mc") as Class;
         var _loc12_:* = new _loc1_();
         _loc12_.width = _loc12_.width * 0.55;
         _loc12_.height = _loc12_.height * 0.55;
         _loc12_.x = 395;
         _loc12_.y = 43;
         addChild(_loc12_);
         this.createChevrons(_chevrons.length);
      }
      
      override protected function displayClaimText(param1:int, param2:int) : void {
         var _loc3_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.mfs.rewardBar.congratulations.zpwc",
            {
               "chips":PokerCurrencyFormatter.numberToCurrency(param1,true,0,false),
               "ticketPrize":25
            }),"Main",18,16757248,"left",true);
         _loc3_.width = _chevronContainer.width;
         _loc3_.defaultTextFormat.align = TextFormatAlign.CENTER;
         _loc3_.multiline = true;
         _loc3_.wordWrap = true;
         _loc3_.alpha = 0;
         _loc3_.x = _chevronContainer.x;
         _loc3_.y = _chevronContainer.y + 4;
         _loc3_.width = 375;
         _loc3_.height = 80;
         addChild(_loc3_);
         Tweener.addTween(_loc3_,
            {
               "alpha":1,
               "time":1,
               "delay":1
            });
      }
      
      override protected function onAllChevronsGold() : void {
         this.createClaimButton();
      }
      
      override protected function createChevrons(param1:int) : void {
         var _loc2_:* = NaN;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         super.createChevrons(param1);
         if(this._swfLoaded)
         {
            _loc2_ = (_totalWidth - this.PRIZE_WIDTH) / param1;
            _loc3_ = 0;
            while(_loc3_ < param1)
            {
               _chevrons[_loc3_] = new ChevronZPWCView(_loc2_,_totalHeight);
               _chevrons[_loc3_].createChevronFromDomain(this._domain,_loc3_ + 1);
               (_chevrons[_loc3_] as DisplayObjectContainer).x = _loc3_ * _loc2_;
               _loc3_++;
            }
            _loc4_ = param1-1;
            while(_loc4_ >= 0)
            {
               _chevronContainer.addChild(_chevrons[_loc4_] as DisplayObjectContainer);
               _loc4_--;
            }
            _chevronContainer.x = -20;
            addChild(_chevronContainer);
         }
      }
      
      override protected function onClaimClick(param1:MouseEvent) : void {
         _claimButton.removeEventListener(MouseEvent.CLICK,this.onClaimClick);
         removeChild(_claimButton);
         _claimButton = null;
         PokerCommandDispatcher.getInstance().dispatchCommand(new ShowLobbyBannerCommand());
         dispatchEvent(new Event(CLAIM_REWARD));
      }
      
      override protected function createClaimButton(param1:Number=100, param2:Number=31, param3:int=16, param4:String="") : void {
         if(contains(this._logo))
         {
            removeChild(this._logo);
         }
         super.createClaimButton(param1,param2,param3,param4);
         _claimButton.x = 450;
         _claimButton.y = _chevronContainer.y + 10;
      }
   }
}
