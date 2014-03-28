package com.zynga.poker.table.shouts.views
{
   import com.zynga.poker.table.shouts.views.common.ShoutBaseView;
   import com.zynga.draw.ShinyButton;
   import flash.display.Loader;
   import com.greensock.loading.SWFLoader;
   import fl.controls.CheckBox;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.locale.LocaleManager;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.text.TextFormat;
   import com.greensock.events.LoaderEvent;
   import com.zynga.poker.PokerGlobalData;
   
   public class ShoutTicketView extends ShoutBaseView
   {
      
      public function ShoutTicketView(param1:String) {
         this.PIC_BASE_URL = PokerGlobalData.instance.staticUrlPrefix + "img/shouts/";
         super(SHOUT_TYPE,SHOUT_CLOSE_TIMEOUT_IN_SECONDS);
         this._ticketDropName = param1;
      }
      
      public static const SHOUT_TYPE:int = 3;
      
      public static const SHOUT_CLOSE_TIMEOUT_IN_SECONDS:int = 42;
      
      public static const EVENT_CLAIM_REWARDS:String = "claimTicketDrop";
      
      public static const EVENT_SHARE_REWARDS:String = "shareTicketDrop";
      
      private const PIC_BASE_URL:String;
      
      private const PIC_TYPE:String = ".swf";
      
      private const MAX_WIDTH:Number = 235;
      
      private const MAX_HEIGHT:Number = 120;
      
      private var _claimButton:ShinyButton;
      
      private var _ticketDropName:String;
      
      private var _loader:Loader;
      
      private var _swfLoader:SWFLoader;
      
      private var _placeW:Number;
      
      private var _placeH:Number;
      
      private var _shareBox:CheckBox;
      
      override protected function createForegroundAssets() : void {
         this.createHeaderText();
         this.createClaimButton();
         this.createTicketDropPanel();
         this.createShareBox();
      }
      
      private function createHeaderText() : void {
         var _loc2_:EmbeddedFontTextField = null;
         var _loc1_:String = LocaleManager.localize("flash.popup.tableView.shouts.ticketdrop.header");
         _loc2_ = new EmbeddedFontTextField(_loc1_,"Main",16,16777215,"center",true);
         _loc2_.multiline = true;
         _loc2_.wordWrap = true;
         _loc2_.width = this.width;
         _loc2_.height = 60;
         _loc2_.x = 0;
         _loc2_.selectable = false;
         _loc2_.y = shoutBorderPadding;
         addChild(_loc2_);
      }
      
      private function createClaimButton() : void {
         var _loc1_:String = LocaleManager.localize("flash.popup.tableView.shouts.ticketdrop.claimButton");
         this._claimButton = new ShinyButton(_loc1_);
         this._claimButton.x = this.width * 0.5 - this._claimButton.width * 0.5;
         this._claimButton.height = 20;
         this._claimButton.y = 153;
         addChild(this._claimButton);
         this._claimButton.addEventListener(MouseEvent.CLICK,this.onClaimClick,false,0,true);
      }
      
      private function onClaimClick(param1:MouseEvent) : void {
         this._claimButton.removeEventListener(MouseEvent.CLICK,this.onClaimClick);
         dispatchEvent(new Event(EVENT_CLAIM_REWARDS));
         if(this._shareBox.selected)
         {
            dispatchEvent(new Event(EVENT_SHARE_REWARDS));
         }
         close();
      }
      
      private function createTicketDropPanel() : void {
         this._loader = new Loader();
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onShoutLoaded,false,0,true);
         this._loader.load(new URLRequest(this.PIC_BASE_URL + this._ticketDropName + this.PIC_TYPE));
      }
      
      private function createShareBox() : void {
         this._shareBox = new CheckBox();
         this._shareBox.label = LocaleManager.localize("flash.popup.tableView.shouts.ticketdrop.share");
         this._shareBox.setStyle("textFormat",new TextFormat("_sans",10,16777215));
         this._shareBox.width = this._shareBox.textField.textWidth * 1.1 + 32;
         this._shareBox.enabled = true;
         this._shareBox.selected = true;
         this._shareBox.x = (this.width >> 1) - (this._shareBox.width >> 1);
         this._shareBox.y = 172;
         addChild(this._shareBox);
      }
      
      private function onShoutLoaded(param1:Event) : void {
         this._placeW = this.width;
         this._placeH = this.height;
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onShoutLoaded);
         this._swfLoader = new SWFLoader(new URLRequest(this._loader.contentLoaderInfo.url),
            {
               "width":this._loader.contentLoaderInfo.width,
               "height":this._loader.contentLoaderInfo.height,
               "container":this,
               "crop":true,
               "scaleMode":"none",
               "onComplete":this.onProperLoad
            });
         this._swfLoader.load();
      }
      
      private function onProperLoad(param1:LoaderEvent) : void {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         if(param1.target.content.fitWidth > this.MAX_WIDTH)
         {
            _loc2_ = this.MAX_WIDTH / param1.target.content.fitWidth;
            param1.target.content.fitWidth = param1.target.content.fitWidth * _loc2_;
            param1.target.content.fitHeight = param1.target.content.fitHeight * _loc2_;
         }
         if(param1.target.content.fitHeight > this.MAX_HEIGHT)
         {
            _loc3_ = this.MAX_HEIGHT / param1.target.content.fitHeight;
            param1.target.content.fitHeight = param1.target.content.fitHeight * _loc3_;
            param1.target.content.fitWidth = param1.target.content.fitWidth * _loc3_;
         }
         param1.target.content.y = 30;
         param1.target.content.x = this._placeW / 2 - param1.target.content.fitWidth / 2;
         this.assetsComplete();
      }
      
      override protected function assetsComplete() : void {
         super.assetsComplete();
      }
   }
}
