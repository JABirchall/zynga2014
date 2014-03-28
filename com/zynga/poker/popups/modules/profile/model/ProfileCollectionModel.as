package com.zynga.poker.popups.modules.profile.model
{
   public class ProfileCollectionModel extends Object
   {
      
      public function ProfileCollectionModel() {
         super();
      }
      
      public var isNonCollections:Boolean = false;
      
      public var hasViewedOwnCollectionsTab:Boolean = false;
      
      public var firstTimeCollections:Boolean = false;
      
      public var disableCollectionTrade:Boolean = false;
      
      public var disableCollectionWishlist:Boolean = false;
      
      public var uid:String;
      
      public var collections:Array;
      
      public var xpMultiplier:Number;
      
      public var holidayCollectionEnabled:Boolean = false;
      
      public var collectionSortingOptions:uint = 16;
      
      public var limitedTimeAltText:String;
   }
}
