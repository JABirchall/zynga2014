package com.zynga.poker.table.shouts.views
{
   import com.zynga.poker.table.shouts.views.common.ShoutBaseView;
   import com.zynga.draw.ShinyButton;
   import __AS3__.vec.Vector;
   import flash.display.Sprite;
   import com.zynga.display.SafeImageLoader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.display.Bitmap;
   import flash.display.LoaderInfo;
   import com.zynga.locale.LocaleManager;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.text.TextFormat;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.format.PokerCurrencyFormatter;
   import flash.events.MouseEvent;
   
   public class ShoutMasteryAchievementView extends ShoutBaseView
   {
      
      public function ShoutMasteryAchievementView(param1:Vector.<String>, param2:Number=0) {
         var _loc3_:String = null;
         this.PIC_BASE_URL = PokerGlobalData.instance.staticUrlPrefix + "img/achievements/mastery/" + PokerGlobalData.instance.achievementImageSubDir;
         super(SHOUT_TYPE,SHOUT_CLOSE_TIMEOUT_IN_SECONDS);
         this._achievementIds = new Vector.<String>();
         for each (_loc3_ in param1)
         {
            if(!((_loc3_.match("TreasureChest_HandPlayed1")) || (_loc3_.match("TreasureChest_HandPlayed5")) || (_loc3_.match("TreasureChest_HandPlayed10")) || (_loc3_.match("TreasureChest_HandPlayed20")) || (_loc3_.match("TreasureChest_HandPlayed30")) || (_loc3_.match("TreasureChest_HandPlayed35")) || (_loc3_.match("TreasureChest_HandPlayed40")) || (_loc3_.match("DailyChallenge"))))
            {
               this._achievementIds.push(_loc3_);
            }
         }
         this._chipReward = param2;
         this._numPicsToBeLoaded = this._achievementIds.length >= this.PIC_CONTAINER_MAX_PICS?this.PIC_CONTAINER_MAX_PICS:this._achievementIds.length;
         this._numPicsAdded = 0;
         this._smallestPicWidth = DEFAULT_SMALLEST_PIC_WIDTH;
      }
      
      public static const SHOUT_TYPE:int = 1;
      
      public static const SHOUT_CLOSE_TIMEOUT_IN_SECONDS:int = 42;
      
      public static const EVENT_CLAIM_REWARDS:String = "claimRewards";
      
      private static const DEFAULT_SMALLEST_PIC_WIDTH:int = 100;
      
      private const PIC_BASE_URL:String;
      
      private const PIC_TYPE:String = ".png";
      
      private const PIC_SPACING:Number = 5;
      
      private const PIC_CONTAINER_MAX_PICS:int = 3;
      
      private const PIC_CONTAINER_MAX_WIDTH:Number = 190;
      
      private const PIC_CONTAINER_MAX_HEIGHT:Number = 70;
      
      private var _claimButton:ShinyButton;
      
      private var _achievementIds:Vector.<String>;
      
      private var _picContainer:Sprite;
      
      private var _achievementPicLoaders:Vector.<SafeImageLoader>;
      
      private var _numPicsAdded:int;
      
      private var _numPicsToBeLoaded:int;
      
      private var _smallestPicWidth:int;
      
      private var _chipReward:Number = 0;
      
      override protected function createForegroundAssets() : void {
         this.createClaimButton();
         this.createHeaderText();
         this.createSubHeaderText();
         this.createAchievementPanel();
      }
      
      private function createAchievementPanel() : void {
         this._picContainer = new Sprite();
         this._achievementPicLoaders = new Vector.<SafeImageLoader>(this._numPicsToBeLoaded,true);
         var _loc1_:* = 0;
         while(_loc1_ < this._numPicsToBeLoaded)
         {
            this._achievementPicLoaders[_loc1_] = new SafeImageLoader();
            this._achievementPicLoaders[_loc1_].contentLoaderInfo.addEventListener(Event.COMPLETE,this.onAchievementPicLoaded,false,0,true);
            this._achievementPicLoaders[_loc1_].load(new URLRequest(this.PIC_BASE_URL + this._achievementIds[_loc1_] + this.PIC_TYPE));
            _loc1_++;
         }
      }
      
      private function onAchievementPicLoaded(param1:Event) : void {
         var _loc2_:Bitmap = Bitmap(LoaderInfo(param1.target).content);
         _loc2_.smoothing = true;
         if(_loc2_.width < this._smallestPicWidth)
         {
            this._smallestPicWidth = _loc2_.width;
         }
         this._picContainer.addChild(_loc2_);
         this._numPicsAdded++;
         if(this._numPicsAdded == this._numPicsToBeLoaded)
         {
            this.assetsComplete();
         }
      }
      
      override protected function assetsComplete() : void {
         var _loc1_:Bitmap = null;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc2_:* = 0;
         while(_loc2_ < this._numPicsToBeLoaded)
         {
            _loc1_ = this._picContainer.getChildAt(_loc2_) as Bitmap;
            _loc1_.height = _loc1_.height * this._smallestPicWidth / _loc1_.width;
            _loc1_.width = this._smallestPicWidth;
            _loc1_.x = _loc2_ * (this._smallestPicWidth + this.PIC_SPACING);
            _loc2_++;
         }
         if(this._picContainer.width > this.PIC_CONTAINER_MAX_WIDTH)
         {
            _loc3_ = this.PIC_CONTAINER_MAX_WIDTH / this._picContainer.width;
            this._picContainer.scaleX = this._picContainer.scaleY = _loc3_;
         }
         if(this._picContainer.height > this.PIC_CONTAINER_MAX_HEIGHT)
         {
            _loc4_ = this.PIC_CONTAINER_MAX_HEIGHT / this._picContainer.height;
            this._picContainer.scaleY = this._picContainer.scaleX = _loc4_;
         }
         this._picContainer.y = this.height / 2 - this._picContainer.height / 2 - 4;
         this._picContainer.x = this.width / 2 - this._picContainer.width / 2;
         addChild(this._picContainer);
         super.assetsComplete();
      }
      
      private function createHeaderText() : void {
         var _loc1_:* = "";
         var _loc2_:int = this._achievementIds.length;
         if(_loc2_ == 1)
         {
            _loc1_ = LocaleManager.localize("flash.popup.tableView.shouts.mastery.header",{"achievementName":LocaleManager.localize("flash.popups.profile.achievements.name." + this._achievementIds[0])});
         }
         else
         {
            if(_loc2_ >= 2)
            {
               _loc1_ = LocaleManager.localize("flash.popup.tableView.shouts.mastery.headerPlural.old",{"numAchievements":_loc2_});
            }
         }
         var _loc3_:* = "Main";
         var _loc4_:Number = 16;
         var _loc5_:EmbeddedFontTextField = new EmbeddedFontTextField(_loc1_,_loc3_,_loc4_,16777215,"center",true);
         _loc5_.multiline = true;
         _loc5_.wordWrap = true;
         _loc5_.height = 50;
         _loc5_.width = this._claimButton.width;
         this.scaleText(_loc5_,_loc5_.width - 10,46);
         _loc5_.x = this.width * 0.5 - _loc5_.width * 0.5;
         _loc5_.selectable = false;
         _loc5_.y = shoutBorderPadding;
         addChild(_loc5_);
      }
      
      private function scaleText(param1:EmbeddedFontTextField, param2:Number, param3:Number) : void {
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc4_:TextFormat = param1.getTextFormat();
         if(param1.textWidth > param2)
         {
            _loc5_ = param2 / param1.textWidth;
            _loc4_.size = int(Math.floor(Number(_loc4_.size) * _loc5_));
         }
         param1.setTextFormat(_loc4_);
         if(param1.textHeight > param3)
         {
            _loc6_ = param3 / param1.textHeight;
            _loc4_.size = int(Math.floor(Number(_loc4_.size) * _loc6_));
         }
         param1.setTextFormat(_loc4_);
      }
      
      private function createSubHeaderText() : void {
         var _loc1_:* = "";
         if(this._chipReward > 0 && !PokerGlobalData.instance.achievementOldShoutTextEnabled)
         {
            _loc1_ = LocaleManager.localize("flash.popup.tableView.shouts.mastery.subHeader",
               {
                  "count":PokerCurrencyFormatter.numberToCurrency(this._chipReward,false,0,false),
                  "chip":
                     {
                        "type":"tk",
                        "key":"chip",
                        "attributes":"",
                        "count":int(this._chipReward)
                     }
               });
         }
         else
         {
            if(this._achievementIds.length == 1)
            {
               _loc1_ = LocaleManager.localize("flash.popup.tableView.shouts.mastery.subHeaderSingular.old");
            }
            else
            {
               _loc1_ = LocaleManager.localize("flash.popup.tableView.shouts.mastery.subHeaderPlural.old");
            }
         }
         var _loc2_:EmbeddedFontTextField = new EmbeddedFontTextField(_loc1_,"MainLight",12,16777215,"center",false);
         _loc2_.y = this._claimButton.y - 21;
         _loc2_.multiline = false;
         _loc2_.width = this.width - shoutBorderPadding * 2;
         _loc2_.height = _loc2_.textHeight + 2;
         this.scaleText(_loc2_,_loc2_.width - 2,_loc2_.height - 2);
         _loc2_.x = shoutBorderPadding;
         _loc2_.selectable = false;
         addChild(_loc2_);
      }
      
      private function createClaimButton() : void {
         var _loc1_:String = LocaleManager.localize("flash.popup.tableView.shouts.mastery.claimButton");
         if(PokerGlobalData.instance.achievementOldShoutTextEnabled)
         {
            if(this._achievementIds.length > 1)
            {
               _loc1_ = LocaleManager.localize("flash.popup.tableView.shouts.mastery.claimButtonPlural.old");
            }
            else
            {
               _loc1_ = LocaleManager.localize("flash.popup.tableView.shouts.mastery.claimButtonSingular.old");
            }
         }
         this._claimButton = new ShinyButton(_loc1_);
         this._claimButton.y = this.height - this._claimButton.height - shoutBorderPadding;
         this._claimButton.x = this.width / 2 - this._claimButton.width / 2;
         addChild(this._claimButton);
         this._claimButton.addEventListener(MouseEvent.CLICK,this.onClaimClick,false,0,true);
      }
      
      private function onClaimClick(param1:MouseEvent) : void {
         this._claimButton.removeEventListener(MouseEvent.CLICK,this.onClaimClick);
         dispatchEvent(new Event(EVENT_CLAIM_REWARDS));
         close();
      }
   }
}
