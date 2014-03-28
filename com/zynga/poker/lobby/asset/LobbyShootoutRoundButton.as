package com.zynga.poker.lobby.asset
{
   import flash.display.MovieClip;
   import com.zynga.draw.ShinyButton;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.display.Sprite;
   import com.zynga.locale.LocaleManager;
   import flash.text.TextFieldAutoSize;
   import flash.filters.DropShadowFilter;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.format.PokerCurrencyFormatter;
   import com.zynga.draw.Box;
   
   public class LobbyShootoutRoundButton extends MovieClip
   {
      
      public function LobbyShootoutRoundButton(param1:int, param2:String, param3:Number=0, param4:Number=0) {
         super();
         this.assets = PokerClassProvider.getObject("LobbyShootoutRoundButtonAssets");
         addChild(this.assets);
         this.playButton = new ShinyButton("",this.BUTTON_WIDTH,this.PLAYBTN_HEIGHT);
         this.playButton.name = "btnShootoutRound" + param1;
         this.playButton.mouseEnabled = true;
         this.playButton.x = 7;
         this.playButton.y = 70;
         addChild(this.playButton);
         var _loc5_:String = LocaleManager.isEastAsianLanguage()?"_sans":"Main";
         this.playButtonLabel = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.gameSelector.shootout.roundButton.playLabel"),_loc5_,16,16777215,"center");
         this.playButtonLabel.autoSize = TextFieldAutoSize.CENTER;
         this.playButtonLabel.x = Math.round(this.playButton.width / 2 - this.playButtonLabel.width / 2);
         this.playButtonLabel.y = -1;
         this.playButton.addChild(this.playButtonLabel);
         this.round = param1;
         this.chipAmount = param3;
         this.goldAmount = param4;
         this.status = param2;
      }
      
      public static const STATUS_BUY_IN:String = "buyIn";
      
      public static const STATUS_ELIGIBLE:String = "eligible";
      
      public static const STATUS_PLACED:String = "placed";
      
      public static const STATUS_SKIP:String = "skip";
      
      public static const STATUS_SKIPPED:String = "skipped";
      
      public static const SPONSORED_STATUS_GET_SPONSOR:String = "get_sponsor";
      
      public static const SPONSORED_STATUS_CLAIM:String = "claim";
      
      public static const SPONSORED_STATUS_CLAIMED:String = "claimed";
      
      public var assets:MovieClip;
      
      public var sponsoredButton:ShinyButton;
      
      protected var _sponsoredButtonLabel:EmbeddedFontTextField;
      
      protected var _sponsoredStatus:String = "";
      
      protected var _sponsorState:Sprite;
      
      protected var _sponsorsNeeded:int = 0;
      
      protected var _sponsorsAccepted:int = 0;
      
      protected var _sponsorsClaimed:Boolean;
      
      private var _round:int;
      
      private var roundTextField:EmbeddedFontTextField;
      
      private const BUTTON_WIDTH:Number = 78;
      
      private const SPONSORED_BUTTON_HEIGHT:Number = 29;
      
      private const PLAYBTN_HEIGHT:Number = 34;
      
      public var playButton:ShinyButton;
      
      private var playButtonLabel:EmbeddedFontTextField;
      
      private var _status:String = "";
      
      private var statusTextField:EmbeddedFontTextField;
      
      private var _chipAmount:Number;
      
      private var chipIcon:MovieClip;
      
      private var chipAmountTextField:EmbeddedFontTextField;
      
      private var _goldAmount:Number;
      
      private var goldIcon:MovieClip;
      
      private var goldAmountTextField:EmbeddedFontTextField;
      
      public function get round() : int {
         return this._round;
      }
      
      public function set round(param1:int) : void {
         this._round = param1;
         var _loc2_:String = LocaleManager.localize("flash.lobby.gameSelector.shootout.roundButton.roundLabel",{"round":String(this._round)});
         if(!this.roundTextField)
         {
            this.roundTextField = new EmbeddedFontTextField(_loc2_,"Impact",20,15652488,"center");
            this.roundTextField.fitInWidth(80);
            this.roundTextField.autoSize = TextFieldAutoSize.CENTER;
            addChild(this.roundTextField);
            if(this.roundTextField.embedFonts)
            {
               this.roundTextField.filters = [new DropShadowFilter()];
            }
         }
         else
         {
            this.roundTextField.text = _loc2_;
         }
         this.roundTextField.x = 46 - Math.round(this.roundTextField.width / 2);
         this.roundTextField.y = 5;
      }
      
      public function get status() : String {
         return this._status;
      }
      
      public function set status(param1:String) : void {
         this._status = param1;
         var _loc2_:* = "";
         var _loc3_:Number = -1;
         switch(this._status)
         {
            case STATUS_BUY_IN:
               _loc2_ = LocaleManager.localize("flash.lobby.gameSelector.shootout.roundButton.buyInStatus");
               this.assets.blankBackground.visible = false;
               this.assets.defaultBackground.visible = true;
               this.playButton.visible = true;
               this.chipIcon.visible = true;
               this.goldIcon.visible = false;
               break;
            case STATUS_ELIGIBLE:
               _loc2_ = LocaleManager.localize("flash.lobby.gameSelector.shootout.roundButton.eligibleStatus");
               this.assets.blankBackground.visible = false;
               this.assets.defaultBackground.visible = true;
               this.playButton.visible = true;
               this.chipIcon.visible = false;
               this.goldIcon.visible = false;
               _loc3_ = this.PLAYBTN_HEIGHT / 2 - this.playButtonLabel.height / 2;
               break;
            case STATUS_PLACED:
               _loc2_ = LocaleManager.localize("flash.lobby.gameSelector.shootout.roundButton.placedStatus");
               this.assets.blankBackground.visible = true;
               this.assets.defaultBackground.visible = false;
               this.playButton.visible = false;
               break;
            case STATUS_SKIP:
               _loc2_ = LocaleManager.localize("flash.lobby.gameSelector.shootout.roundButton.skipStatus");
               this.assets.blankBackground.visible = false;
               this.assets.defaultBackground.visible = true;
               this.playButton.visible = true;
               this.chipIcon.visible = false;
               this.goldIcon.visible = true;
               break;
            case STATUS_SKIPPED:
               _loc2_ = LocaleManager.localize("flash.lobby.gameSelector.shootout.roundButton.skippedStatus");
               this.assets.blankBackground.visible = true;
               this.assets.defaultBackground.visible = false;
               this.playButton.visible = false;
               break;
         }
         
         this.playButtonLabel.y = _loc3_;
         if(this.goldIcon)
         {
            this.goldIcon.y = this.playButtonLabel.y + this.playButtonLabel.textHeight;
         }
         var _loc4_:String = LocaleManager.isEastAsianLanguage()?"_sans":"Main";
         if(!this.statusTextField)
         {
            this.statusTextField = new EmbeddedFontTextField(_loc2_,_loc4_,14,16777215,"center");
            this.statusTextField.name = "lblShootoutRound" + this._round + "Status";
            this.statusTextField.autoSize = TextFieldAutoSize.CENTER;
            addChild(this.statusTextField);
         }
         else
         {
            this.statusTextField.text = _loc2_;
         }
         this.statusTextField.fitInWidth(80);
         this.statusTextField.x = (88 - this.statusTextField.textWidth * this.statusTextField.scaleX) / 2;
         this.statusTextField.y = 46 - Math.round(this.statusTextField.height / 2);
      }
      
      public function get chipAmount() : Number {
         return this._chipAmount;
      }
      
      public function set chipAmount(param1:Number) : void {
         this._chipAmount = param1;
         if(!this.chipIcon)
         {
            this.chipIcon = PokerClassProvider.getObject("ShootoutButtonChipIcon");
            this.chipIcon.mouseChildren = false;
            this.chipIcon.mouseEnabled = false;
            this.playButton.addChild(this.chipIcon);
         }
         if(!this.chipAmountTextField)
         {
            this.chipAmountTextField = new EmbeddedFontTextField(PokerCurrencyFormatter.numberToCurrency(this._chipAmount,false),"Main",16,16777215,"left");
            this.chipAmountTextField.autoSize = TextFieldAutoSize.LEFT;
            this.chipAmountTextField.x = 15;
            this.chipAmountTextField.y = 8 - Math.round(this.chipAmountTextField.height / 2);
            this.chipIcon.addChild(this.chipAmountTextField);
         }
         else
         {
            this.chipAmountTextField.text = PokerCurrencyFormatter.numberToCurrency(this._chipAmount,false);
         }
         this.chipIcon.x = this.BUTTON_WIDTH / 2 - this.chipIcon.width / 2;
         this.chipIcon.y = this.playButtonLabel.y + this.playButtonLabel.textHeight;
      }
      
      public function get goldAmount() : Number {
         return this._goldAmount;
      }
      
      public function set goldAmount(param1:Number) : void {
         this._goldAmount = param1;
         if(!this.goldIcon)
         {
            this.goldIcon = PokerClassProvider.getObject("ShootoutButtonGoldIcon");
            this.goldIcon.mouseChildren = false;
            this.goldIcon.mouseEnabled = false;
            this.playButton.addChild(this.goldIcon);
         }
         if(!this.goldAmountTextField)
         {
            this.goldAmountTextField = new EmbeddedFontTextField(String(this._goldAmount),"Main",16,16777215,"left");
            this.goldAmountTextField.name = "lblShootoutRound" + this._round + "Gold";
            this.goldAmountTextField.autoSize = TextFieldAutoSize.LEFT;
            this.goldAmountTextField.x = 15;
            this.goldAmountTextField.y = 8 - Math.round(this.goldAmountTextField.height / 2);
            this.goldIcon.addChild(this.goldAmountTextField);
         }
         else
         {
            this.goldAmountTextField.text = String(this._goldAmount);
         }
         this.goldIcon.x = this.BUTTON_WIDTH / 2 - this.goldIcon.width / 2;
         this.goldIcon.y = this.playButtonLabel.y + this.playButtonLabel.textHeight;
      }
      
      public function changeToSponsoredShootoutButton(param1:int=0, param2:int=0, param3:Boolean=false) : void {
         this._sponsorsNeeded = param1;
         this._sponsorsAccepted = param2;
         this._sponsorsClaimed = param3;
         this.roundTextField.y = 2;
         this.playButton.y = 56;
         this.statusTextField.y = 40 - Math.round(this.statusTextField.height / 2);
         this.statusTextField.fontSize = 13;
         this.assets.defaultBackground.height = 147;
         this.assets.blankBackground.height = 147;
         this.createSponsoredButton(ShinyButton.COLOR_GREEN);
         this.sponsoredStatus = this.getSponsoredStatus();
         this.createProgressBar();
      }
      
      public function restoreToNormalShootoutButton() : void {
         this.roundTextField.y = 5;
         this.playButton.y = 70;
         this.statusTextField.y = 28;
         this.assets.defaultBackground.height = 97;
         this.assets.blankBackground.height = 97;
         this.statusTextField.fontSize = 14;
         if(this.sponsoredButton)
         {
            this.removeSponsoredButton();
         }
         if(this._sponsorState)
         {
            this.removeChild(this._sponsorState);
         }
         if(this._sponsoredButtonLabel)
         {
            this.removeChild(this._sponsoredButtonLabel);
         }
      }
      
      protected function getSponsoredStatus() : String {
         if(this._sponsorsClaimed)
         {
            return SPONSORED_STATUS_CLAIMED;
         }
         if(this._sponsorsNeeded == this._sponsorsAccepted)
         {
            return SPONSORED_STATUS_CLAIM;
         }
         return SPONSORED_STATUS_GET_SPONSOR;
      }
      
      public function get sponsoredStatus() : String {
         return this._sponsoredStatus;
      }
      
      public function set sponsoredStatus(param1:String) : void {
         this._sponsoredStatus = param1;
         var _loc2_:* = "";
         var _loc3_:String = LocaleManager.isEastAsianLanguage()?"_sans":"Main";
         switch(this._sponsoredStatus)
         {
            case SPONSORED_STATUS_GET_SPONSOR:
               _loc2_ = LocaleManager.localize("flash.lobby.gameSelector.shootout.getSponsored");
               this._sponsoredButtonLabel = new EmbeddedFontTextField(_loc2_,_loc3_,11,16777215,"center");
               this._sponsoredButtonLabel.y = 92;
               break;
            case SPONSORED_STATUS_CLAIM:
               _loc2_ = LocaleManager.localize("flash.lobby.gameSelector.shootout.claim");
               this._sponsoredButtonLabel = new EmbeddedFontTextField(_loc2_,_loc3_,17,16777215,"center");
               this._sponsoredButtonLabel.autoSize = TextFieldAutoSize.LEFT;
               this._sponsoredButtonLabel.fitInWidth(78);
               this._sponsoredButtonLabel.x = (78 - this._sponsoredButtonLabel.textWidth * this._sponsoredButtonLabel.scaleX) / 2;
               this._sponsoredButtonLabel.y = 98;
               break;
            case SPONSORED_STATUS_CLAIMED:
               _loc2_ = LocaleManager.localize("flash.lobby.gameSelector.shootout.claimed");
               this._sponsoredButtonLabel = new EmbeddedFontTextField(_loc2_,_loc3_,12,12632256,"center");
               this._sponsoredButtonLabel.autoSize = TextFieldAutoSize.LEFT;
               this._sponsoredButtonLabel.fitInWidth(78);
               this._sponsoredButtonLabel.x = (78 - this._sponsoredButtonLabel.textWidth * this._sponsoredButtonLabel.scaleX) / 2;
               this._sponsoredButtonLabel.y = 92;
               if(this.sponsoredButton)
               {
                  this.removeSponsoredButton();
                  this.createSponsoredButton(ShinyButton.COLOR_DARK_GRAY);
               }
               break;
         }
         
         this._sponsoredButtonLabel.autoSize = TextFieldAutoSize.CENTER;
         addChild(this._sponsoredButtonLabel);
         this._sponsoredButtonLabel.x = 46 - Math.round(this._sponsoredButtonLabel.width / 2);
      }
      
      protected function createSponsoredButton(param1:String) : void {
         this.sponsoredButton = new ShinyButton("",this.BUTTON_WIDTH,this.SPONSORED_BUTTON_HEIGHT,14,16777215,param1);
         this.sponsoredButton.mouseEnabled = true;
         this.sponsoredButton.x = 7;
         this.sponsoredButton.y = 94;
         addChild(this.sponsoredButton);
      }
      
      protected function removeSponsoredButton() : void {
         if(this.sponsoredButton)
         {
            this.removeChild(this.sponsoredButton);
            this.sponsoredButton = null;
         }
      }
      
      protected function createProgressBar() : void {
         var _loc1_:Number = this._sponsorsAccepted / this._sponsorsNeeded;
         var _loc2_:int = this.BUTTON_WIDTH;
         _loc1_ = _loc1_ * _loc2_;
         this._sponsorState = new Sprite();
         var _loc3_:Box = new Box(_loc1_,6,673648,true,true,2,true);
         var _loc4_:Box = new Box(_loc2_,6,4473924,true,true,2,true);
         _loc3_.x = _loc3_.x - (_loc2_ - _loc3_.width) / 2;
         this._sponsorState.addChild(_loc4_);
         this._sponsorState.addChild(_loc3_);
         var _loc5_:String = LocaleManager.isEastAsianLanguage()?"_sans":"Main";
         var _loc6_:EmbeddedFontTextField = new EmbeddedFontTextField(this._sponsorsAccepted + " / " + this._sponsorsNeeded,_loc5_,12,16777215,"center");
         _loc6_.name = "lblShootoutProgressBarStatus";
         _loc6_.autoSize = TextFieldAutoSize.CENTER;
         _loc6_.x = -15;
         _loc6_.y = -9;
         this._sponsorState.addChild(_loc6_);
         this._sponsorState.x = 46;
         this._sponsorState.y = 131;
         addChild(this._sponsorState);
      }
   }
}
