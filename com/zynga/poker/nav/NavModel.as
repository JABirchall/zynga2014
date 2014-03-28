package com.zynga.poker.nav
{
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.nav.sidenav.Sidenav;
   
   public class NavModel extends FeatureModel
   {
      
      public function NavModel() {
         this.itemsToShowNewStarburst = new Array();
         super();
      }
      
      public var nChips:Number;
      
      public var nCasinoGold:Number;
      
      public var nTickets:Number;
      
      public var aLevelRanks:Array;
      
      public var nAchievements:int;
      
      public var nAchievementsTotal:int;
      
      public var nBuddiesAlerts:int;
      
      public var sPicURL:String;
      
      public var navTimers:Array;
      
      private var _sideNavItemsToHide:Array;
      
      public function get sideNavItemsToHide() : Array {
         return this._sideNavItemsToHide;
      }
      
      public var itemsToShowNewStarburst:Array;
      
      public var scratchersConfig:Object;
      
      public var blackjackConfig:Object;
      
      public var serveProgressConfig:Object;
      
      override public function init() : void {
         var _loc1_:Object = configModel.getFeatureConfig("sideNav");
         if((_loc1_) && (_loc1_.hideSideNavItems))
         {
            this._sideNavItemsToHide = _loc1_.hideSideNavItems as Array;
         }
         else
         {
            this._sideNavItemsToHide = [];
         }
         if(pgData.timeStamp)
         {
            this.navTimers = new Array();
         }
         if((pgData.serveProgressData) && pgData.xpLevel > 3)
         {
            if(!(pgData.serveProgressData.timeLeft == 0) && pgData.serveProgressData.daysLeft >= 0)
            {
               this.navTimers[Sidenav.AMEX_SERVE] = pgData.serveProgressData.timeLeft;
            }
         }
         else
         {
            this._sideNavItemsToHide.push(Sidenav.AMEX_SERVE);
         }
         this.serveProgressConfig = configModel.getFeatureConfig("serveProgress");
         if((this.serveProgressConfig) && (this.serveProgressConfig.amexPermIconTest))
         {
            this._sideNavItemsToHide.push(Sidenav.AMEX_SERVE);
         }
         if(pgData.luckyBonusEnabled)
         {
            if(pgData.luckyBonusTimeUntil == 0)
            {
               if((_loc1_) && (_loc1_.sideNavAnimationsURL))
               {
                  _loc1_.sideNavAnimationsURL[Sidenav.LUCKY_BONUS] = pgData.luckyBonusAnimationURL;
               }
            }
            this.navTimers[Sidenav.LUCKY_BONUS] = pgData.luckyBonusTimeUntil;
         }
         else
         {
            this._sideNavItemsToHide.push(Sidenav.LUCKY_BONUS);
         }
         this.scratchersConfig = configModel.getFeatureConfig("scratchers");
         if(this.scratchersConfig == null)
         {
            this._sideNavItemsToHide.push(Sidenav.SCRATCHERS);
         }
         this.blackjackConfig = configModel.getFeatureConfig("blackjack");
         if(this.blackjackConfig == null || !this.blackjackConfig.showSidenav)
         {
            this._sideNavItemsToHide.push(Sidenav.BLACKJACK);
         }
         if(pgData.luckyHandTimeLeft > 0 && (pgData.luckyHandCouponEnabled))
         {
            this.navTimers[Sidenav.LUCKY_HAND_COUPON] = pgData.luckyHandTimeLeft;
            this.navTimers[Sidenav.LUCKY_HAND_V2_COUPON] = pgData.luckyHandTimeLeft;
         }
      }
      
      public function get zpwcTickets() : Number {
         return pgData.zpwcTickets;
      }
   }
}
