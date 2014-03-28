package com.zynga.poker.error
{
   import flash.display.DisplayObject;
   import flash.display.LoaderInfo;
   import flash.display.Loader;
   import flash.events.ErrorEvent;
   import flash.utils.getQualifiedClassName;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   import flash.system.Capabilities;
   import com.zynga.io.ExternalCall;
   import com.zynga.io.IExternalCall;
   
   public class ErrorManager extends Object
   {
      
      public function ErrorManager() {
         super();
      }
      
      public static function addUncaughtErrorHandler(param1:DisplayObject) : void {
         var _loc4_:LoaderInfo = null;
         var _loc5_:Loader = null;
         var _loc2_:* = "uncaughtError";
         var _loc3_:* = "uncaughtErrorEvents";
         if(param1 is Loader)
         {
            _loc5_ = param1 as Loader;
            _loc4_ = _loc5_.contentLoaderInfo;
         }
         else
         {
            _loc4_ = param1.loaderInfo;
         }
         if(_loc4_.hasOwnProperty(_loc3_))
         {
            _loc4_[_loc3_].addEventListener(_loc2_,uncaughtErrorHandler,false,0,true);
         }
      }
      
      public static function uncaughtErrorHandler(param1:*) : void {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc8_:Error = null;
         var _loc4_:String = null;
         var _loc5_:* = "UNKNOWN";
         var _loc6_:* = "9999";
         if(param1.error is Error)
         {
            _loc8_ = param1.error as Error;
            _loc2_ = "Uncaught Flash Exception";
            _loc3_ = _loc8_.errorID + " / " + _loc6_ + " / " + _loc8_.toString();
            _loc4_ = _loc8_.getStackTrace();
            _loc5_ = String(_loc8_.errorID);
         }
         else
         {
            if(param1.error is ErrorEvent)
            {
               _loc2_ = "Flash Error Event";
               _loc3_ = param1.errorID + " / " + _loc6_ + " / " + (param1.error as ErrorEvent).toString();
               _loc5_ = String(param1.errorID);
            }
            else
            {
               _loc2_ = "Flash Object Thrown (" + getQualifiedClassName(param1.error) + ")";
               _loc3_ = param1.errorID + " / " + _loc6_ + " / " + param1.toString();
               _loc5_ = String(param1.errorID);
            }
         }
         var _loc7_:* = "o:uncaught_client_side:" + _loc6_ + ":%flashError%:2012-08-27";
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Errors Other Unknown o:total:uncaught_client_side:2012-09-24","",1,"",-PokerStatHit.HITTYPE_NORMAL,PokerStatHit.HITLOC_AGNOSTIC,1000));
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Errors Other Unknown " + _loc7_.replace("%flashError%",_loc5_),"",1,"",PokerStatHit.HITTYPE_NORMAL,PokerStatHit.HITLOC_AGNOSTIC,1000));
         if(Capabilities.isDebugger)
         {
            logError(false,"Uncaught Error: " + _loc2_,_loc3_,_loc4_);
         }
      }
      
      public static function logError(param1:Boolean, param2:String, param3:String, param4:String=null) : void {
         var _loc5_:IExternalCall = ExternalCall.getInstance();
         if(!_loc5_.available)
         {
            return;
         }
         if(param4 == null)
         {
            param4 = "Stack Trace Unavailable";
         }
         var _loc6_:String = _loc5_.call("function(){return navigator.appVersion+\'-\'+navigator.appName;}");
         var _loc7_:String = Capabilities.version + " :: " + _loc6_ + " :: Flash Release: " + 2014032501;
         var _loc8_:String = param2 + ": " + param3 + "\nStack Trace:\n" + param4;
         var _loc9_:String = escape(_loc8_);
         _loc5_.call("zc.error.log.reportFlashError",hackyStripString(param2),hackyStripString(_loc7_),_loc9_,param1);
      }
      
      private static function hackyStripString(param1:String) : String {
         var _loc2_:RegExp = new RegExp("[^0-9a-zA-Z_\\-\\/:.$,]","g");
         var _loc3_:String = param1.replace(_loc2_," ");
         return _loc3_;
      }
   }
}
