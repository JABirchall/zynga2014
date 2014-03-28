package com.zynga.poker.module
{
   import com.zynga.poker.module.interfaces.IPokerModule;
   
   public class ModuleConfig extends Object
   {
      
      public function ModuleConfig(param1:XML) {
         super();
         this._definition = param1;
         this._id = String(param1.@id);
         this._type = String(param1.@type);
         this._unloadOnClose = Boolean(param1.@unloadOnClose);
         this._moduleClass = String(param1.@moduleClass);
         this._module = null;
         this._isDisplayed = false;
         if(this._type == "flash" && param1.child("content").child("module").length() > 0)
         {
            this._className = String(param1.content.module.@className);
            this._sourceURL = String(param1.content.module.@src);
            this._loadType = String(param1.content.module.@loadType);
         }
      }
      
      private var _definition:XML;
      
      private var _id:String;
      
      private var _type:String;
      
      private var _sourceURL:String;
      
      private var _loadType:String;
      
      private var _className:String;
      
      private var _moduleClass:String;
      
      private var _unloadOnClose:Boolean;
      
      private var _module:IPokerModule;
      
      private var _isDisplayed:Boolean;
      
      public function get type() : String {
         return this._type;
      }
      
      public function get isLoaded() : Boolean {
         return !(this._module == null);
      }
      
      public function get module() : IPokerModule {
         if(this.isLoaded)
         {
            return this._module;
         }
         return null;
      }
      
      public function set module(param1:IPokerModule) : void {
         this._module = param1;
      }
      
      public function get sourceURL() : String {
         return this._sourceURL;
      }
      
      public function get className() : String {
         return this._className;
      }
      
      public function get moduleClass() : String {
         return this._moduleClass;
      }
      
      public function get id() : String {
         return this._id;
      }
      
      public function get shouldUnload() : Boolean {
         return this._unloadOnClose;
      }
      
      public function get isDisplayed() : Boolean {
         return this._isDisplayed;
      }
      
      public function set isDisplayed(param1:Boolean) : void {
         this._isDisplayed = param1;
      }
   }
}
