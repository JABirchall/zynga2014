package com.zynga.poker
{
   public class PokerStatHit extends Object
   {
      
      public function PokerStatHit(param1:String, param2:Number, param3:Number, param4:Number, param5:Number, param6:String, param7:String="", param8:Number=1, param9:String="", param10:int=0, param11:String="agnostic", param12:int=100) {
         super();
         this.sTrackingKey = param1;
         this.nExpMonth = param2;
         this.nExpDay = param3;
         this.nExpYear = param4;
         this.nThrottle = param5;
         this.sTrackingStringOrComment = param6;
         this.sTrackingURL = param7;
         this.multi = param8;
         this.option = param9;
         this.type = param10;
         this.loc = param11;
         this.samplingInterval = param12 > 0?param12:100;
      }
      
      public static const TRACKHIT_RANDOMSAMPLED:Number = -2;
      
      public static const TRACKHIT_ALWAYS:Number = -1;
      
      public static const TRACKHIT_ONCE:Number = 1;
      
      public static const TRACKHIT_THROTTLED:Number = 100;
      
      public static const HITTYPE_NORMAL:int = 0;
      
      public static const HITTYPE_FG:int = 1;
      
      public static const HITTYPE_LOC:int = 2;
      
      public static const HITLOC_AGNOSTIC:String = "agnostic";
      
      public static const HITLOC_ZOOM:String = "zoom";
      
      public static const HITLOC_NAV3:String = "nav3";
      
      public static function fromString(param1:Object) : PokerStatHit {
         var _loc3_:String = null;
         var _loc2_:Array = new Array("sTrackingKey","nExpMonth","nExpDay","nExpYear","nThrottle","sTrackingStringOrComment","sTrackingURL","multi","option","type","loc","samplingInterval");
         for (_loc3_ in _loc2_)
         {
            if(!param1.hasOwnProperty(_loc2_[_loc3_]))
            {
               return null;
            }
         }
         return new PokerStatHit(param1.sTrackingKey,param1.nExpMonth,param1.nExpDay,param1.nExpYear,param1.nThrottle,param1.sTrackingStringOrComment,param1.sTrackingURL,param1.multi,param1.option,param1.type,param1.loc);
      }
      
      public var sTrackingKey:String;
      
      public var nExpMonth:Number;
      
      public var nExpDay:Number;
      
      public var nExpYear:Number;
      
      public var nThrottle:Number;
      
      public var sTrackingStringOrComment:String;
      
      public var sTrackingURL:String;
      
      public var multi:Number;
      
      public var option:String;
      
      public var type:int;
      
      public var loc:String;
      
      public var samplingInterval:int;
      
      public function clone() : PokerStatHit {
         return new PokerStatHit(this.sTrackingKey,this.nExpMonth,this.nExpDay,this.nExpYear,this.nThrottle,this.sTrackingStringOrComment,this.sTrackingURL,this.multi,this.option,this.type,this.loc,this.samplingInterval);
      }
      
      public function toString() : String {
         return String(this.sTrackingKey + ", " + this.nExpMonth.toString() + ", " + this.nExpDay.toString() + ", " + this.nExpYear.toString() + ", " + this.nThrottle.toString() + ", " + this.sTrackingStringOrComment + ", " + this.sTrackingURL + ", " + this.multi.toString() + ", " + this.option + ", " + this.type.toString() + ", " + this.loc + ", " + this.samplingInterval);
      }
   }
}
