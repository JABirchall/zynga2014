package com.zynga.poker.feature
{
   import com.zynga.poker.ConfigModel;
   import com.zynga.poker.PokerGlobalData;
   
   public class FeatureModel extends Object
   {
      
      public function FeatureModel() {
         super();
      }
      
      public var configModel:ConfigModel;
      
      public var pgData:PokerGlobalData;
      
      public function init() : void {
      }
      
      public function dispose() : void {
      }
   }
}
