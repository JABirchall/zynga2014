package com.zynga.format
{
   import com.zynga.locale.LocaleManager;
   import ZLocalization.LocaleFormatter;
   
   public class PokerCurrencyFormatter extends Object implements ICurrencyFormatter
   {
      
      public function PokerCurrencyFormatter(param1:Inner) {
         super();
         if(param1 == null)
         {
            throw new Error("PokerCurrencyFormatter class cannot be instantiated");
         }
         else
         {
            return;
         }
      }
      
      private static const PACKAGE_NAME:String = "ZLocDateTimeFormats";
      
      private static const NUMBER:String = "number";
      
      private static var _currLocale:String = "";
      
      private static var _locale:Array;
      
      private static var _periodDelim:String = null;
      
      private static var _instance:PokerCurrencyFormatter;
      
      public static function getInstance() : PokerCurrencyFormatter {
         if(_instance == null)
         {
            _instance = new PokerCurrencyFormatter(new Inner());
         }
         return _instance;
      }
      
      public static function numberToCurrency(param1:Number, param2:Boolean=true, param3:Number=2, param4:Boolean=true, param5:Boolean=true, param6:Boolean=false) : String {
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc7_:String = null;
         if(isNaN(param1))
         {
            if(param4 == true)
            {
               _loc7_ = LocaleManager.localize("flash.global.currency",{"amount":"0"});
            }
            else
            {
               if(LocaleManager.isZLocMode == true)
               {
                  _loc7_ = LocaleFormatter.formatNumber(0);
               }
               else
               {
                  _loc7_ = "0";
               }
            }
            return _loc7_;
         }
         if(param2)
         {
            initializeAbbreviations();
            _loc8_ = 0;
            while(_loc8_ < _locale.length)
            {
               if(param1 >= _locale[_loc8_].bound)
               {
                  _loc9_ = param1 / _locale[_loc8_].bound;
                  if(param5)
                  {
                     if(param3 == 0)
                     {
                        _loc7_ = Math.floor(_loc9_).toString();
                     }
                     else
                     {
                        if(!param6)
                        {
                           _loc7_ = _loc9_.toFixed(param3);
                        }
                        else
                        {
                           _loc10_ = Math.pow(10,param3);
                           _loc9_ = Math.floor(_loc9_ * _loc10_) / _loc10_;
                           _loc7_ = _loc9_.toString();
                        }
                     }
                  }
                  else
                  {
                     _loc7_ = _loc9_.toString();
                  }
                  _loc7_ = _loc7_.replace(".",_periodDelim);
                  _loc7_ = _loc7_ + _locale[_loc8_].abbr;
                  _loc8_ = _locale.length;
               }
               _loc8_++;
            }
            if(_loc7_ == null)
            {
               _loc7_ = param1.toString();
            }
         }
         else
         {
            _loc7_ = LocaleManager.isZLocMode?LocaleFormatter.formatNumber(param1):StringUtility.formatNumber(param1);
         }
         if(param4)
         {
            _loc7_ = LocaleManager.localize("flash.global.currency",{"amount":_loc7_});
         }
         return _loc7_;
      }
      
      public static function currencyToNumber(param1:String) : Number {
         var _loc8_:String = null;
         var _loc9_:* = NaN;
         initializeAbbreviations();
         var _loc2_:* = false;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:String = grabAbbreviation(param1);
         if(_loc5_ != "")
         {
            param1 = param1.replace(_loc5_,"");
         }
         var _loc6_:Number = 0;
         while(_loc6_ < param1.length)
         {
            _loc8_ = param1.charAt(_loc6_);
            if(!isNaN(Number(_loc8_)) && !(_loc8_ == " "))
            {
               if(_loc2_)
               {
                  _loc3_ = _loc3_ * 10;
                  _loc3_ = _loc3_ + Number(_loc8_);
               }
               else
               {
                  _loc4_ = _loc4_ * 10;
                  _loc4_ = _loc4_ + Number(_loc8_);
               }
            }
            else
            {
               if(_loc8_ == _periodDelim)
               {
                  _loc2_ = true;
               }
            }
            _loc6_++;
         }
         var _loc7_:Number = 0;
         if(_loc5_ == "")
         {
            _loc7_ = _loc4_;
         }
         else
         {
            while(_loc3_ > 1)
            {
               _loc3_ = _loc3_ * 0.1;
            }
            _loc9_ = getAbbreviationValue(_loc5_);
            _loc7_ = _loc4_ * _loc9_ + _loc3_ * _loc9_;
         }
         return _loc7_;
      }
      
      private static function initializeAbbreviations() : void {
         if(_currLocale == LocaleManager.locale)
         {
            return;
         }
         _periodDelim = getDecimalPoint();
         switch(_currLocale)
         {
            case "zh":
               _locale = [
                  {
                     "bound":1.0E12,
                     "abbr":LocaleManager.localize("flash.global.number.trillion")
                  },
                  {
                     "bound":100000000,
                     "abbr":LocaleManager.localize("flash.global.number.eastasia.100m")
                  },
                  {
                     "bound":10000,
                     "abbr":LocaleManager.localize("flash.global.number.eastasia.10k")
                  }];
               break;
            case "es":
               _locale = [
                  {
                     "bound":1.0E12,
                     "abbr":LocaleManager.localize("flash.global.number.trillion")
                  },
                  {
                     "bound":1000000000,
                     "abbr":LocaleManager.localize("flash.global.number.billion")
                  },
                  {
                     "bound":1000000,
                     "abbr":LocaleManager.localize("flash.global.number.million")
                  }];
               break;
            default:
               _locale = [
                  {
                     "bound":1.0E12,
                     "abbr":LocaleManager.localize("flash.global.number.trillion")
                  },
                  {
                     "bound":1000000000,
                     "abbr":LocaleManager.localize("flash.global.number.billion")
                  },
                  {
                     "bound":1000000,
                     "abbr":LocaleManager.localize("flash.global.number.million")
                  },
                  {
                     "bound":1000,
                     "abbr":LocaleManager.localize("flash.global.number.thousand")
                  }];
         }
         
         _currLocale = LocaleManager.locale;
      }
      
      private static function getAbbreviationValue(param1:String) : Number {
         var _loc2_:Number = 0;
         while(_loc2_ < _locale.length)
         {
            if(_locale[_loc2_].abbr == param1)
            {
               return _locale[_loc2_].bound;
            }
            _loc2_++;
         }
         return 0;
      }
      
      private static function grabAbbreviation(param1:String) : String {
         var _loc2_:Number = 0;
         while(_loc2_ < _locale.length)
         {
            if(param1.search(_locale[_loc2_].abbr) != -1)
            {
               return _locale[_loc2_].abbr;
            }
            _loc2_++;
         }
         return "";
      }
      
      public static function getFormattedNumber(param1:Number) : String {
         return LocaleManager.isZLocMode?LocaleFormatter.formatNumber(param1):StringUtility.formatNumber(param1);
      }
      
      public static function getDecimalPoint() : String {
         var _loc1_:String = null;
         var _loc2_:Array = null;
         if(LocaleManager.isZLocMode)
         {
            _loc1_ = ZLoc.getOriginalString(PACKAGE_NAME,NUMBER);
            _loc2_ = _loc1_.split("|");
            return _loc2_[1];
         }
         return ".";
      }
      
      public static function getComma() : String {
         var _loc1_:String = null;
         var _loc2_:Array = null;
         if(LocaleManager.isZLocMode)
         {
            _loc1_ = ZLoc.getOriginalString(PACKAGE_NAME,NUMBER);
            _loc2_ = _loc1_.split("|");
            return _loc2_[0];
         }
         return ",";
      }
      
      public function formatNumberToCurrency(param1:Number, param2:String, param3:String, param4:Boolean=true, param5:Number=2, param6:Boolean=true) : String {
         return numberToCurrency(param1,param4,param5,param6);
      }
   }
}
class Inner extends Object
{
   
   function Inner() {
      super();
   }
}
