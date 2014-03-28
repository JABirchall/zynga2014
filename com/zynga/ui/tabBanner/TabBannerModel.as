package com.zynga.ui.tabBanner
{
   import flash.utils.Dictionary;
   import flash.display.DisplayObjectContainer;
   
   public class TabBannerModel extends Object
   {
      
      public function TabBannerModel() {
         super();
      }
      
      private var _attachedViews:Dictionary;
      
      public function get attachedViews() : Dictionary {
         return this._attachedViews;
      }
      
      private var _isActiveVisible:Boolean;
      
      public function get isActiveVisible() : Boolean {
         return this._isActiveVisible;
      }
      
      public function set isActiveVisible(param1:Boolean) : void {
         this._isActiveVisible = param1;
      }
      
      private var _activeViewKey:String;
      
      public function get activeViewKey() : String {
         return this._activeViewKey;
      }
      
      public function set activeViewKey(param1:String) : void {
         this._activeViewKey = param1;
      }
      
      private var _masterContainer:DisplayObjectContainer;
      
      public function get masterContainer() : DisplayObjectContainer {
         return this._masterContainer;
      }
      
      public function init(param1:DisplayObjectContainer) : void {
         this._masterContainer = param1;
         this._attachedViews = new Dictionary();
         this._isActiveVisible = false;
         this._activeViewKey = "";
      }
   }
}
