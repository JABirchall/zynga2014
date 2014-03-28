package com.zynga.poker.popups.modules.profile.model
{
   import flash.events.EventDispatcher;
   import com.zynga.poker.popups.modules.events.ProfileEvent;
   
   public class ProfileModel extends EventDispatcher
   {
      
      public function ProfileModel() {
         super();
         this._overviewModel = new ProfileOverviewModel();
         this._itemModel = new ProfileItemModel();
         this._collModel = new ProfileCollectionModel();
         this._achievementModel = new ProfileAchievementModel();
      }
      
      public var fg:int;
      
      public var viewerIsMod:Boolean = false;
      
      public var rootURL:String = "";
      
      public var staticRootURL:String = "";
      
      public var masteryIconSubDir:String = "";
      
      public var zid:String = "";
      
      public var showBuddiesButton:Boolean = false;
      
      public var showScoreCardButton:Boolean = false;
      
      public var gender:String;
      
      public var isOwnProfile:Boolean = false;
      
      public var isFriend:Boolean = false;
      
      public var sig:String = "";
      
      public var inLobby:Boolean = true;
      
      private var _maxAchievementMasteryLevel:int;
      
      public var enableAchievementOverlayText:Boolean = true;
      
      public var unclaimedAchievements:Array;
      
      public var hasViewedOwnAchievementsTab:Boolean = false;
      
      public var achievementClickActionsEnabled:Boolean = true;
      
      private var _playerName:String = "";
      
      public function get playerName() : String {
         return this._playerName;
      }
      
      public function set playerName(param1:String) : void {
         if(this._playerName != param1)
         {
            this._playerName = param1;
            dispatchEvent(new ProfileEvent(ProfileEvent.PLAYER_NAME_UPDATED));
         }
      }
      
      private var _overviewModel:ProfileOverviewModel;
      
      private var _itemModel:ProfileItemModel;
      
      private var _collModel:ProfileCollectionModel;
      
      private var _achievementModel:ProfileAchievementModel;
      
      public function set pic(param1:String) : void {
         this._itemModel.pic = param1;
      }
      
      public function get pic() : String {
         return this._itemModel.pic;
      }
      
      public function set shownGiftID(param1:int) : void {
         this._itemModel.shownGiftID = param1;
      }
      
      public function get shownGiftID() : int {
         return this._itemModel.shownGiftID;
      }
      
      public function set itemsToHide(param1:Array) : void {
         this._overviewModel.itemsToHide = param1;
      }
      
      public function get itemsToHide() : Array {
         return this._overviewModel.itemsToHide;
      }
      
      public function set isNonCollections(param1:Boolean) : void {
         this._collModel.isNonCollections = param1;
      }
      
      public function get isNonCollections() : Boolean {
         return this._collModel.isNonCollections;
      }
      
      public function set hasViewedOwnCollectionsTab(param1:Boolean) : void {
         this._collModel.hasViewedOwnCollectionsTab = param1;
      }
      
      public function get hasViewedOwnCollectionsTab() : Boolean {
         return this._collModel.hasViewedOwnCollectionsTab;
      }
      
      public function set firstTimeCollections(param1:Boolean) : void {
         this._collModel.firstTimeCollections = param1;
      }
      
      public function get firstTimeCollections() : Boolean {
         return this._collModel.firstTimeCollections;
      }
      
      public function set disableCollectionTrade(param1:Boolean) : void {
         this._collModel.disableCollectionTrade = param1;
      }
      
      public function get disableCollectionTrade() : Boolean {
         return this._collModel.disableCollectionTrade;
      }
      
      public function set disableCollectionWishlist(param1:Boolean) : void {
         this._collModel.disableCollectionWishlist = param1;
      }
      
      public function get disableCollectionWishlist() : Boolean {
         return this._collModel.disableCollectionWishlist;
      }
      
      public function set uid(param1:String) : void {
         this._collModel.uid = param1;
      }
      
      public function get uid() : String {
         return this._collModel.uid;
      }
      
      public function set collections(param1:Array) : void {
         this._collModel.collections = param1;
      }
      
      public function get collections() : Array {
         return this._collModel.collections;
      }
      
      public function set xpMultiplier(param1:Number) : void {
         this._collModel.xpMultiplier = param1;
      }
      
      public function get xpMultiplier() : Number {
         return this._collModel.xpMultiplier;
      }
      
      public function get holidayCollectionEnabled() : Boolean {
         return this._collModel.holidayCollectionEnabled;
      }
      
      public function set holidayCollectionEnabled(param1:Boolean) : void {
         this._collModel.holidayCollectionEnabled = param1;
      }
      
      public function get limitedTimeAltText() : String {
         return this._collModel.limitedTimeAltText;
      }
      
      public function set limitedTimeAltText(param1:String) : void {
         this._collModel.limitedTimeAltText = param1;
      }
      
      public function set collectionSortingOptions(param1:uint) : void {
         this._collModel.collectionSortingOptions = param1;
      }
      
      public function get collectionSortingOptions() : uint {
         return this._collModel.collectionSortingOptions;
      }
      
      public function set achievements(param1:Object) : void {
         this._achievementModel.achievements = param1;
      }
      
      public function get achievements() : Object {
         return this._achievementModel.achievements;
      }
      
      public function set gifts(param1:Array) : void {
         this._itemModel.gifts = param1;
      }
      
      public function get gifts() : Array {
         return this._itemModel.gifts;
      }
      
      public function set userData(param1:Object) : void {
         this._overviewModel.userData = param1;
      }
      
      public function get userData() : Object {
         return this._overviewModel.userData;
      }
      
      public function set maxAchievementMasteryLevel(param1:int) : void {
         this._maxAchievementMasteryLevel = param1;
      }
      
      public function get maxAchievementMasteryLevel() : int {
         return this._maxAchievementMasteryLevel;
      }
   }
}
