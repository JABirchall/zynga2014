package com.zynga.poker.table.asset
{
   import flash.display.Sprite;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.draw.ShinyButton;
   import com.zynga.draw.tooltip.Tooltip;
   import flash.events.MouseEvent;
   import com.zynga.display.SafeImageLoader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.locale.LocaleManager;
   import flash.text.TextFieldAutoSize;
   import flash.filters.DropShadowFilter;
   import com.zynga.poker.table.betting.hsm.HSMController;
   
   public class HSMPromoContent2 extends Sprite
   {
      
      public function HSMPromoContent2(param1:Number, param2:Number, param3:Boolean) {
         super();
         this._width = param1;
         this._height = param2;
         this._showConfirmationButton = param3;
         this.setup();
      }
      
      public static const TOOLTIP_WIDTH:Number = 150;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _titleField:EmbeddedFontTextField;
      
      private var _bodyField1:EmbeddedFontTextField;
      
      private var _handField:EmbeddedFontTextField;
      
      private var _bodyField2:EmbeddedFontTextField;
      
      public function set body2Text(param1:String) : void {
         if(this._bodyField2 != null)
         {
            this._bodyField2.text = param1;
         }
      }
      
      private var _navButton:ShinyButton;
      
      private var _faqButton:Sprite;
      
      private var _faqTooltip:Tooltip = null;
      
      private var _rakePercentage:Number;
      
      private var _rakeBlindMultiplier:Number;
      
      private var _showConfirmationButton:Boolean;
      
      public function addPromoSelectionHandler(param1:Function) : void {
         this._navButton.addEventListener(MouseEvent.CLICK,param1,false,0,true);
      }
      
      public function setRakeInfo(param1:Number, param2:Number) : void {
         this._rakePercentage = param1;
         this._rakeBlindMultiplier = param2;
      }
      
      private function setup() : void {
         graphics.beginFill(0,1);
         graphics.drawRect(0.0,0.0,this._width,this._height);
         graphics.endFill();
         var _loc1_:SafeImageLoader = new SafeImageLoader();
         _loc1_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onBGLoaded,false,0,true);
         _loc1_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onBGLoadError,false,0,true);
         _loc1_.load(new URLRequest(PokerGlobalData.instance.staticUrlPrefix + "img/handStrengthMeter/bgHSMmarketing_v2.jpg"));
         this._titleField = new EmbeddedFontTextField(LocaleManager.localize("flash.table.controls.hsmPromoTitle"),"MainCondensed",20,16777215,"left");
         this._titleField.autoSize = TextFieldAutoSize.LEFT;
         this._titleField.fitInWidth(190);
         this._titleField.x = 11;
         this._titleField.y = 7;
         this._bodyField1 = new EmbeddedFontTextField(LocaleManager.localize("flash.table.controls.hsmPromoBody1_v2"),"Main",12,16777215,"left");
         this._bodyField1.width = this._width - 20;
         this._bodyField1.multiline = true;
         this._bodyField1.wordWrap = true;
         this._bodyField1.x = 12;
         this._bodyField1.y = 38;
         var _loc2_:String = LocaleManager.localize("flash.table.hand.winThreeOfAKind",{"kid":"K"});
         this._handField = new EmbeddedFontTextField(LocaleManager.localize("flash.table.hand",{"hand":_loc2_}),"Main",13,16777215);
         this._handField.width = this._handField.textWidth + 10;
         this._handField.x = 72;
         this._handField.y = 86;
         this._handField.filters = [new DropShadowFilter(2,135)];
         this._bodyField2 = new EmbeddedFontTextField("","Main",12,16777215,"left");
         this._bodyField2.width = 170;
         this._bodyField2.multiline = true;
         this._bodyField2.wordWrap = true;
         this._bodyField2.x = 37;
         this._bodyField2.y = 165 - this._bodyField2.textHeight / 2;
         var _loc3_:* = 90;
         var _loc4_:String = this._showConfirmationButton?LocaleManager.localize("flash.table.controls.hsmPromoOK"):LocaleManager.localize("flash.table.controls.hsmPromoEnable");
         this._navButton = new ShinyButton(_loc4_,_loc3_,26);
         this._navButton.x = (this._width - _loc3_) / 2;
         this._navButton.y = 122;
         this._faqButton = new Sprite();
         this._faqButton.y = 156;
         this._faqButton.x = 10;
         var _loc5_:SafeImageLoader = new SafeImageLoader();
         _loc5_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onFAQIconLoadComplete,false,0,true);
         this._faqButton.addChild(_loc5_);
         _loc5_.load(new URLRequest(PokerGlobalData.instance.staticUrlPrefix + "img/handStrengthMeter/FAQ_icon.png"));
         addChild(_loc1_);
         addChild(this._titleField);
         addChild(this._bodyField1);
         addChild(this._handField);
         addChild(this._bodyField2);
         addChild(this._navButton);
         addChild(this._faqButton);
      }
      
      private function onBGLoaded(param1:Event) : void {
      }
      
      private function onBGLoadError(param1:Event) : void {
      }
      
      private function onFAQIconLoadComplete(param1:Event) : void {
         (param1.target.loader as SafeImageLoader).contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onFAQIconLoadComplete);
         this._faqButton.addEventListener(MouseEvent.MOUSE_OVER,this.onFAQIconHoverIn,false,0,true);
         this._faqButton.addEventListener(MouseEvent.MOUSE_OUT,this.onFAQIconHoverOut,false,0,true);
      }
      
      private function onFAQIconHoverIn(param1:Event) : void {
         this.showTooltip();
      }
      
      private function onFAQIconHoverOut(param1:Event) : void {
         this.hideTooltip();
      }
      
      private function showTooltip() : void {
         if(this._rakeBlindMultiplier == HSMController.HSM_NOBLIND_MULTIPLIER)
         {
            this._faqTooltip = new Tooltip(TOOLTIP_WIDTH,LocaleManager.localize("flash.table.controls.hsmPromoEnableTooltipNoBlindLimit",{"percent":this._rakePercentage}),"",Tooltip.TIP_LOCATION_BOTTOM_MIDDLE);
         }
         else
         {
            this._faqTooltip = new Tooltip(TOOLTIP_WIDTH,LocaleManager.localize("flash.table.controls.hsmPromoEnableTooltip",
               {
                  "percent":this._rakePercentage,
                  "maxRake":this._rakeBlindMultiplier
               }),"",Tooltip.TIP_LOCATION_BOTTOM_MIDDLE);
         }
         this._faqTooltip.cornerRadius = 5;
         addChild(this._faqTooltip);
         this._faqTooltip.x = this._faqButton.x + this._faqButton.width / 2 - this._faqTooltip.width / 2;
         this._faqTooltip.y = this._faqButton.y - this._faqTooltip.height;
      }
      
      private function hideTooltip() : void {
         if(this._faqTooltip !== null)
         {
            this._faqTooltip.visible = false;
            removeChild(this._faqTooltip);
            this._faqTooltip = null;
         }
      }
   }
}
