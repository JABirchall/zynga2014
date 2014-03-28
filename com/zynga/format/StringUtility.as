package com.zynga.format
{
   import com.zynga.locale.LocaleManager;
   import ZLocalization.LocaleFormatter;
   
   public class StringUtility extends Object
   {
      
      public function StringUtility() {
         super();
      }
      
      public static function GetOrdinal(param1:Number) : String {
         var _loc2_:String = String(param1);
         switch(param1)
         {
            case 1:
               _loc2_ = LocaleManager.localize("flash.global.ordinal.1");
               break;
            case 2:
               _loc2_ = LocaleManager.localize("flash.global.ordinal.2");
               break;
            case 3:
               _loc2_ = LocaleManager.localize("flash.global.ordinal.3");
               break;
            case 4:
               _loc2_ = LocaleManager.localize("flash.global.ordinal.4");
               break;
            case 5:
               _loc2_ = LocaleManager.localize("flash.global.ordinal.5");
               break;
            case 6:
               _loc2_ = LocaleManager.localize("flash.global.ordinal.6");
               break;
            case 7:
               _loc2_ = LocaleManager.localize("flash.global.ordinal.7");
               break;
            case 8:
               _loc2_ = LocaleManager.localize("flash.global.ordinal.8");
               break;
            case 9:
               _loc2_ = LocaleManager.localize("flash.global.ordinal.9");
               break;
         }
         
         return _loc2_;
      }
      
      public static function LimitString(param1:Number, param2:String, param3:String) : String {
         var _loc4_:String = null;
         if(param2.length > param1)
         {
            _loc4_ = param2.substring(0,param1);
            return _loc4_ + param3;
         }
         return param2;
      }
      
      public static function TrunkateByWord(param1:Number=10, param2:String=null, param3:String="...") : String {
         var _loc4_:Array = param2.split(" ");
         if(_loc4_.length <= 1)
         {
            return LimitString(param1,param2,param3);
         }
         var _loc5_:Number = -1;
         var _loc6_:Number = -1;
         _loc5_ = param2.indexOf(" ",_loc5_ + 1);
         while(_loc5_ >= 0)
         {
            if(_loc5_ <= param1)
            {
               _loc6_ = _loc5_;
               _loc5_ = param2.indexOf(" ",_loc5_ + 1);
               continue;
            }
            break;
         }
         if(_loc6_ < 0)
         {
            return LimitString(param1,param2,param3);
         }
         var _loc7_:* = "";
         var _loc8_:* = "";
         var _loc9_:* = 0;
         while(_loc9_ < _loc4_.length)
         {
            _loc7_ = _loc7_ + _loc4_[_loc9_];
            if(_loc7_.length > param1)
            {
               if(_loc8_ != "")
               {
                  return _loc8_;
               }
               return LimitString(param1,param2,param3);
            }
            _loc7_ = _loc7_ + " ";
            _loc8_ = _loc7_;
            _loc9_++;
         }
         return LimitString(param1,param2,param3);
      }
      
      public static function StringToMoney(param1:Number, param2:Boolean=false, param3:int=4, param4:Boolean=true, param5:Number=1, param6:Boolean=false) : String {
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:* = NaN;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:String = null;
         var _loc17_:String = null;
         var _loc18_:String = null;
         var _loc19_:String = null;
         var _loc20_:String = null;
         if(isNaN(param1))
         {
            return "0";
         }
         var param1:Number = Math.round(param1 * 100) / 100;
         var _loc7_:String = LocaleManager.isZLocMode?LocaleFormatter.formatNumber(param1):formatNumber(param1);
         if(param2 == true)
         {
            if(_loc7_.length < param3 + 1)
            {
               return _loc7_;
            }
            _loc8_ = param4?" ":"";
            if(_loc7_.length > param3)
            {
               _loc10_ = param1;
               if(_loc10_ >= 1000 && _loc10_ < 1000000)
               {
                  _loc11_ = _loc10_.toString();
                  _loc12_ = _loc11_.substr(0,_loc11_.length - 2);
                  _loc13_ = _loc12_.substr(0,_loc12_.length-1);
                  _loc14_ = _loc12_.substr(_loc12_.length-1,_loc12_.length);
                  if(_loc14_ == "0")
                  {
                     _loc9_ = _loc13_;
                  }
                  else
                  {
                     _loc9_ = _loc13_ + "." + _loc14_;
                  }
                  _loc9_ = _loc9_ + _loc8_;
                  switch(param5)
                  {
                     case 0:
                        break;
                     case 1:
                        _loc9_ = _loc9_ + "K";
                        break;
                     case 3:
                        _loc9_ = _loc9_ + "K";
                        break;
                     default:
                        _loc9_ = _loc9_ + "K";
                  }
                  
               }
               else
               {
                  if(_loc10_ >= 1000000 && _loc10_ < 1000000000)
                  {
                     _loc15_ = _loc10_.toString();
                     _loc16_ = _loc15_.substr(0,_loc15_.length - 5);
                     _loc9_ = _loc16_.substr(0,_loc16_.length-1);
                     if(!param6)
                     {
                        _loc9_ = _loc9_ + ("." + _loc16_.substr(_loc16_.length-1,_loc16_.length));
                     }
                     _loc9_ = _loc9_ + _loc8_;
                     switch(param5)
                     {
                        case 0:
                           break;
                        case 1:
                           _loc9_ = _loc9_ + "M";
                           break;
                        case 3:
                           _loc9_ = _loc9_ + "Mil";
                           break;
                        default:
                           _loc9_ = _loc9_ + "Million";
                     }
                     
                  }
                  else
                  {
                     if(_loc10_ >= 1000000000 && _loc10_ < 1.0E12)
                     {
                        _loc17_ = _loc10_.toString();
                        _loc18_ = _loc17_.substr(0,_loc17_.length - 8);
                        _loc9_ = _loc18_.substr(0,_loc18_.length-1);
                        if(!param6)
                        {
                           _loc9_ = _loc9_ + ("." + _loc18_.substr(_loc18_.length-1,_loc18_.length));
                        }
                        _loc9_ = _loc9_ + _loc8_;
                        switch(param5)
                        {
                           case 0:
                              break;
                           case 1:
                              _loc9_ = _loc9_ + "B";
                              break;
                           case 3:
                              _loc9_ = _loc9_ + "Bil";
                              break;
                           default:
                              _loc9_ = _loc9_ + "Billion";
                        }
                        
                     }
                     else
                     {
                        if(_loc10_ >= 1.0E12 && _loc10_ < 1.0E15)
                        {
                           _loc19_ = _loc10_.toString();
                           _loc20_ = _loc19_.substr(0,_loc19_.length - 11);
                           _loc9_ = _loc20_.substr(0,_loc20_.length-1);
                           if(!param6)
                           {
                              _loc9_ = _loc9_ + ("." + _loc20_.substr(_loc20_.length-1,_loc20_.length));
                           }
                           _loc9_ = _loc9_ + _loc8_;
                           switch(param5)
                           {
                              case 0:
                                 break;
                              case 1:
                                 _loc9_ = _loc9_ + "T";
                                 break;
                              case 3:
                                 _loc9_ = _loc9_ + "Tril";
                                 break;
                              default:
                                 _loc9_ = _loc9_ + "Trillion";
                           }
                           
                        }
                     }
                  }
               }
               _loc7_ = _loc9_;
            }
         }
         return _loc7_;
      }
      
      public static function formatNumber(param1:Number) : String {
         return param1.toString().replace(new RegExp("(?<=\\d)(?=(\\d{3})+$)","g"),",");
      }
      
      public static function FormatString(param1:String, ... rest) : String {
         var _loc6_:Array = null;
         var _loc3_:String = String(param1);
         var _loc4_:Array = new Array();
         var _loc5_:* = 0;
         _loc5_ = 0;
         while(_loc5_ < rest.length)
         {
            _loc4_.push(rest[_loc5_]);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            if(param1.indexOf(_loc4_[_loc5_].sText) != -1)
            {
               _loc6_ = _loc3_.split(_loc4_[_loc5_].sText);
               _loc3_ = _loc6_.join(_loc4_[_loc5_].nVar);
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function addFontTag(param1:String, param2:String, param3:Number=0) : String {
         var _loc4_:String = null;
         _loc4_ = "<font face=\"" + param2 + "\" color=\"#" + param3.toString(16) + "\">" + param1 + "</font>";
         return _loc4_;
      }
      
      public static function getCardSuit(param1:String) : Number {
         if(param1 == "d")
         {
            return 0;
         }
         if(param1 == "h")
         {
            return 1;
         }
         if(param1 == "c")
         {
            return 2;
         }
         if(param1 == "s")
         {
            return 3;
         }
         return -1;
      }
      
      public static function getCardVal(param1:String) : String {
         if(param1.substr(0,1) == "0" && !(param1.substr(1,1) == "1"))
         {
            return param1.substr(1,2);
         }
         if(param1 == "10")
         {
            return "10";
         }
         if(param1 == "11")
         {
            return "J";
         }
         if(param1 == "12")
         {
            return "Q";
         }
         if(param1 == "13")
         {
            return "K";
         }
         if(param1 == "01")
         {
            return "A";
         }
         if(param1 == "14")
         {
            return "A";
         }
         return "";
      }
      
      public static function getCardVal2(param1:String) : Number {
         if(param1 == "A")
         {
            return 14;
         }
         if(param1 == "T")
         {
            return 10;
         }
         if(param1 == "J")
         {
            return 11;
         }
         if(param1 == "Q")
         {
            return 12;
         }
         if(param1 == "K")
         {
            return 13;
         }
         return Number(param1);
      }
      
      public static function getFormattedTimePeriod(param1:Number) : String {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:String = null;
         if(param1 > 0)
         {
            _loc2_ = Math.floor(param1 / (60 * 60 * 24));
            param1 = param1 % (60 * 60 * 24);
            _loc3_ = Math.floor(param1 / (60 * 60));
            param1 = param1 % (60 * 60);
            _loc4_ = Math.floor(param1 / 60);
            param1 = param1 % 60;
            _loc5_ = "";
            if(_loc2_ == 1)
            {
               _loc5_ = _loc5_ + LocaleManager.localize("flash.global.time.day");
               return _loc5_;
            }
            if(_loc2_ > 1)
            {
               _loc5_ = _loc5_ + (_loc2_ + " " + LocaleManager.localize("flash.global.time.days"));
               return _loc5_;
            }
            if(_loc3_ == 1)
            {
               _loc5_ = _loc5_ + LocaleManager.localize("flash.global.time.hour");
               return _loc5_;
            }
            if(_loc3_ > 1)
            {
               _loc5_ = _loc5_ + (_loc3_ + " " + LocaleManager.localize("flash.global.time.hours"));
               return _loc5_;
            }
            if(_loc4_ == 1)
            {
               _loc5_ = _loc5_ + LocaleManager.localize("flash.global.time.minute");
               return _loc5_;
            }
            if(_loc4_ > 1)
            {
               _loc5_ = _loc5_ + (_loc4_ + " " + LocaleManager.localize("flash.global.time.minutes"));
               return _loc5_;
            }
         }
         return "";
      }
      
      public static function getFormattedTimeString(param1:Number) : String {
         var _loc3_:* = NaN;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc2_:Object = new Object();
         if(param1 > 0)
         {
            _loc3_ = param1 / 60 / 60 / 24;
            _loc2_.tDays = Math.floor(_loc3_);
            if(_loc2_.tDays >= 1)
            {
               if(_loc3_ - _loc2_.tDays >= 0.5)
               {
                  _loc2_.tDays = _loc2_.tDays + 1;
               }
               else
               {
                  _loc2_.tDays = _loc2_.tDays + 0.5;
               }
               _loc2_.tWeeks = Math.floor(_loc2_.tDays / 7);
               _loc2_.tMonths = Math.floor(_loc2_.tWeeks / 4);
            }
            _loc4_ = LocaleManager.localize("flash.global.time.shorthand.months");
            _loc5_ = LocaleManager.localize("flash.global.time.shorthand.month");
            _loc6_ = LocaleManager.localize("flash.global.time.shorthand.weeks");
            _loc7_ = LocaleManager.localize("flash.global.time.shorthand.week");
            _loc8_ = LocaleManager.localize("flash.global.time.days");
            _loc9_ = LocaleManager.localize("flash.global.time.day");
            _loc10_ = LocaleManager.localize("flash.global.time.today");
            if(_loc2_.tMonths > 1)
            {
               return "";
            }
            if(_loc2_.tMonths == 1)
            {
               return LocaleManager.localize("flash.global.time.ago",
                  {
                     "number":_loc2_.tMonths.toString(),
                     "unit":_loc4_
                  });
            }
            if(_loc2_.tMonths == 1)
            {
               return LocaleManager.localize("flash.global.time.ago",
                  {
                     "number":_loc2_.tMonths.toString(),
                     "unit":_loc5_
                  });
            }
            if(_loc2_.tWeeks > 1)
            {
               return LocaleManager.localize("flash.global.time.ago",
                  {
                     "number":_loc2_.tWeeks.toString(),
                     "unit":_loc6_
                  });
            }
            if(_loc2_.tWeeks == 1)
            {
               return LocaleManager.localize("flash.global.time.ago",
                  {
                     "number":_loc2_.tWeeks.toString(),
                     "unit":_loc7_
                  });
            }
            if(_loc2_.tDays > 1)
            {
               return LocaleManager.localize("flash.global.time.ago",
                  {
                     "number":_loc2_.tDays.toString(),
                     "unit":_loc8_
                  });
            }
            if(_loc2_.tDays == 1)
            {
               return LocaleManager.localize("flash.global.time.ago",
                  {
                     "number":_loc2_.tDays.toString(),
                     "unit":_loc9_
                  });
            }
            if(_loc2_.tDays < 1)
            {
               return _loc10_;
            }
         }
         return LocaleManager.localize("flash.global.time.today");
      }
      
      public static function colorChatText(param1:String, param2:int, param3:Boolean=true, param4:Boolean=false) : String {
         var _loc6_:String = null;
         var _loc7_:uint = 0;
         var _loc5_:String = param1;
         if(param4)
         {
            _loc6_ = String.fromCharCode(9824);
            return "<font color=\"#000000\"><b>" + _loc6_ + _loc5_ + " [Zynga Moderator] </b></font>";
         }
         if(_loc5_ != null)
         {
            _loc7_ = getSeatColor(param2);
            if(param3)
            {
               _loc5_ = "<b>" + _loc5_ + "</b>";
            }
            _loc5_ = "<font color=\"#" + _loc7_.toString(16).toUpperCase() + "\">" + _loc5_ + "</font>";
         }
         return _loc5_;
      }
      
      public static function wrapChatZidLink(param1:String, param2:String) : String {
         return "<a href=\'event:" + param1 + "\'>" + htmlEncode(param2) + "</a>";
      }
      
      private static function htmlEncode(param1:String) : String {
         var param1:String = param1.replace(new RegExp("&","g"),"&amp;");
         param1 = param1.replace(new RegExp("<","g"),"&lt;");
         param1 = param1.replace(new RegExp(">","g"),"&gt;");
         return param1;
      }
      
      private static function getSeatColor(param1:int) : uint {
         var _loc2_:uint = 0;
         switch(param1)
         {
            case 0:
               _loc2_ = 8388608;
               break;
            case 1:
               _loc2_ = 25600;
               break;
            case 2:
               _loc2_ = 128;
               break;
            case 3:
               _loc2_ = 9055202;
               break;
            case 4:
               _loc2_ = 255;
               break;
            case 5:
               _loc2_ = 3329330;
               break;
            case 6:
               _loc2_ = 13789470;
               break;
            case 7:
               _loc2_ = 13047896;
               break;
            case 8:
               _loc2_ = 6525114;
               break;
            case 9:
               _loc2_ = 7303023;
               break;
            case -1:
            default:
               _loc2_ = 3355443;
         }
         
         return _loc2_;
      }
      
      public static function getFormattedTimeStringGranular(param1:Number) : String {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:String = null;
         var _loc9_:* = NaN;
         if(param1 > 0)
         {
            _loc2_ = param1 / 60;
            _loc3_ = _loc2_ / 60;
            _loc4_ = _loc3_ / 24;
            _loc5_ = _loc4_ / 7;
            _loc6_ = _loc5_ / 4;
            _loc7_ = _loc6_ / 12;
            _loc8_ = "";
            _loc9_ = 0;
            if(_loc7_ >= 1)
            {
               _loc9_ = Math.round(_loc7_);
               _loc8_ = _loc9_ > 1?LocaleManager.localize("flash.global.time.years"):LocaleManager.localize("flash.global.time.year");
            }
            else
            {
               if(_loc6_ >= 1)
               {
                  _loc9_ = Math.round(_loc6_);
                  _loc8_ = _loc9_ > 1?LocaleManager.localize("flash.global.time.months"):LocaleManager.localize("flash.global.time.month");
               }
               else
               {
                  if(_loc5_ >= 1)
                  {
                     _loc9_ = Math.round(_loc5_);
                     _loc8_ = _loc9_ > 1?LocaleManager.localize("flash.global.time.weeks"):LocaleManager.localize("flash.global.time.week");
                  }
                  else
                  {
                     if(_loc4_ >= 1)
                     {
                        _loc9_ = Math.round(_loc4_);
                        _loc8_ = _loc9_ > 1?LocaleManager.localize("flash.global.time.days"):LocaleManager.localize("flash.global.time.day");
                     }
                     else
                     {
                        if(_loc3_ >= 1)
                        {
                           _loc9_ = Math.round(_loc3_);
                           _loc8_ = _loc9_ > 1?LocaleManager.localize("flash.global.time.hours"):LocaleManager.localize("flash.global.time.hour");
                        }
                        else
                        {
                           if(_loc2_ >= 1)
                           {
                              _loc9_ = Math.round(_loc2_);
                              _loc8_ = _loc9_ > 1?LocaleManager.localize("flash.global.time.minutes"):LocaleManager.localize("flash.global.time.minute");
                           }
                           else
                           {
                              _loc9_ = param1;
                              if(_loc9_ > 0)
                              {
                                 _loc8_ = _loc9_ > 1?LocaleManager.localize("flash.global.time.seconds"):LocaleManager.localize("flash.global.time.second");
                              }
                              else
                              {
                                 _loc8_ = LocaleManager.localize("flash.global.time.justNow");
                              }
                           }
                        }
                     }
                  }
               }
            }
            return LocaleManager.localize("flash.global.time.unitsAgo",
               {
                  "number":_loc9_,
                  "unit":_loc8_
               });
         }
         return LocaleManager.localize("flash.global.time.Unknown");
      }
   }
}
