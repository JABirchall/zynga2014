package com.zynga.rad.fonts
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.Font;
   
   public class FontLibrary extends Object
   {
      
      public function FontLibrary(param1:Object) {
         this.m_fontMappings = {};
         this.m_fontNameToFont = {};
         super();
         if(param1 != SINGLETON_ENFORCER)
         {
            throw new Error("FontLibrary is a singleton");
         }
         else
         {
            return;
         }
      }
      
      private static var SINGLETON_ENFORCER:Object;
      
      private static var m_instance:FontLibrary;
      
      public static function get instance() : FontLibrary {
         if(!m_instance)
         {
            m_instance = new FontLibrary(SINGLETON_ENFORCER);
         }
         return m_instance;
      }
      
      private var m_fontMappings:Object;
      
      private var m_fontNameToFont:Object;
      
      public function setTextFormat(param1:TextField) : void {
         var _loc4_:* = false;
         var _loc2_:TextFormat = param1.getTextFormat();
         var _loc3_:Font = this.m_fontMappings[_loc2_.font] as Font;
         if(_loc3_)
         {
            _loc4_ = _loc3_.hasGlyphs("Label");
            _loc2_.font = _loc3_.fontName;
            param1.defaultTextFormat = _loc2_;
            param1.embedFonts = true;
            param1.text = param1.text;
         }
      }
      
      public function addMapping(param1:String, param2:Class) : void {
         Font.registerFont(param2);
         var _loc3_:Font = new param2() as Font;
         this.m_fontMappings[param1] = _loc3_;
         this.m_fontNameToFont[_loc3_.fontName] = _loc3_;
      }
      
      public function getFont(param1:String) : Font {
         return this.m_fontMappings[param1];
      }
      
      public function getFontClassByName(param1:String) : Font {
         return this.m_fontNameToFont[param1] as Font;
      }
   }
}
