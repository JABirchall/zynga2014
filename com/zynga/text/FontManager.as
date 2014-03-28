package com.zynga.text
{
   import flash.text.Font;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.AntiAliasType;
   
   public class FontManager extends Object
   {
      
      public function FontManager(param1:FontManager_SingletonLockingClass) {
         super();
      }
      
      private static var fonts:Object;
      
      public static var minFontSize:int = 0;
      
      public static var maxFontSize:int = int.MAX_VALUE;
      
      public static function initFonts(param1:Array) : void {
         var _loc2_:Font = null;
         fonts = {};
         for each (fonts[_loc2_.fontName] in param1)
         {
         }
      }
      
      public static function isFontEmbedded(param1:String) : Boolean {
         return (fonts) && (fonts[param1])?true:false;
      }
      
      public static function getFont(param1:String) : Font {
         var _loc2_:Font = (fonts) && (fonts[param1])?fonts[param1]:null;
         return _loc2_;
      }
      
      public static function fontHasGlyphs(param1:String, param2:String, param3:Boolean=false) : Boolean {
         var _loc5_:String = null;
         var _loc6_:RegExp = null;
         var _loc7_:* = 0;
         var _loc8_:Array = null;
         var _loc9_:RegExp = null;
         var _loc10_:Array = null;
         if(!param2)
         {
            return true;
         }
         var _loc4_:Font = getFont(param1);
         if(_loc4_)
         {
            _loc5_ = param2.replace(new RegExp("[\\n\\r\\t]","g"),"");
            if(param3)
            {
               _loc5_ = _loc5_.replace(new RegExp("<\\/?(?!font\\b)[a-z](?:[^>\"\']|\"[^\"]*\"|\'[^\']*\')*>","gi"),"");
               _loc6_ = new RegExp("(<font(?:[^>\"\']|\"[^\"]*\"|\'[^\']*\')*>)(?:(?=([^<]+))\\2|<(?!font\\b[^>]*>))*?<\\/font>","i");
               _loc7_ = 0;
               while(_loc8_ = _loc6_.exec(_loc5_))
               {
                  _loc7_++;
                  if(_loc7_ >= 100)
                  {
                     return false;
                  }
                  _loc9_ = new RegExp("face=(?:\'|\")(\\w+)(?:\'|\")","i");
                  _loc10_ = _loc9_.exec(_loc8_[1]);
                  if((_loc10_) && !(_loc10_[1] == param1))
                  {
                     _loc5_ = _loc5_.replace(_loc8_[0],"");
                     if(!fontHasGlyphs(_loc10_[1],_loc8_[2],true))
                     {
                        return false;
                     }
                  }
                  else
                  {
                     _loc5_ = _loc5_.replace(_loc8_[0],_loc8_[2]);
                  }
               }
            }
            if(_loc4_.hasGlyphs(_loc5_))
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public static function sanitizeFontSize(param1:int) : int {
         if(minFontSize > 0 && param1 < minFontSize)
         {
            param1 = minFontSize;
         }
         if(maxFontSize < int.MAX_VALUE && param1 > maxFontSize)
         {
            param1 = maxFontSize;
         }
         return param1;
      }
      
      public static function sanitizeAndSetText(param1:String, param2:TextField) : void {
         var _loc3_:TextFormat = param2.getTextFormat();
         if((isFontEmbedded(_loc3_.font)) && (fontHasGlyphs(_loc3_.font,param1,true)))
         {
            param2.embedFonts = true;
            param2.antiAliasType = AntiAliasType.ADVANCED;
         }
         else
         {
            param2.embedFonts = false;
         }
         param2.text = param1;
      }
   }
}
class FontManager_SingletonLockingClass extends Object
{
   
   function FontManager_SingletonLockingClass() {
      super();
   }
}
