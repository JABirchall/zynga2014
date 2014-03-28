package com.zynga.poker.table.chicklet.rollover.controllers
{
   import com.zynga.poker.feature.FeatureController;
   import flash.display.DisplayObject;
   import com.zynga.display.SafeImageLoader;
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.poker.table.chicklet.rollover.assets.PlayerRollover;
   import com.zynga.poker.PokerUser;
   import com.zynga.locale.LocaleManager;
   import com.zynga.format.PokerCurrencyFormatter;
   import caurina.transitions.Tweener;
   import com.zynga.poker.table.events.TVEvent;
   import flash.net.URLRequest;
   import flash.events.Event;
   import flash.display.MovieClip;
   import com.zynga.poker.table.TableView;
   
   public class ProvController extends FeatureController
   {
      
      public function ProvController() {
         super();
      }
      
      public var rollover:DisplayObject;
      
      public var provX:int;
      
      public var provY:int;
      
      public var ldrPic:SafeImageLoader;
      
      public var thisZid:String;
      
      override protected function initModel() : FeatureModel {
         return null;
      }
      
      override protected function initView() : FeatureView {
         var _loc1_:FeatureView = null;
         _loc1_ = new FeatureView();
         this.rollover = new PlayerRollover();
         this.playerRollover.mouseEnabled = false;
         this.playerRollover.mouseChildren = false;
         this.playerRollover.x = this.provX = 0;
         this.playerRollover.y = this.provY = 342;
         this.playerRollover.visible = false;
         _loc1_.addChild(this.playerRollover);
         return _loc1_;
      }
      
      public function showProv(param1:PokerUser) : void {
         var _loc3_:* = NaN;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         this.removeImages();
         var _loc2_:PokerUser = param1;
         if(_loc2_ != null)
         {
            this.thisZid = param1.zid;
            this.playerRollover.nameTF.text = _loc2_.sUserName;
            if(_loc2_.xpLevel > 0)
            {
               this.playerRollover.levelTF.text = LocaleManager.localize("flash.table.chicklet.rollover.levelLabel",{"level":_loc2_.xpLevel});
               this.playerRollover.titleTF.text = this.mt.ptModel.getXPLevelName(_loc2_.xpLevel);
               this.playerRollover.levelTF.visible = true;
               this.playerRollover.titleTF.visible = true;
            }
            else
            {
               this.playerRollover.levelTF.visible = false;
               this.playerRollover.titleTF.visible = false;
            }
            this.playerRollover.chipsTF.text = LocaleManager.localize("flash.global.currency",{"amount":PokerCurrencyFormatter.numberToCurrency(_loc2_.nTotalPoints,false,0,false)});
            _loc3_ = _loc2_.nAchievementRank;
            _loc4_ = _loc3_ == -1?LocaleManager.localize("flash.table.chicklet.rollover.unranked"):this.mt.ptModel.getRankName(_loc2_.nAchievementRank);
            this.playerRollover.rankTF.text = _loc4_;
            _loc5_ = _loc2_.sNetwork;
            if(_loc5_.length > 20)
            {
               _loc5_ = _loc5_.substr(0,18) + "...";
            }
            this.playerRollover.networkTF.text = _loc5_;
            _loc6_ = _loc2_.sTourneyState;
            if(_loc6_ == "0")
            {
               _loc6_ = LocaleManager.localize("flash.table.chicklet.rollover.tournament.notPlayingMessage");
            }
            if(_loc6_ == "1")
            {
               _loc6_ = LocaleManager.localize("flash.table.chicklet.rollover.tournament.playingMessage");
            }
            if(_loc6_ == "2")
            {
               _loc6_ = LocaleManager.localize("flash.table.chicklet.rollover.tournament.moneyMessage");
            }
            if(_loc6_ == "3")
            {
               _loc6_ = LocaleManager.localize("flash.table.chicklet.rollover.tournament.top20PercentMessage");
            }
            if(_loc6_ == "4")
            {
               _loc6_ = LocaleManager.localize("flash.table.chicklet.rollover.tournament.top10PercentMessage");
            }
            this.playerRollover.tourneyTF.text = _loc6_;
            this.loadPlayerPic(_loc2_.sPicLrgURL);
            this.rollover.alpha = 0;
            this.rollover.visible = true;
            Tweener.removeTweens(this.rollover,"alpha");
            Tweener.addTween(this.rollover,
               {
                  "alpha":1,
                  "time":0.25,
                  "delay":0.25,
                  "transition":"easeOutSine"
               });
            this.mt.dispatchEvent(new TVEvent(TVEvent.ON_HIDE_MINIGAME_HIGHLOW));
            this.mt.dispatchEvent(new TVEvent(TVEvent.HIDE_DAILYCHALLENGE));
         }
      }
      
      public function hideProv() : void {
         Tweener.removeTweens(this.rollover,"alpha");
         Tweener.addTween(this.rollover,
            {
               "alpha":0,
               "time":0.2,
               "transition":"easeOutSine",
               "onComplete":this.makeInvisible
            });
         this.mt.dispatchEvent(new TVEvent(TVEvent.ON_SHOW_MINIGAME_HIGHLOW));
         this.mt.dispatchEvent(new TVEvent(TVEvent.SHOW_DAILYCHALLENGE));
      }
      
      private function makeInvisible() : void {
         this.rollover.visible = false;
      }
      
      private function loadPlayerPic(param1:String) : void {
         var _loc2_:URLRequest = new URLRequest(param1);
         this.ldrPic = new SafeImageLoader();
         this.ldrPic.alpha = 0;
         this.ldrPic.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onPicLoadComplete);
         this.ldrPic.load(_loc2_);
      }
      
      public function removeImages() : void {
         var _loc1_:* = 0;
         this.rollover.visible = false;
         if(this.playerRollover.playerImg.numChildren > 0)
         {
            _loc1_ = 0;
            while(this.playerRollover.playerImg.numChildren > 0)
            {
               this.playerRollover.playerImg.removeChildAt(0);
            }
         }
      }
      
      private function onPicLoadComplete(param1:Event) : void {
         var _loc5_:* = NaN;
         var _loc2_:String = this.thisZid.substr(0,1);
         var _loc3_:Number = 90;
         var _loc4_:Number = 90;
         if(this.ldrPic.height > _loc4_ || this.ldrPic.width > _loc3_)
         {
            _loc5_ = 1 / Math.min(this.ldrPic.height / _loc4_,this.ldrPic.width / _loc3_);
            this.ldrPic.scaleY = this.ldrPic.scaleY * _loc5_;
            this.ldrPic.scaleX = this.ldrPic.scaleX * _loc5_;
         }
         this.ldrPic.x = (0 - this.ldrPic.width >> 1) + (_loc3_ >> 1);
         this.ldrPic.y = 0;
         this.ldrPic.alpha = 1;
         this.playerRollover.playerImg.addChild(this.ldrPic);
      }
      
      private function get playerRollover() : MovieClip {
         return this.rollover as MovieClip;
      }
      
      protected function get mt() : TableView {
         return _parentContainer as TableView;
      }
   }
}
