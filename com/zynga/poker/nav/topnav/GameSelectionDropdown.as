package com.zynga.poker.nav.topnav
{
   import flash.display.Sprite;
   import com.zynga.poker.ConfigModel;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   import flash.display.GradientType;
   import flash.events.Event;
   import com.zynga.poker.nav.events.NVEvent;
   
   public class GameSelectionDropdown extends Sprite
   {
      
      public function GameSelectionDropdown(param1:Number, param2:Number=1, param3:Number=2, param4:ConfigModel=null) {
         this.gameNavConfig = {"PokerGenius":
            {
               "icon":"PokerGeniusIcon",
               "tooltip":"",
               "event":NVEvent.SHOW_POKER_GENIUS,
               "offsetY":4,
               "arrow":false
            }};
         super();
         this._dropdownWidth = param1;
         this._borderThickness = param2;
         this._borderRadius = param3;
         this._configModel = param4;
         if(this._configModel)
         {
            if(!this._configModel.getBooleanForFeatureConfig("featureCleanup","isTeamChallengeDisabled"))
            {
               this.gameNavConfig["Challenge"] = 
                  {
                     "icon":"ChallengesIcon",
                     "tooltip":"",
                     "event":NVEvent.SHOW_CHALLENGES,
                     "offsetY":2
                  };
            }
         }
      }
      
      public static const EVENT_ALERT_COUNT_CHANGED:String = "GSD.AlertCountChanged";
      
      public static const EVENT_INIT_COMPLETE:String = "GSD.InitComplete";
      
      public static const EVENT_ITEM_CLOSED:String = "GSD.ItemClosed";
      
      public static const DROPDOWN_ITEM_HEIGHT:Number = 38;
      
      public static const DEFAULT_BORDER_THICKNESS:Number = 1;
      
      public static const DEFAULT_BORDER_RADIUS:Number = 2;
      
      public var gameNavConfig:Object;
      
      private var _borderThickness:Number;
      
      private var _borderRadius:Number;
      
      private var _dropdownWidth:Number;
      
      private var _items:Array;
      
      private var _configModel:ConfigModel;
      
      public function init(param1:Array) : void {
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc6_:String = null;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = false;
         var _loc10_:GameSelectionDropdownItem = null;
         this._items = [];
         var _loc2_:Number = this._borderThickness;
         var _loc3_:Number = this._dropdownWidth - this._borderThickness;
         for each (_loc4_ in param1)
         {
            _loc5_ = this.gameNavConfig[_loc4_];
            if(_loc5_)
            {
               _loc6_ = _loc5_["icon"] as String;
               _loc7_ = _loc5_["offsetX"] != null?_loc5_["offsetX"]:0;
               _loc8_ = _loc5_["offsetY"] != null?_loc5_["offsetY"]:0;
               _loc9_ = _loc5_["arrow"] != null?_loc5_["arrow"]:false;
               _loc10_ = this.createDropdownItem(_loc4_,_loc3_,_loc6_,_loc7_,_loc8_,_loc9_);
               _loc10_.x = this._borderThickness;
               _loc10_.y = _loc2_;
               addChild(_loc10_);
               this._items.push(_loc10_);
               _loc2_ = _loc2_ + _loc10_.itemHeight;
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Unknown o:GameNavDropdownItemInit:" + _loc4_ + ":2012-06-20"));
            }
         }
         graphics.lineStyle(this._borderThickness);
         graphics.lineGradientStyle(GradientType.LINEAR,[7115950,2051179],[1,1],[0,255]);
         graphics.beginFill(0);
         graphics.drawRoundRect(0,0,this._dropdownWidth,_loc2_,this._borderRadius);
         graphics.endFill();
         dispatchEvent(new Event(EVENT_INIT_COMPLETE));
      }
      
      public function fireImpressionStats() : void {
         var _loc2_:GameSelectionDropdownItem = null;
         var _loc1_:* = 0;
         while(_loc1_ < this._items.length)
         {
            _loc2_ = this._items[_loc1_] as GameSelectionDropdownItem;
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:GameNavDropdownItem:" + _loc2_.itemName + (_loc2_.hasArrow()?"WithArrow":"") + ":2012-09-21"));
            _loc1_++;
         }
      }
      
      private function createDropdownItem(param1:String, param2:Number, param3:String, param4:Number, param5:Number, param6:Boolean) : GameSelectionDropdownItem {
         var _loc7_:GameSelectionDropdownItem = new GameSelectionDropdownItem(param1,param2,DROPDOWN_ITEM_HEIGHT,param3,param4,param5,param6);
         _loc7_.addEventListener(GameSelectionDropdownItem.EVENT_ITEM_SELECTED,this.onDropdownItemSelected,false,0,true);
         _loc7_.addEventListener(GameSelectionDropdownItem.EVENT_ITEM_COUNT_CHANGED,this.onItemAlertCountUpdated,false,0,true);
         _loc7_.addEventListener(GameSelectionDropdownItem.EVENT_ITEM_CLOSED,this.onItemClosed,false,0,true);
         return _loc7_;
      }
      
      private function onDropdownItemSelected(param1:Event) : void {
         var _loc2_:GameSelectionDropdownItem = param1.currentTarget as GameSelectionDropdownItem;
         var _loc3_:String = _loc2_.itemName;
         var _loc4_:String = this.gameNavConfig[_loc3_].event;
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:GameNavDropdownItem:" + _loc3_ + ":2012-06-20"));
         dispatchEvent(new NVEvent(_loc4_,null,true));
         this.onItemClosed(param1);
      }
      
      private function onItemAlertCountUpdated(param1:Event) : void {
         dispatchEvent(new Event(EVENT_ALERT_COUNT_CHANGED));
      }
      
      private function onItemClosed(param1:Event) : void {
         dispatchEvent(new Event(EVENT_ITEM_CLOSED));
      }
      
      public function getAlertCount() : int {
         var _loc2_:* = 0;
         var _loc1_:int = this._items.length;
         var _loc3_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = _loc3_ + (this._items[_loc2_] as GameSelectionDropdownItem).count;
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function updateNavItemCount(param1:String, param2:int) : void {
         var _loc3_:GameSelectionDropdownItem = this.getNavItem(param1);
         if(_loc3_ != null)
         {
            _loc3_.updateCount(param2);
         }
      }
      
      public function getNavItem(param1:String) : GameSelectionDropdownItem {
         var _loc4_:* = 0;
         var _loc2_:GameSelectionDropdownItem = null;
         var _loc3_:int = this._items.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(this._items[_loc4_].itemName == param1)
            {
               _loc2_ = this._items[_loc4_] as GameSelectionDropdownItem;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function hideNavItem(param1:String) : void {
         var _loc4_:* = 0;
         var _loc2_:GameSelectionDropdownItem = null;
         var _loc3_:int = this._items.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(this._items[_loc4_].itemName == param1)
            {
               _loc2_ = this._items[_loc4_] as GameSelectionDropdownItem;
               _loc2_.hide();
               break;
            }
            _loc4_++;
         }
      }
      
      public function showNavItem(param1:String) : void {
         var _loc4_:* = 0;
         var _loc2_:GameSelectionDropdownItem = null;
         var _loc3_:int = this._items.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(this._items[_loc4_].itemName == param1)
            {
               _loc2_ = this._items[_loc4_] as GameSelectionDropdownItem;
               _loc2_.show();
               break;
            }
            _loc4_++;
         }
      }
   }
}
