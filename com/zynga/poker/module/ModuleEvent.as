package com.zynga.poker.module
{
   import flash.events.Event;
   import com.zynga.poker.module.interfaces.IPokerModule;
   
   public class ModuleEvent extends Event
   {
      
      public function ModuleEvent(param1:String, param2:IPokerModule=null) {
         super(param1);
         this._module = param2;
      }
      
      public static const MODULE_LOADED_EVENT:String = "ModuleEvent.Loaded";
      
      public static const MODULE_LOADFAILED_EVENT:String = "ModuleEvent.LoadFailed";
      
      public static const MODULE_WILLOPEN_EVENT:String = "ModuleEvent.WillOpen";
      
      public static const MODULE_CLOSED_EVENT:String = "ModuleEvent.Closed";
      
      public static const MODULE_WILLCLOSE_EVENT:String = "ModuleEvent.WillClose";
      
      public static const MODULE_PROGRESS_EVENT:String = "ModuleEvent.Progress";
      
      private var _module:IPokerModule;
      
      public function get module() : IPokerModule {
         return this._module;
      }
      
      public function get id() : String {
         if(this._module != null)
         {
            return this._module.moduleID;
         }
         return null;
      }
      
      override public function clone() : Event {
         return new ModuleEvent(this.type,this._module);
      }
      
      override public function toString() : String {
         return formatToString("ModuleEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
