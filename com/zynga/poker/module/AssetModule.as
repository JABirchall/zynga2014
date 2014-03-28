package com.zynga.poker.module
{
   import com.zynga.poker.module.interfaces.IPokerModule;
   
   public class AssetModule extends Object implements IPokerModule
   {
      
      public function AssetModule() {
         super();
      }
      
      private var _id:String = "AssetModule";
      
      public function get moduleID() : String {
         return this._id;
      }
      
      public function set moduleID(param1:String) : void {
         this._id = param1;
      }
   }
}
