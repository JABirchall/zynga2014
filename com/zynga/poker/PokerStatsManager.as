package com.zynga.poker
{
   import com.zynga.io.LoadUrlVars;
   import com.zynga.events.URLEvent;
   import com.adobe.crypto.MD5;
   
   public class PokerStatsManager extends Object
   {
      
      public function PokerStatsManager(param1:PokerStatsManagerLock) {
         super();
         if((cInstance) || param1 == null)
         {
            throw new Error("PokerStatsManager class cannot be instantiated");
         }
         else
         {
            cInstance = this;
            _loc2_ = (Number(zid.substr(2,zid.length)) + 79) % PokerStatHit.TRACKHIT_THROTTLED;
            this.makeThrottledHits = _loc2_ == 0?true:false;
            return;
         }
      }
      
      public static const TRACKING_PATTERN:RegExp = new RegExp("^(fbe|[fieponuacs]):[^ ]+:20[01][0-9]-(0[1-9]|1[012])-([012][0-9]|3[01])$");
      
      private static const TRACE_PREFIX:String = "POKERSTATSMANAGER: ";
      
      public static var aStatsHash:Array = new Array();
      
      public static var aDefaultTrack:Array = new Array("Flash","Unknown","Other");
      
      private static var cInstance:PokerStatsManager;
      
      private static var zoomControl:Object;
      
      private static var zoomThrottle:Number;
      
      public static var zid:String;
      
      private static var hitRequest:LoadUrlVars;
      
      public static var nav3ErrorCheck:String;
      
      public static var doNav3Stats:Boolean = false;
      
      public static var statHitFileURL:String = "";
      
      public static function getInstance() : PokerStatsManager {
         var _loc1_:PokerStatsManager = null;
         if(!cInstance)
         {
            _loc1_ = new PokerStatsManager(new PokerStatsManagerLock());
         }
         return cInstance;
      }
      
      public static function DoHitForStat(param1:PokerStatHit) : void {
         var _loc4_:uint = 0;
         var _loc8_:Date = null;
         var _loc9_:Date = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc2_:PokerStatsManager = PokerStatsManager.getInstance();
         var _loc3_:Array = _loc2_.fg.split(",");
         var _loc5_:* = "";
         if(param1.nExpYear > 0 && param1.nExpMonth > 0 && param1.nExpDay > 0)
         {
            _loc8_ = new Date();
            _loc9_ = new Date(param1.nExpYear,param1.nExpMonth-1,param1.nExpDay);
            if(_loc8_.time >= _loc9_.time)
            {
               return;
            }
         }
         else
         {
            if(param1.nExpYear > 0 || param1.nExpMonth > 0 || param1.nExpDay > 0)
            {
               _loc5_ = TRACE_PREFIX + "Invalid Expiration Date! " + param1.sTrackingStringOrComment + "\n" + "ISSUE: Your tracking call has an invalid expiration date.\n" + "Please re-check your tracking call and re-build.\n" + "When using expiration dates day, month and year are all required.\n" + "This tracking hit will not be sent.";
               if(_loc2_.debugMode)
               {
                  throw new Error(_loc5_);
               }
               else
               {
                  return;
               }
            }
         }
         if((isNaN(param1.type)) || param1.type > PokerStatHit.HITTYPE_LOC || param1.type < PokerStatHit.HITTYPE_NORMAL)
         {
            if(_loc2_.debugMode)
            {
               throw new Error(TRACE_PREFIX + "Invalid Tracking Type! " + param1.sTrackingStringOrComment + "\n" + "ISSUE: Your tracking call has an invalid type argument.\n" + "Please re-check your tracking call and re-build.\n" + "Your tracking type should be [EMPTY] | PokerStatHit.HITTYPE_FG | PokerStatHit.HITTYPE_LOC\n" + "This tracking hit will not be sent.");
            }
            else
            {
               return;
            }
         }
         else
         {
            if(!(param1.nThrottle == PokerStatHit.TRACKHIT_ALWAYS) && !(param1.nThrottle == PokerStatHit.TRACKHIT_THROTTLED) && !(param1.nThrottle == PokerStatHit.TRACKHIT_ONCE) && !(param1.nThrottle == PokerStatHit.TRACKHIT_RANDOMSAMPLED))
            {
               if(_loc2_.debugMode)
               {
                  throw new Error(TRACE_PREFIX + "Invalid Tracking Throttle! " + param1.sTrackingStringOrComment + "\n" + "ISSUE: Your tracking call has an invalid throttle argument.\n" + "Please re-check your tracking call and re-build.\n" + "Your tracking throttle should be PokerStatHit.TRACKHIT_ALWAYS | PokerStatHit.TRACKHIT_ONCE | PokerStatHit.TRACKHIT_THROTTLED | PokerStatHit.TRACKHIT_RANDOMSAMPLED\n" + "This tracking hit will not be sent.");
               }
               else
               {
                  return;
               }
            }
            else
            {
               if(param1.sTrackingKey == "" && !(param1.nThrottle == PokerStatHit.TRACKHIT_THROTTLED) && !(param1.nThrottle == PokerStatHit.TRACKHIT_RANDOMSAMPLED))
               {
                  if(param1.nThrottle == PokerStatHit.TRACKHIT_ONCE)
                  {
                     _loc5_ = TRACE_PREFIX + "Invalid Tracking Key! " + param1.sTrackingStringOrComment + "\n" + "ISSUE: Your tracking call has an invalid tracking key argument.\n" + "Please re-check your tracking call and re-build.\n" + "When using PokerStatHit.TRACKHIT_ONCE tracking key is required.\n" + "This tracking hit will not be sent.";
                     if(_loc2_.debugMode)
                     {
                        throw new Error(_loc5_);
                     }
                     else
                     {
                        return;
                     }
                  }
                  else
                  {
                     _loc10_ = param1.multi > 1?"&inc=" + String(param1.multi):"";
                     if(_loc3_.length > 0)
                     {
                        _loc4_ = 0;
                        while(_loc4_ < _loc3_.length)
                        {
                           param1.sTrackingURL = _loc2_.GetSignedTrackingURL(param1,_loc4_);
                           if(param1.sTrackingURL != "")
                           {
                              _loc2_.commitStatHit(param1.sTrackingURL + _loc10_,null,"POST",param1.loc);
                           }
                           _loc4_++;
                        }
                     }
                     else
                     {
                        param1.sTrackingURL = _loc2_.GetSignedTrackingURL(param1,0);
                        if(param1.sTrackingURL != "")
                        {
                           _loc2_.commitStatHit(param1.sTrackingURL + _loc10_,null,"POST",param1.loc);
                        }
                     }
                     return;
                  }
               }
               else
               {
                  _loc6_ = false;
                  if(param1.nThrottle == PokerStatHit.TRACKHIT_ONCE)
                  {
                     if(aStatsHash[param1.sTrackingKey] == undefined)
                     {
                        _loc6_ = true;
                        aStatsHash[param1.sTrackingKey] = 1;
                     }
                  }
                  else
                  {
                     if(param1.nThrottle == PokerStatHit.TRACKHIT_ALWAYS)
                     {
                        _loc6_ = true;
                     }
                     else
                     {
                        if(param1.nThrottle == PokerStatHit.TRACKHIT_THROTTLED)
                        {
                           if(_loc2_.makeThrottledHits)
                           {
                              _loc6_ = true;
                           }
                           else
                           {
                              return;
                           }
                        }
                        else
                        {
                           if(param1.nThrottle == PokerStatHit.TRACKHIT_RANDOMSAMPLED)
                           {
                              if((_loc2_.debugMode) || Math.floor(Math.random() * param1.samplingInterval) == 0)
                              {
                                 _loc6_ = true;
                              }
                              else
                              {
                                 return;
                              }
                           }
                        }
                     }
                  }
                  _loc7_ = (param1.nThrottle > 0?param1.nThrottle:1) * param1.multi;
                  if(!_loc2_.debugMode && param1.nThrottle == PokerStatHit.TRACKHIT_RANDOMSAMPLED)
                  {
                     if(param1.samplingInterval > 0)
                     {
                        _loc7_ = _loc7_ * param1.samplingInterval;
                     }
                  }
                  if(param1.sTrackingURL)
                  {
                     if(_loc6_)
                     {
                        _loc2_.commitStatHit(param1.sTrackingURL + "&inc=" + String(_loc7_),{},"POST",param1.loc);
                     }
                  }
                  else
                  {
                     if(_loc3_.length > 0)
                     {
                        _loc4_ = 0;
                        while(_loc4_ < _loc3_.length)
                        {
                           _loc11_ = _loc2_.GetSignedTrackingURL(param1,_loc4_);
                           if(_loc11_)
                           {
                              if(_loc6_)
                              {
                                 _loc2_.commitStatHit(_loc11_ + "&inc=" + String(_loc7_),{},"POST",param1.loc);
                              }
                           }
                           _loc4_++;
                        }
                     }
                     else
                     {
                        _loc11_ = _loc2_.GetSignedTrackingURL(param1,0);
                        if(_loc11_)
                        {
                           if(_loc6_)
                           {
                              _loc2_.commitStatHit(_loc11_ + "&inc=" + String(_loc7_),{},"POST",param1.loc);
                           }
                        }
                     }
                  }
                  return;
               }
            }
         }
      }
      
      public var debugMode:Boolean;
      
      public var makeThrottledHits:Boolean = false;
      
      public var fg:String;
      
      public var userLocale:String;
      
      public var trace_stats:int;
      
      public var sn_id:int;
      
      public var SN_DEFAULT:int = 0;
      
      public var SN_FACEBOOK:int = 1;
      
      public var SN_ORKUT:int = 2;
      
      public var SN_MEEBO:int = 3;
      
      public var SN_HI5:int = 4;
      
      public var SN_FRIENDSTER:int = 5;
      
      public var SN_BEBO:int = 6;
      
      public var SN_MYSPACE:int = 7;
      
      public var SN_ZYNGA:int = 8;
      
      public var SN_YAHOO:int = 9;
      
      public var SN_TAGGED:int = 10;
      
      public var SN_ZYNGALIVE:int = 18;
      
      public var SN_SNAPI:int = 18;
      
      public function initZoomStats(param1:Object, param2:Number, param3:String) : void {
         zoomControl = param1;
         zoomThrottle = param2;
         zid = param3;
      }
      
      public function commitStatHit(param1:String, param2:Object=null, param3:String="POST", param4:String="agnostic") : void {
         var inStatURL:String = param1;
         var inParams:Object = param2;
         var inMethod:String = param3;
         var inLoc:String = param4;
         var hitType:String = "Zoom";
         var success:Boolean = false;
         inStatURL = SSLMigration.getSecureURL(inStatURL);
         if(inLoc != PokerStatHit.HITLOC_NAV3)
         {
            if(statHitFileURL == "")
            {
               try
               {
                  success = this.commitZoomStatHit(inStatURL,doNav3Stats);
               }
               catch(error:Error)
               {
               }
            }
         }
         if(!success && inLoc == PokerStatHit.HITLOC_AGNOSTIC || (doNav3Stats) || inLoc == PokerStatHit.HITLOC_NAV3)
         {
            hitRequest = new LoadUrlVars();
            hitRequest.addEventListener(URLEvent.onIOError,this.onIOErrorStatHit);
            hitRequest.loadURL(inStatURL,inParams,inMethod);
            hitType = "Nav3";
            success = true;
         }
      }
      
      private function onIOErrorStatHit(param1:URLEvent) : void {
         var _loc2_:String = null;
         if(!param1.bSuccess && (nav3ErrorCheck))
         {
            if(unescape(param1.data).search(nav3ErrorCheck) != -1)
            {
               _loc2_ = nav3ErrorCheck.split(" ").pop();
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Nav3Error:" + _loc2_,null,1,""));
            }
         }
      }
      
      public function commitZoomStatHit(param1:String, param2:Boolean=false) : Boolean {
         var _loc4_:RegExp = null;
         var _loc5_:Object = null;
         var _loc6_:String = null;
         var _loc7_:* = NaN;
         var _loc8_:RegExp = null;
         var _loc9_:Object = null;
         var _loc10_:* = false;
         var _loc11_:* = NaN;
         var _loc12_:RegExp = null;
         var _loc3_:* = false;
         if(!(zoomControl == null) && (zoomControl.isConnected()))
         {
            _loc4_ = new RegExp("item=(.*?)&","g");
            _loc5_ = _loc4_.exec(param1);
            if((_loc5_) && _loc5_.length > 0)
            {
               _loc6_ = unescape(String(_loc5_[1]));
               _loc7_ = 1;
               _loc8_ = new RegExp("inc=([0-9]+)","g");
               _loc9_ = _loc8_.exec(param1);
               if((_loc9_) && _loc9_.length > 0)
               {
                  _loc7_ = Number(_loc9_[1]);
               }
               if(param2)
               {
                  _loc12_ = new RegExp("Poker","g");
                  _loc6_ = _loc6_.replace(_loc12_,"PokerZoom");
               }
               _loc10_ = false;
               _loc11_ = Math.ceil(Math.random() * 99) + 1;
               if(_loc11_ <= zoomThrottle)
               {
                  _loc10_ = true;
               }
               if(_loc10_)
               {
                  if(zoomControl.sendStatRequest(zid,_loc6_,_loc7_))
                  {
                     _loc3_ = true;
                  }
               }
            }
         }
         return _loc3_;
      }
      
      public function GetSignedTrackingURL(param1:PokerStatHit, param2:int=0) : String {
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc12_:Array = null;
         var _loc13_:* = 0;
         var _loc14_:String = null;
         var _loc3_:String = param1.sTrackingStringOrComment;
         var _loc4_:int = param1.type;
         var _loc5_:String = param1.option;
         var _loc6_:Array = _loc3_.split(" ");
         if((isNaN(_loc4_)) || _loc4_ > PokerStatHit.HITTYPE_LOC || _loc4_ < PokerStatHit.HITTYPE_NORMAL)
         {
            if(this.debugMode)
            {
               throw new Error(TRACE_PREFIX + "Invalid Tracking Type! " + _loc3_ + "\n" + "ISSUE: Your tracking call has an invalid type argument.\n" + "Please re-check your tracking call and re-build.\n" + "Your tracking type should be [EMPTY] | PokerStatHit.HITTYPE_FG | PokerStatHit.HITTYPE_LOC\n" + "This tracking hit will not be sent.");
            }
            else
            {
               return "";
            }
         }
         else
         {
            if(_loc6_.length > 4)
            {
               if(this.debugMode)
               {
                  throw new Error(TRACE_PREFIX + "Invalid Tracking String! " + _loc3_ + "\n" + "ISSUE: Your tracking string has too many parts.\n" + "Please re-check your tracking string format and re-build.\n" + "Your tracking string should only contain [feature][channel][action][creative]\n" + "https://zyntranet.corp.zynga.com/display/TEXAS/Stats+Naming+convention\n" + "This tracking hit will not be sent.");
               }
               else
               {
                  return "";
               }
            }
            else
            {
               if(_loc6_.length < 1)
               {
                  if(this.debugMode)
                  {
                     throw new Error(TRACE_PREFIX + "Invalid Tracking String! " + _loc3_ + "\n" + "ISSUE: Your tracking string is empty.\n" + "Please re-check your tracking string format and re-build.\n" + "Your tracking string should contain [feature][channel][action][creative]\n" + "https://zyntranet.corp.zynga.com/display/TEXAS/Stats+Naming+convention\n" + "This tracking hit will not be sent.");
                  }
                  else
                  {
                     return "";
                  }
               }
               else
               {
                  if(!_loc6_[_loc6_.length-1].match(PokerStatsManager.TRACKING_PATTERN))
                  {
                     if(this.debugMode)
                     {
                        throw new Error(TRACE_PREFIX + "Invalid Tracking String! " + _loc3_ + "\n" + "ISSUE: Your creative is malformed.\n" + "Please re-check your tracking string format and re-build.\n" + "Your creative should be formatted [o:TrackingCreative:YYYY-MM-DD]\n" + "https://zyntranet.corp.zynga.com/display/TEXAS/Stats+Naming+convention\n" + "This tracking hit will not be sent.");
                     }
                     else
                     {
                        return "";
                     }
                  }
                  else
                  {
                     if(_loc4_ == PokerStatHit.HITTYPE_FG || _loc4_ == PokerStatHit.HITTYPE_LOC)
                     {
                        if(_loc4_ == PokerStatHit.HITTYPE_FG)
                        {
                           if(this.fg == null || this.fg == "" || this.fg == "undefined")
                           {
                              return "";
                           }
                        }
                        else
                        {
                           if(this.userLocale == null || this.userLocale == "" || this.userLocale == "undefined")
                           {
                              return "";
                           }
                        }
                        _loc12_ = this.fg.split(",");
                        _loc7_ = _loc4_ == PokerStatHit.HITTYPE_FG?"Poker_FG":"Poker_LOC";
                        _loc8_ = _loc4_ == PokerStatHit.HITTYPE_FG?" fg:" + _loc12_[param2]:" loc:" + this.userLocale;
                        _loc5_ = _loc5_ == ""?"":" " + _loc5_;
                        _loc3_ = _loc7_ + " " + this.getSN() + " " + _loc6_.join(" ") + _loc5_ + _loc8_;
                     }
                     else
                     {
                        _loc7_ = "Poker";
                        _loc5_ = _loc5_ == ""?"":": " + _loc5_;
                        _loc3_ = _loc7_ + " " + this.getSN() + " " + _loc6_.join(" ") + _loc5_;
                     }
                     _loc9_ = "SxC1ZN";
                     _loc10_ = MD5.hash(_loc3_ + _loc9_);
                     _loc11_ = SSLMigration.getAppProtocol() + "nav3.poker.zynga.com/link/link.php?item=" + escape(_loc3_) + "&ltsig=" + escape(_loc10_);
                     if(statHitFileURL != "")
                     {
                        _loc13_ = Math.abs(param1.nThrottle) == 1?-param1.nThrottle:param1.nThrottle;
                        _loc11_ = statHitFileURL + "?item=" + escape(_loc3_) + "&ltsig=" + escape(_loc10_) + "&stat_source=flash" + "&stat_sample=" + _loc13_;
                        _loc11_ = _loc11_ + "&no_cache=" + Math.random();
                        _loc14_ = new Error().getStackTrace();
                        if((_loc14_) && _loc14_.length > 0)
                        {
                           _loc11_ = _loc11_ + escape(":" + _loc14_.replace(new RegExp(".*PokerStatsManager.*?\\tat (.*?)\\n.*","s"),"$1"));
                        }
                     }
                     if(_loc4_ != PokerStatHit.HITTYPE_FG)
                     {
                        _loc11_ = _loc11_ + ("&zid=" + zid);
                     }
                     return _loc11_;
                  }
               }
            }
         }
      }
      
      public function getSN() : String {
         switch(this.sn_id)
         {
            case this.SN_BEBO:
               return "BE";
            case this.SN_FACEBOOK:
               return "FB";
            case this.SN_FRIENDSTER:
               return "FR";
            case this.SN_HI5:
               return "H5";
            case this.SN_MEEBO:
               return "ME";
            case this.SN_MYSPACE:
               return "MS";
            case this.SN_ORKUT:
               return "OT";
            case this.SN_TAGGED:
               return "TG";
            case this.SN_YAHOO:
               return "YA";
            case this.SN_ZYNGA:
               return "ZY";
            case this.SN_SNAPI:
               return "SN";
            default:
               return "";
         }
         
      }
   }
}
class PokerStatsManagerLock extends Object
{
   
   function PokerStatsManagerLock() {
      super();
   }
}
