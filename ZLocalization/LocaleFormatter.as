package ZLocalization
{
   import ZLocalization.PluralDeterminers.PluralDeterminer;
   import com.adobe.serialization.json.JSON;
   
   public class LocaleFormatter extends Object
   {
      
      public function LocaleFormatter() {
         super();
      }
      
      public static const CURRENT_LOCALE:String = "current_locale";
      
      public static const CURRENCY_DELIM:String = "{n}";
      
      public static const LONG_DATE:String = "longDate";
      
      protected static const PACKAGE_NAME:String = "ZLocDateTimeFormats";
      
      protected static const CURRENCY:String = "currency";
      
      protected static const DATE:String = "date";
      
      protected static const NUMBER:String = "number";
      
      protected static const DURIATION:String = "duriation";
      
      protected static const TIME:String = "time";
      
      protected static const AM:String = "am";
      
      protected static const PM:String = "pm";
      
      public static const SHORT_NUMBER:String = "shortNumber";
      
      private static var currencyFormats:Object;
      
      public static const RELTIME_BLANK:int = 0;
      
      public static const RELTIME_AGO:int = 1;
      
      public static const RELTIME_IN:int = 2;
      
      public static const RELTIME_DECIMAL:int = 4;
      
      public static const RELTIME_SEC:int = 8;
      
      public static const RELTIME_MIN:int = 16;
      
      public static const RELTIME_HRS:int = 32;
      
      public static const RELTIME_DAY:int = 64;
      
      public static const RELTIME_WKS:int = 128;
      
      public static const RELTIME_MTH:int = 256;
      
      public static const RELTIME_YRS:int = 512;
      
      public static const RELTIME_DEFAULT:int = 1024;
      
      private static var reltimeFlags:Object;
      
      private static var reltimeKeys:Array;
      
      private static var reltimeUnits:Object;
      
      private static var reltimeSuffixes:Object;
      
      private static var monthNames:Array;
      
      private static var dateFormats:Object;
      
      private static var timeFormats:Object;
      
      private static function getFormat(param1:String) : String {
         var _loc2_:Boolean = ZLoc.instance.exists(LocaleFormatter.PACKAGE_NAME,param1);
         return _loc2_?ZLoc.instance.translate(LocaleFormatter.PACKAGE_NAME,param1):null;
      }
      
      public static function formatRelativeTimeRaw(param1:int, param2:int) : String {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public static function formatRelativeTime(param1:int, param2:String) : String {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         while(_loc4_ < param2.length)
         {
            _loc3_ = _loc3_ | reltimeFlags[param2.charAt(_loc4_)];
            _loc4_++;
         }
         return formatRelativeTimeRaw(param1,_loc3_);
      }
      
      public static function formatDate(param1:Date, param2:String="date") : String {
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc8_:Array = null;
         var _loc3_:String = LocaleFormatter.getFormat(param2);
         if(!_loc3_)
         {
            _loc3_ = LocaleFormatter.getFormat(LocaleFormatter.DATE);
         }
         var _loc4_:Array = _loc3_.match(new RegExp("{([^}]+)}","g"));
         var _loc6_:* = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc7_ = _loc4_[_loc6_];
            _loc5_ = LocaleFormatter.getFormattedDateTime(LocaleFormatter.dateFormats[_loc7_],param1);
            _loc8_ = _loc3_.split(_loc7_);
            _loc3_ = _loc8_.join(_loc5_);
            _loc6_++;
         }
         return _loc3_;
      }
      
      public static function formatTime(param1:Date, param2:Boolean=true) : String {
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:Array = null;
         var _loc3_:String = LocaleFormatter.getFormat(LocaleFormatter.TIME);
         if(!param2)
         {
            _loc7_ = _loc3_.replace(":{ss}","");
            if(_loc7_ == _loc3_)
            {
               _loc3_ = _loc3_.replace(new RegExp("({ss}[^{]*)"),"");
            }
            else
            {
               _loc3_ = _loc7_;
            }
         }
         var _loc4_:Array = _loc3_.match(new RegExp("{([^}]+)}","g"));
         var _loc6_:* = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc8_ = _loc4_[_loc6_];
            _loc5_ = LocaleFormatter.getFormattedDateTime(LocaleFormatter.timeFormats[_loc8_],param1);
            _loc9_ = _loc3_.split(_loc8_);
            if(_loc5_ == "pm")
            {
               _loc5_ = LocaleFormatter.getFormat(LocaleFormatter.PM);
            }
            else
            {
               if(_loc5_ == "am")
               {
                  _loc5_ = LocaleFormatter.getFormat(LocaleFormatter.AM);
               }
            }
            _loc3_ = _loc9_.join(_loc5_);
            _loc6_++;
         }
         return _loc3_;
      }
      
      public static function formatDuration(param1:int, param2:Boolean=true, param3:Boolean=true) : String {
         var _loc8_:String = null;
         var _loc9_:Array = null;
         var _loc4_:String = ZLoc.instance.language;
         var _loc5_:int = param1 % 60;
         var _loc6_:int = param1 / 60 % 60;
         var _loc7_:int = Math.floor(param1 / 3600);
         var _loc10_:String = LocaleFormatter.getFormat(LocaleFormatter.DURIATION);
         if(!param3)
         {
            if("{h}:{mm}:{ss}" == _loc10_)
            {
               _loc10_ = "{h}:{mm}";
            }
            else
            {
               _loc10_ = _loc10_.replace(new RegExp("({ss}[^{]*)"),"");
            }
         }
         else
         {
            _loc8_ = _loc5_ < 10?"0" + _loc5_:_loc5_.toString();
            _loc9_ = _loc10_.split("{ss}");
            _loc10_ = _loc9_.join(_loc8_);
         }
         if(!param2 && _loc7_ == 0)
         {
            _loc10_ = _loc10_.replace(new RegExp("([^{]*{h}[^{]*)"),"");
            _loc8_ = _loc6_.toString();
            _loc9_ = _loc10_.split("{mm}");
            _loc10_ = _loc9_.join(_loc8_);
         }
         else
         {
            _loc8_ = _loc6_ < 10?"0" + _loc6_:_loc6_.toString();
            _loc9_ = _loc10_.split("{mm}");
            _loc10_ = _loc9_.join(_loc8_);
            _loc8_ = _loc7_.toString();
            _loc9_ = _loc10_.split("{h}");
            _loc10_ = _loc9_.join(_loc8_);
         }
         return _loc10_;
      }
      
      public static function formatNumber(param1:Number, param2:String="number", param3:Boolean=false) : String {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public static function formatCurrency(param1:Number, param2:String, param3:String="number") : String {
         var _loc4_:String = null;
         if(param2 == LocaleFormatter.CURRENT_LOCALE)
         {
            _loc4_ = LocaleFormatter.getFormat(LocaleFormatter.CURRENCY);
         }
         else
         {
            if(!LocaleFormatter.currencyFormats.hasOwnProperty(param2))
            {
               throw new Error("Locale: " + param2 + ", is unsupported in LocaleFormatter.currencyFormats");
            }
            else
            {
               _loc4_ = LocaleFormatter.currencyFormats[param2];
            }
         }
         var _loc5_:String = LocaleFormatter.formatNumber(param1,param3,true);
         var _loc6_:Array = _loc4_.split(LocaleFormatter.CURRENCY_DELIM);
         return _loc6_.join(_loc5_);
      }
      
      public static function getMultiFormattedDateTime(param1:Array, param2:Date) : Array {
         var _loc3_:Array = new Array();
         var _loc4_:* = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_[_loc4_] = LocaleFormatter.getFormattedDateTime(param1[_loc4_],param2);
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function getFormattedDateTime(param1:String, param2:Date) : String {
         var _loc3_:String = null;
         var _loc4_:* = false;
         var _loc5_:String = null;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:String = null;
         switch(param1)
         {
            case "a":
            case "aa":
               _loc4_ = param2.getHours() < 12;
               if(_loc4_)
               {
                  _loc3_ = "am";
               }
               else
               {
                  _loc3_ = "pm";
               }
               break;
            case "j":
               _loc3_ = param2.getDate().toString();
               if(_loc3_ == "1")
               {
                  _loc8_ = LocaleFormatter.getFormat("first");
                  if(_loc8_)
                  {
                     _loc3_ = _loc3_ + _loc8_;
                  }
               }
               break;
            case "d":
               _loc3_ = param2.getDate().toString();
               if(_loc3_.length == 1)
               {
                  _loc3_ = "0" + _loc3_;
               }
               break;
            case "n":
               _loc3_ = (param2.getMonth() + 1).toString();
               break;
            case "m":
               _loc3_ = (param2.getMonth() + 1).toString();
               if(_loc3_.length == 1)
               {
                  _loc3_ = "0" + _loc3_;
               }
               break;
            case "M":
               _loc5_ = param2.getMonth().toString();
               _loc3_ = ZLoc.instance.translate(PACKAGE_NAME,monthNames[_loc5_]);
               break;
            case "Y":
               _loc3_ = param2.getFullYear().toString();
               break;
            case "g":
               _loc6_ = param2.getHours() % 12;
               if(_loc6_ == 0)
               {
                  _loc6_ = 12;
               }
               _loc3_ = _loc6_.toString();
               break;
            case "h":
               _loc7_ = param2.getHours() % 12;
               if(_loc7_ == 0)
               {
                  _loc7_ = 12;
               }
               _loc3_ = _loc7_.toString();
               if(_loc3_.length == 1)
               {
                  _loc3_ = "0" + _loc3_;
               }
               break;
            case "i":
               _loc3_ = param2.getMinutes().toString();
               if(_loc3_.length == 1)
               {
                  _loc3_ = "0" + _loc3_;
               }
               break;
            case "s":
               _loc3_ = param2.getSeconds().toString();
               if(_loc3_.length == 1)
               {
                  _loc3_ = "0" + _loc3_;
               }
               break;
            case "G":
               _loc3_ = param2.getHours().toString();
               break;
            case "H":
               _loc3_ = param2.getHours().toString();
               if(_loc3_.length == 1)
               {
                  _loc3_ = "0" + _loc3_;
               }
               break;
         }
         
         return _loc3_;
      }
   }
}
