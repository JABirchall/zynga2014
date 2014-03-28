package com.zynga.poker.happyhour
{
   import com.zynga.poker.feature.FeatureController;
   import com.zynga.poker.nav.NavController;
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.nav.INavController;
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.poker.nav.events.NCEvent;
   import com.zynga.utils.timers.PokerTimer;
   import com.zynga.poker.commands.pokercontroller.ShowHappyHourLuckyBonusCommand;
   import com.zynga.poker.commands.pokercontroller.ShowHappyHourFlyoutCommand;
   import com.zynga.poker.commands.JSCommand;
   import com.zynga.poker.commands.navcontroller.UpdateXPBoostToasterCommand;
   
   public class HappyHourController extends FeatureController
   {
      
      public function HappyHourController() {
         super();
      }
      
      private var _happyHourModel:HappyHourModel;
      
      private var _navControl:NavController;
      
      private const NUM_SECONDS_PER_DAY:int = 86400;
      
      private const NUM_SECONDS_PER_HOUR:int = 3600;
      
      private const MAX_SECONDS_TO_STAGGER_AJAX_REQUEST:int = 600;
      
      override protected function initModel() : FeatureModel {
         this._happyHourModel = registry.getObject(HappyHourModel);
         this._navControl = registry.getObject(INavController);
         this._happyHourModel.init();
         return this._happyHourModel;
      }
      
      override protected function initView() : FeatureView {
         return null;
      }
      
      override protected function postInit() : void {
         this._navControl.addEventListener(NCEvent.VIEW_INIT,this.onNavInit);
      }
      
      private function onNavInit(param1:NCEvent) : void {
         var _loc2_:int = this.getSecondsSinceMidnight();
         if(_loc2_ < this._happyHourModel.marketingStartTime)
         {
            PokerTimer.instance.addAnchor(1000 * (this._happyHourModel.marketingStartTime - _loc2_),this.showMarketingFlyout);
         }
         else
         {
            if(_loc2_ < this._happyHourModel.happyHourStartTime)
            {
               this.showMarketingFlyout();
            }
            else
            {
               if(_loc2_ < this._happyHourModel.happyHourEndTime)
               {
                  this.showHappyHour();
               }
               else
               {
                  if(_loc2_ >= this._happyHourModel.happyHourEndTime)
                  {
                     PokerTimer.instance.addAnchor(1000 * (this._happyHourModel.marketingStartTime - _loc2_ + this.NUM_SECONDS_PER_DAY),this.showMarketingFlyout);
                  }
               }
            }
         }
      }
      
      private function getSecondsSinceMidnight() : int {
         var _loc1_:uint = new Date().time / 1000;
         _loc1_ = _loc1_ + this._happyHourModel.utcOffset * this.NUM_SECONDS_PER_HOUR;
         return _loc1_ % this.NUM_SECONDS_PER_DAY;
      }
      
      private function showMarketingFlyout() : void {
         PokerTimer.instance.removeAnchor(this.showMarketingFlyout);
         PokerTimer.instance.addAnchor(1000 * (this._happyHourModel.happyHourStartTime - this.getSecondsSinceMidnight()),this.showHappyHour);
         this.showFlyout(true);
         this._happyHourModel.isFirstTimeLoad = false;
      }
      
      private function showHappyHour() : void {
         var _loc2_:* = false;
         var _loc3_:* = 0;
         var _loc4_:Object = null;
         PokerTimer.instance.removeAnchor(this.showHappyHour);
         var _loc1_:int = this._happyHourModel.happyHourEndTime - this.getSecondsSinceMidnight();
         PokerTimer.instance.addAnchor(1000 * _loc1_,this.hideHappyHour);
         if(this._happyHourModel.type === HappyHourModel.TYPE_LUCKY_BONUS)
         {
            _loc2_ = true;
            if(this._happyHourModel.isFirstTimeLoad === true && this._happyHourModel.happyHourLuckyBonusAlreadySpun === true)
            {
               _loc2_ = false;
            }
            dispatchCommand(new ShowHappyHourLuckyBonusCommand(_loc2_));
            if(_loc2_ === true)
            {
               this.showFlyout(false);
            }
         }
         else
         {
            if(this._happyHourModel.type === HappyHourModel.TYPE_DOUBLE_XP)
            {
               this.showFlyout(false);
               _loc3_ = Math.min(HappyHourModel.XP_BOOST_CAP,this._happyHourModel.xpBoostMultiplier + 1);
               _loc4_ = configModel.getFeatureConfig("happyHour");
               if(_loc4_ !== null)
               {
                  _loc4_.isSendingXPToasterCommand = true;
                  PokerTimer.instance.addAnchor(1000,this.dispatchXPBoostToasterCommand);
                  if(_loc3_ < HappyHourModel.XP_BOOST_CAP)
                  {
                     _loc4_.shouldShowXpBoost = true;
                  }
               }
            }
         }
         this._happyHourModel.isFirstTimeLoad = false;
      }
      
      private function hideHappyHour() : void {
         PokerTimer.instance.removeAnchor(this.hideHappyHour);
         PokerTimer.instance.addAnchor(1000 * (this._happyHourModel.marketingStartTime - this.getSecondsSinceMidnight() + this.NUM_SECONDS_PER_DAY),this.showMarketingFlyout);
         dispatchCommand(new ShowHappyHourLuckyBonusCommand(false));
         var _loc1_:Object = configModel.getFeatureConfig("happyHour");
         if(_loc1_ !== null)
         {
            _loc1_.shouldShowXpBoost = false;
         }
      }
      
      private function showFlyout(param1:Boolean) : Boolean {
         if(this._happyHourModel.isFirstTimeLoad === true && this._happyHourModel.hasAlreadySeenFlyout === true)
         {
            return false;
         }
         if(this._happyHourModel.numFlyoutsSeen < this._happyHourModel.maxFlyoutsCount)
         {
            PokerTimer.instance.addAnchor(1000 * Math.random() * this.MAX_SECONDS_TO_STAGGER_AJAX_REQUEST,this.incrementFlyoutImpressionCount);
            this._happyHourModel.numFlyoutsSeen = this._happyHourModel.numFlyoutsSeen + 1;
            dispatchCommand(new ShowHappyHourFlyoutCommand(this._happyHourModel.type,param1));
            return true;
         }
         return false;
      }
      
      private function incrementFlyoutImpressionCount() : void {
         PokerTimer.instance.removeAnchor(this.incrementFlyoutImpressionCount);
         commandDispatcher.dispatchCommand(new JSCommand("zc.feature.happyHour.incrementFlyoutImpressionCount"));
      }
      
      private function dispatchXPBoostToasterCommand() : void {
         var _loc1_:int = Math.min(HappyHourModel.XP_BOOST_CAP,this._happyHourModel.xpBoostMultiplier + 1);
         if(configModel.getBooleanForFeatureConfig("happyHour","isSendingXPToasterCommand"))
         {
            dispatchCommand(new UpdateXPBoostToasterCommand(
               {
                  "XPMultiplier":_loc1_,
                  "timeRemaining":this._happyHourModel.happyHourEndTime - this.getSecondsSinceMidnight(),
                  "isHappyHour":true
               }));
         }
         else
         {
            PokerTimer.instance.removeAnchor(this.dispatchXPBoostToasterCommand);
         }
      }
   }
}
