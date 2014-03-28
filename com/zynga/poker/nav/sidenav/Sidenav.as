package com.zynga.poker.nav.sidenav
{
   import flash.display.Sprite;
   import com.zynga.poker.nav.assets.SideNavMiniArcade;
   import com.zynga.text.GlowTextBox;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.locale.LocaleManager;
   import flash.events.MouseEvent;
   import com.zynga.draw.Box;
   import com.zynga.poker.nav.events.NVEvent;
   import com.zynga.poker.nav.sidenav.events.SidenavEvents;
   import com.zynga.poker.nav.events.NCEvent;
   
   public class Sidenav extends Sprite
   {
      
      public function Sidenav() {
         this.navItems = [];
         this.snCont = new Sprite();
         this.siCont = new Sprite();
         super();
         this._enabled = true;
         addChild(this.snCont);
         this.snCont.addChild(this.siCont);
      }
      
      public static const GET_CHIPS:String = "Get Chips";
      
      public static const GIFT_SHOP:String = "Gift Shop";
      
      public static const PROFILE:String = "Profile";
      
      public static const BETS:String = "Bets";
      
      public static const LUCKY_BONUS:String = "LuckyBonus";
      
      public static const LUCKY_BONUS_ARCADE:String = "LuckyBonusArcade";
      
      public static const LUCKY_HAND_COUPON:String = "LuckyHandCoupon";
      
      public static const LUCKY_HAND_V2_COUPON:String = "LuckyHandV2Coupon";
      
      public static const AT_TABLE_ERASE_LOSS_COUPON:String = "AtTableEraseLossCoupon";
      
      public static const MINI_ARCADE:String = "MiniArcade";
      
      public static const SCRATCHERS:String = "Scratchers";
      
      public static const BLACKJACK:String = "Blackjack";
      
      public static const AMEX_SERVE:String = "AmexServe";
      
      public static const CHALLENGE:String = "Challenge";
      
      public static const BUDDIES:String = "Buddies";
      
      public static const POKER_SCORE:String = "PokerScore";
      
      public static const LEADERBOARD:String = "Leaderboard";
      
      public var navItems:Array;
      
      public var snCont:Sprite;
      
      public var siCont:Sprite;
      
      private var _enabled:Boolean;
      
      private var miniArcade:SideNavMiniArcade;
      
      public function initSideNav(param1:Array, param2:Boolean=false) : void {
         var _loc10_:SidenavItem = null;
         var _loc11_:GlowTextBox = null;
         var _loc12_:GlowTextBox = null;
         var _loc3_:PokerGlobalData = PokerGlobalData.instance;
         var _loc4_:Array = param1.concat();
         var _loc5_:* = 1;
         var _loc6_:* = 1;
         var _loc7_:int = _loc4_.length;
         var _loc8_:* = 0;
         while(_loc8_ < _loc7_)
         {
            _loc4_[_loc8_].bIsFirst = (_loc8_ == 0) || (_loc8_ == _loc6_);
            _loc4_[_loc8_].bIsLast = (_loc8_ == _loc6_-1) || (_loc8_ == _loc7_-1);
            _loc4_[_loc8_].inTopGroup = _loc4_[_loc8_].id == "LuckyBonus";
            _loc4_[_loc8_].label = LocaleManager.localize(_loc4_[_loc8_].label);
            _loc10_ = new SidenavItem(_loc4_[_loc8_]);
            if(_loc4_[_loc8_].inTopGroup)
            {
               _loc10_.y = (_loc10_.h + _loc5_) * _loc8_;
            }
            else
            {
               _loc10_.y = (_loc10_.h + _loc5_) * _loc8_ + _loc10_.h / 3;
            }
            _loc10_.addEventListener(MouseEvent.ROLL_OVER,this.siOver);
            _loc10_.addEventListener(MouseEvent.ROLL_OUT,this.siOut);
            _loc10_.addEventListener(MouseEvent.CLICK,this.siClick);
            this.navItems.push(_loc10_);
            this.siCont.addChild(_loc10_);
            switch(_loc4_[_loc8_].id)
            {
               case GET_CHIPS:
                  if(param2)
                  {
                     _loc11_ = new GlowTextBox(LocaleManager.localize("flash.global.sale"));
                     _loc11_.x = 38;
                     _loc11_.y = 25;
                     _loc11_.name = "starburst";
                     _loc10_.addChild(_loc11_);
                  }
                  if(_loc3_.luckyHandTimeLeft > 0 && (_loc3_.luckyHandCouponEnabled))
                  {
                     _loc10_.visible = false;
                     _loc10_.enabled = false;
                  }
                  break;
               case POKER_SCORE:
                  _loc10_.y = this.getSideItem(PROFILE).y;
                  _loc10_.timerText = "";
                  _loc10_.visible = false;
                  break;
               case LUCKY_HAND_COUPON:
                  _loc10_.y = 119;
                  if(_loc3_.luckyHandTimeLeft > 0 && (_loc3_.luckyHandCouponEnabled))
                  {
                     _loc10_.visible = true;
                     _loc10_.enabled = true;
                  }
                  else
                  {
                     _loc10_.visible = false;
                     _loc10_.enabled = false;
                  }
                  break;
               case LUCKY_HAND_V2_COUPON:
                  _loc10_.y = 119;
                  _loc10_.icon.visible = false;
                  if(_loc3_.luckyHandTimeLeft > 0 && (_loc3_.luckyHandCouponEnabled))
                  {
                     _loc10_.visible = true;
                     _loc10_.enabled = true;
                  }
                  else
                  {
                     _loc10_.visible = false;
                     _loc10_.enabled = false;
                  }
                  break;
               case AT_TABLE_ERASE_LOSS_COUPON:
                  _loc10_.y = 119;
                  _loc10_.icon.visible = false;
                  _loc10_.enabled = false;
                  _loc10_.visible = false;
                  break;
               case SCRATCHERS:
                  _loc10_.labelTextField.visible = false;
                  break;
               case BLACKJACK:
                  _loc10_.labelTextField.visible = false;
                  break;
               case AMEX_SERVE:
                  this.y = this.y + 40;
                  break;
               case LEADERBOARD:
                  _loc10_.y = 190;
                  _loc10_.icon.alpha = 1;
                  this.siCont.removeChild(_loc10_);
                  break;
            }
            
            if(_loc4_[_loc8_].showNew)
            {
               _loc12_ = new GlowTextBox(LocaleManager.localize("flash.global.new"));
               _loc12_.x = 35;
               _loc12_.y = 14;
               _loc12_.name = "starburst";
               _loc12_.width = LocaleManager.locale == "fr" || LocaleManager.locale == "es" || LocaleManager.locale == "it"?35:30;
               _loc10_.addChild(_loc12_);
            }
            _loc8_++;
         }
         this.siCont.y = Math.round(-this.siCont.height / 2);
         var _loc9_:Box = new Box(this.snCont.width,this.snCont.height,16711680,false);
         _loc9_.y = this.siCont.y;
         _loc9_.alpha = 0;
         this.initListeners();
      }
      
      public function initMiniArcade(param1:Array) : void {
         this.miniArcade = new SideNavMiniArcade(param1);
         this.navItems.push(this.miniArcade);
         this.miniArcade.addEventListener(MouseEvent.ROLL_OVER,this.siOver,false,0,true);
         this.miniArcade.addEventListener(MouseEvent.ROLL_OVER,this.onArcadeMouseOver,false,0,true);
         this.miniArcade.addEventListener(MouseEvent.ROLL_OUT,this.siOut,false,0,true);
         this.miniArcade.addEventListener(NVEvent.ARCADE_PLAYNOW_CLICKED,this.onArcadePlayNowClicked,false,0,true);
         this.miniArcade.y = (this.miniArcade.h + 1) * (this.navItems.length-1) + this.miniArcade.h / 3;
         this.siCont.y = Math.round(-this.siCont.height / 2);
         this.siCont.addChild(this.miniArcade);
         this.miniArcade.y = 1;
         this.miniArcade.visible = false;
      }
      
      public function getSideItem(param1:String) : SidenavItem {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < this.navItems.length)
         {
            if(this.navItems[_loc2_].id == param1)
            {
               return this.navItems[_loc2_];
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.miniArcade.navItems.length)
         {
            if(this.miniArcade.navItems[_loc2_].id == param1)
            {
               return this.miniArcade.navItems[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function addSideItem(param1:String) : Boolean {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < this.navItems.length)
         {
            if(this.navItems[_loc2_].id == param1)
            {
               if(!this.siCont.contains(this.navItems[_loc2_]))
               {
                  this.siCont.addChild(this.navItems[_loc2_]);
               }
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function removeSideItem(param1:String) : Boolean {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < this.navItems.length)
         {
            if(this.navItems[_loc2_].id == param1)
            {
               if(this.siCont.contains(this.navItems[_loc2_]))
               {
                  this.siCont.removeChild(this.navItems[_loc2_]);
               }
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function set enabled(param1:Boolean) : void {
         this._enabled = param1;
         var _loc2_:* = 0;
         if(this._enabled)
         {
            alpha = 1;
            _loc2_ = 0;
            while(_loc2_ < this.navItems.length)
            {
               this.navItems[_loc2_].mouseEnabled = true;
               _loc2_++;
            }
         }
         else
         {
            alpha = 0.5;
            _loc2_ = 0;
            while(_loc2_ < this.navItems.length)
            {
               this.navItems[_loc2_].mouseEnabled = false;
               _loc2_++;
            }
         }
      }
      
      public function get enabled() : Boolean {
         return this._enabled;
      }
      
      private function initListeners() : void {
         SidenavEvents.disp.addEventListener(SidenavEvents.CLOSE_PANEL,this.onClosePressed);
      }
      
      private function onArcadeMouseOver(param1:MouseEvent) : void {
         dispatchEvent(new NVEvent(NVEvent.HIDE_ARCADE_LUCKYBONUS_AD));
      }
      
      private function siOver(param1:MouseEvent) : void {
         if(!this._enabled)
         {
            return;
         }
         var _loc2_:SidenavItem = param1.currentTarget as SidenavItem;
         if(_loc2_.enabled)
         {
            _loc2_.rollOver();
         }
      }
      
      private function siOut(param1:MouseEvent) : void {
         var _loc2_:SidenavItem = param1.currentTarget as SidenavItem;
         _loc2_.rollOut();
      }
      
      private function siClick(param1:MouseEvent) : void {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(!this._enabled)
         {
            return;
         }
         var _loc2_:SidenavItem = param1.currentTarget as SidenavItem;
         for (_loc3_ in this.navItems)
         {
            if(_loc2_ == this.navItems[_loc3_])
            {
               if(!_loc2_.enabled)
               {
                  return;
               }
               if(this.navItems[_loc3_].isSelected)
               {
                  this.navItems[_loc3_].makeSelected(false);
                  SidenavEvents.quickThrow(SidenavEvents.CLOSE_PANEL,_loc2_.id);
                  break;
               }
               _loc2_.rollOver();
               dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
               this.navItems[_loc3_].makeSelected(true);
               if(this.navItems[_loc3_].id == LUCKY_BONUS)
               {
                  for (_loc4_ in this.navItems)
                  {
                     if(this.navItems[_loc4_].id == MINI_ARCADE)
                     {
                        this.navItems[_loc4_].navItems[2].makeSelected(true);
                        break;
                     }
                  }
               }
               SidenavEvents.quickThrow(SidenavEvents.REQUEST_PANEL,_loc2_.id);
               break;
            }
            this.navItems[_loc3_].makeSelected(false);
         }
      }
      
      public function getIsSidebarItemSelected(param1:String="") : Boolean {
         var _loc2_:String = null;
         for (_loc2_ in this.navItems)
         {
            if(this.navItems[_loc2_].id.toLowerCase() == param1.toLowerCase() && (this.navItems[_loc2_].isSelected))
            {
               return true;
            }
         }
         return false;
      }
      
      public function setSidebarItemsSelected(param1:String="") : void {
         var _loc2_:String = null;
         for (_loc2_ in this.navItems)
         {
            if(this.navItems[_loc2_].id.toLowerCase().split(" ").join("") == param1.toLowerCase())
            {
               this.navItems[_loc2_].rollOver();
               this.navItems[_loc2_].makeSelected(true);
            }
            else
            {
               this.navItems[_loc2_].makeSelected(false);
            }
         }
      }
      
      public function setSidebarItemsDeselected(param1:String="") : void {
         var _loc2_:String = null;
         if(param1 != "")
         {
            for (_loc2_ in this.navItems)
            {
               if(this.navItems[_loc2_].id.toLowerCase().split(" ").join("") == param1.toLowerCase().split(" ").join(""))
               {
                  this.navItems[_loc2_].makeSelected(false);
               }
            }
         }
         else
         {
            for (_loc2_ in this.navItems)
            {
               if(!this.navItems[_loc2_].isSelected)
               {
                  this.navItems[_loc2_].makeSelected(false);
               }
            }
         }
         for (_loc2_ in this.miniArcade.navItems)
         {
            this.miniArcade.navItems[_loc2_].makeSelected(false);
         }
      }
      
      public function setSidebarItemIsEnabled(param1:String="", param2:Boolean=true) : void {
         var _loc3_:String = null;
         for (_loc3_ in this.navItems)
         {
            if(this.navItems[_loc3_].id.toLowerCase() == param1.toLowerCase())
            {
               this.setSidebarItemsDeselected(param1);
               if(param2)
               {
                  this.navItems[_loc3_].alpha = 1;
                  this.navItems[_loc3_].enabled = true;
               }
               else
               {
                  this.navItems[_loc3_].alpha = 0.5;
                  this.navItems[_loc3_].enabled = false;
               }
            }
         }
      }
      
      public function setSidebarItemVisibility(param1:String, param2:Boolean) : void {
         var _loc3_:String = null;
         for (_loc3_ in this.navItems)
         {
            if(this.navItems[_loc3_].id.toLowerCase() == param1.toLowerCase())
            {
               this.navItems[_loc3_].visible = param2;
            }
         }
      }
      
      public function onClosePressed(param1:SidenavEvents) : void {
         var _loc2_:String = null;
         for (_loc2_ in this.navItems)
         {
            this.navItems[_loc2_].makeSelected(false);
         }
      }
      
      private function onArcadePlayNowClicked(param1:NVEvent) : void {
         dispatchEvent(param1);
      }
   }
}
