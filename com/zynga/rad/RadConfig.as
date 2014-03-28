package com.zynga.rad
{
   import flash.display.Stage;
   import com.zynga.rad.interfaces.ILocalizer;
   
   public class RadConfig extends Object
   {
      
      public function RadConfig() {
         super();
      }
      
      protected var m_stage:Stage = null;
      
      public var m_registerMouseWheelCallback:Function = null;
      
      public function get stage() : Stage {
         return this.m_stage;
      }
      
      public function set stage(param1:Stage) : void {
         this.m_stage = param1;
      }
      
      public function onRegisterMouseWheelCallback() : void {
         if(this.m_registerMouseWheelCallback != null)
         {
            this.m_registerMouseWheelCallback();
         }
      }
      
      public function get localizer() : ILocalizer {
         return null;
      }
      
      public function get localeCode() : String {
         return "en_US";
      }
      
      public function get rtl() : Number {
         return BaseUI.BIDI_LTR;
      }
      
      public function onGetLocalizedString(param1:String) : String {
         return param1;
      }
   }
}
