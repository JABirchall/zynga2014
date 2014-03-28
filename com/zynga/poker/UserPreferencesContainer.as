package com.zynga.poker
{
   import com.adobe.serialization.json.JSON;
   
   public class UserPreferencesContainer extends Object
   {
      
      public function UserPreferencesContainer() {
         this._serializedObject = new Object();
         super();
      }
      
      public static const FAST_FILTER:String = "fastFilterValue";
      
      public static const NORMAL_FILTER:String = "normalFilterValue";
      
      public static const TABLE_TYPE:String = "tableTypeValue";
      
      public static const SORT_FILTER:String = "sortFilterValue";
      
      public static const SORT_BY:String = "sortByValue";
      
      public static const HAS_SHOWN_JACKPOT_POWER_UP_CONTENT:String = "hasShownJackpotPowerUpContent";
      
      public static const SLOTS_IS_MUTED:String = "slotsIsMuted";
      
      public static const TABLE_IS_MUTED:String = "tableIsMuted";
      
      public static const HAND_STRENGTH_METER:String = "HSM";
      
      public static const HSM_IMPRESSIONS2:String = "HSMPromo2";
      
      public static const HSM_INLINE_UPSELL_IMPRESSIONS:String = "HSMInlineUpsell";
      
      public static const REBUY_ENABLED:String = "rebuyEnabled";
      
      public static const TOP_UP_ENABLED:String = "topUpEnabled";
      
      public static const HAS_SWITCHED_VIEW:String = "hasSwitchedView";
      
      public static const TBL_LOBBY_PROMO:String = "TBLLobbyPromo";
      
      public static const TBL_POPUP_PROMO:String = "TBLPopupPromo";
      
      public static const ARB_AS_DEFAULT:String = "ARBAsDefault";
      
      public static const FOUR_COLOR_DECK:String = "fourColorDeck";
      
      public static const LUCKY_BONUS_FTUE:String = "ftueLuckyBonus";
      
      public var fastFilterValue:String = "default";
      
      public var normalFilterValue:String = "default";
      
      public var tableTypeValue:String = "normal";
      
      public var sortFilterValue:String = "players";
      
      public var sortByValue:String = "2";
      
      public var everFiltered:String = "0";
      
      public var hasShownJackpotPowerUpContent:String = "0";
      
      public var slotsIsMuted:String = "0";
      
      public var tableIsMuted:String = "0";
      
      public var HSM:String = "0";
      
      public var HSMPromo:String = "0";
      
      public var HSMPromo2:String = "0";
      
      public var HSMInlineUpsell:String = "0";
      
      public var rebuyEnabled:String = "0";
      
      public var topUpEnabled:String = "0";
      
      public var hasSwitchedView:String = "0";
      
      public var TBLLobbyPromo:String = "0";
      
      public var TBLPopupPromo:String = "0";
      
      public var ARBAsDefault:String = "1";
      
      public var fourColorDeck:String = "0";
      
      public var ftueLuckyBonus:String = "0";
      
      protected var _hasAppliedPreferences:Boolean = false;
      
      protected var _hasChanged:Boolean = false;
      
      protected var _lastKeyUpdated:String = "";
      
      protected var _lastValueUpdated:String = "";
      
      protected var _userPreferenceSource:String = "null";
      
      private var _serializedObject:Object;
      
      public function setHasAppliedPreferences() : void {
         this._hasAppliedPreferences = true;
      }
      
      public function getHasAppliedPreferences() : Boolean {
         return this._hasAppliedPreferences;
      }
      
      public function commitValueWithKey(param1:String, param2:*) : void {
         if(param2 == "null" || param2 == null)
         {
            return;
         }
         if((this.hasOwnProperty(param1)) && !(this[param1] == String(param2)))
         {
            this[param1] = String(param2);
            this._serializedObject[param1] = String(param2);
         }
      }
      
      public function getLastKeyUpdated() : String {
         return this._lastKeyUpdated;
      }
      
      public function getLastValueUpdated() : String {
         return this._lastValueUpdated;
      }
      
      public function setHasChanged(param1:Boolean) : void {
         this._hasChanged = param1;
      }
      
      public function getHasChanged() : Boolean {
         return this._hasChanged;
      }
      
      public function setUserPreferenceSource(param1:String) : void {
         this._userPreferenceSource = param1;
      }
      
      public function getUserPreferenceSource() : String {
         return this._userPreferenceSource;
      }
      
      public function getJSONString() : String {
         return com.adobe.serialization.json.JSON.encode(this._serializedObject);
      }
   }
}
