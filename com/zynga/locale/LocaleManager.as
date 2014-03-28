package com.zynga.locale
{
   public class LocaleManager extends Object
   {
      
      public function LocaleManager() {
         super();
      }
      
      private static var _properties:Object;
      
      private static var _isZLocMode:Boolean = true;
      
      private static var _locale:String = "en";
      
      private static var _countryCode:String = "US";
      
      public static function get countryCode() : String {
         return _countryCode;
      }
      
      public static function set countryCode(param1:String) : void {
         _countryCode = param1.toUpperCase();
      }
      
      public static function get locale() : String {
         return _locale;
      }
      
      public static function set locale(param1:String) : void {
         _locale = param1;
      }
      
      public static function parseProperties(param1:XML) : void {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:* = 0;
         var _loc6_:String = null;
         var _loc7_:* = 0;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc2_:String = param1.name().localName;
         _properties = {};
         _isZLocMode = false;
         if(_loc2_ == "properties")
         {
            _loc3_ = String(param1);
            _loc4_ = _loc3_.split("\n");
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc6_ = _loc4_[_loc5_] as String;
               if((_loc6_) && !(_loc6_.indexOf("#") == 0))
               {
                  _loc6_ = _loc6_.replace(new RegExp("\\r","g"),"");
                  _loc7_ = _loc6_.indexOf("=");
                  if(_loc7_ > 0)
                  {
                     _loc8_ = _loc6_.substring(0,_loc7_);
                     _loc9_ = _loc6_.substring(_loc7_ + 1);
                     if(_loc8_)
                     {
                        _properties[_loc8_] = _loc9_;
                     }
                  }
               }
               _loc5_++;
            }
         }
      }
      
      private static function getProperty(param1:String) : String {
         var _loc2_:* = "";
         if((_properties) && (_properties[param1]))
         {
            _loc2_ = String(_properties[param1]);
         }
         if(_loc2_)
         {
            _loc2_ = _loc2_.replace(new RegExp("\\\\n","g"),"\n");
         }
         return _loc2_;
      }
      
      public static function localize(param1:String, param2:Object=null) : String {
         var placeholderKey:String = null;
         var tokenValue:String = null;
         var splitToken:Array = null;
         var placeholderKeyA:String = null;
         var key:String = param1;
         var placeholderValues:Object = param2;
         var value:String = "";
         var tokens:Object = new Object();
         if(!_isZLocMode)
         {
            value = getProperty(key);
            if((value) && (placeholderValues))
            {
               for (placeholderKey in placeholderValues)
               {
                  if(placeholderValues[placeholderKey].hasOwnProperty("type"))
                  {
                     switch(placeholderValues[placeholderKey].type)
                     {
                        case "tn":
                           placeholderValues[placeholderKey] = placeholderValues[placeholderKey].name;
                           if(value.indexOf(",name") != -1)
                           {
                              value = value.replace(",name","");
                           }
                           value = value.replace("{" + placeholderKey + "}",String(placeholderValues[placeholderKey]));
                           break;
                        case "tk":
                           tokenValue = getProperty(placeholderValues[placeholderKey].key + ",object");
                           splitToken = [];
                           if(locale == "zh")
                           {
                              splitToken = tokenValue.split("一");
                           }
                           else
                           {
                              splitToken = tokenValue.split(" ");
                           }
                           tokenValue = splitToken[1];
                           if(int(placeholderValues[placeholderKey].count) > 1 && locale == "en")
                           {
                              tokenValue = tokenValue + "s";
                           }
                           value = value.replace("{" + placeholderValues[placeholderKey].key + ",count" + "}",tokenValue);
                           break;
                     }
                     
                  }
                  else
                  {
                     value = value.replace("{" + placeholderKey + "}",String(placeholderValues[placeholderKey]));
                  }
               }
            }
         }
         else
         {
            try
            {
               if(placeholderValues)
               {
                  for (placeholderKeyA in placeholderValues)
                  {
                     if(placeholderValues[placeholderKeyA].hasOwnProperty("type"))
                     {
                        switch(placeholderValues[placeholderKeyA].type)
                        {
                           case "tn":
                              tokens[placeholderKeyA] = ZLoc.tn(placeholderValues[placeholderKeyA].name,placeholderValues[placeholderKeyA].gender);
                              break;
                           case "tk":
                              tokens[placeholderKeyA] = ZLoc.tk("poker.flash",placeholderValues[placeholderKeyA].key,placeholderValues[placeholderKeyA].attributes,placeholderValues[placeholderKeyA].count);
                              break;
                        }
                        
                     }
                     else
                     {
                        if(String(placeholderKeyA) == "name")
                        {
                           tokens[placeholderKeyA] = ZLoc.tn(placeholderValues[placeholderKeyA]);
                        }
                        else
                        {
                           tokens[placeholderKeyA] = placeholderValues[placeholderKeyA];
                        }
                     }
                  }
               }
               value = ZLoc.t("poker.flash",key,tokens);
            }
            catch(e:Error)
            {
               value = "????";
            }
         }
         if(!_isZLocMode)
         {
            if(value.search("Cannot find string ") != -1)
            {
               value = "----";
            }
            value = value.replace(new RegExp("[\\‘\\’]","g"),"\'");
            value = value.replace(new RegExp("[\\“\\”]","g"),"\"");
            value = value.replace(new RegExp("[\\–\\—]","g"),"-");
            return value.replace(new RegExp("{%newline%}","g"),"\n");
         }
         if(value.search("Cannot find string ") != -1)
         {
            value = "----";
         }
         value = value.replace(new RegExp("[\\‘\\’]","g"),"\'");
         value = value.replace(new RegExp("[\\“\\”]","g"),"\"");
         value = value.replace(new RegExp("[\\–\\—]","g"),"-");
         return value.replace(new RegExp("{%newline%}","g"),"\n");
      }
      
      public static function get isZLocMode() : Boolean {
         return _isZLocMode;
      }
      
      public static function isEastAsianLanguage() : Boolean {
         return locale == "zh";
      }
      
      private static function formatChineseTime(param1:Date) : String {
         var _loc2_:* = "上午";
         if(param1.hours < 12)
         {
            _loc2_ = "上午";
         }
         else
         {
            if(param1.hours == 12)
            {
               _loc2_ = "中午";
            }
            else
            {
               _loc2_ = "下午";
            }
         }
         var _loc3_:String = buildTwelveHourTime(param1,":",false);
         return _loc2_ + _loc3_;
      }
      
      private static function buildTwelveHourTime(param1:Date, param2:String=":", param3:Boolean=true) : String {
         var _loc5_:String = null;
         var _loc4_:* = "";
         if(!param1.hours)
         {
            _loc4_ = _loc4_ + "12";
         }
         else
         {
            if(param1.hours > 12)
            {
               _loc4_ = _loc4_ + String(param1.hours - 12);
            }
            else
            {
               _loc4_ = _loc4_ + String(param1.hours);
            }
         }
         _loc4_ = _loc4_ + param2;
         _loc4_ = _loc4_ + zeroPadMinutes(param1.minutes);
         if(param3)
         {
            _loc5_ = "AM";
            if(param1.hours > 11)
            {
               _loc5_ = "PM";
            }
            _loc4_ = _loc4_ + (" " + _loc5_);
         }
         return _loc4_;
      }
      
      private static function zeroPadMinutes(param1:int) : String {
         return param1 < 10?"0" + param1:String(param1);
      }
      
      public static function localizeTime(param1:Date) : String {
         if(!param1)
         {
            return "---";
         }
         var _loc2_:* = ":";
         var _loc3_:* = "";
         switch(locale)
         {
            case "zh":
               _loc3_ = formatChineseTime(param1);
               break;
            case "es":
            case "en":
            case "en_US":
            case "en_GB":
            case "en_UK":
               _loc3_ = buildTwelveHourTime(param1);
               break;
            default:
               _loc3_ = param1.hours + _loc2_ + zeroPadMinutes(param1.minutes);
         }
         
         return _loc3_;
      }
      
      public static function localizeDate(param1:Date, param2:Boolean=true) : String {
         var _loc3_:String = null;
         if(!param1)
         {
            return "---";
         }
         var _loc4_:* = "/";
         if(_countryCode == "US" && locale.indexOf("en") >= 0)
         {
            _loc3_ = param1.month + 1 + _loc4_ + param1.date;
            if(param2)
            {
               _loc3_ = _loc3_ + (_loc4_ + param1.fullYear);
            }
            return _loc3_;
         }
         switch(locale)
         {
            case "zh":
            case "de":
               _loc4_ = ".";
               break;
         }
         
         _loc3_ = param1.date + _loc4_ + (param1.month + 1);
         if(param2)
         {
            _loc3_ = _loc3_ + (_loc4_ + param1.fullYear);
         }
         return _loc3_;
      }
   }
}
