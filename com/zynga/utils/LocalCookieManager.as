package com.zynga.utils
{
   import flash.net.SharedObject;
   import flash.events.NetStatusEvent;
   import flash.net.SharedObjectFlushStatus;
   
   public class LocalCookieManager extends Object
   {
      
      public function LocalCookieManager() {
         super();
      }
      
      private static var cookieSharedObject:SharedObject;
      
      public static function loadLocalCookie(param1:String="ZyngaPoker_Cookie") : void {
         var cookieName:String = param1;
         try
         {
            cookieSharedObject = SharedObject.getLocal(cookieName);
            if(cookieSharedObject.size > 0)
            {
            }
         }
         catch(err:Error)
         {
         }
      }
      
      public static function saveLocalCookie() : void {
         if(!cookieSharedObject)
         {
            return;
         }
         var flushStatus:String = null;
         try
         {
            flushStatus = cookieSharedObject.flush(10000);
         }
         catch(err:Error)
         {
         }
         if(flushStatus)
         {
            switch(flushStatus)
            {
               case SharedObjectFlushStatus.PENDING:
                  cookieSharedObject.addEventListener(NetStatusEvent.NET_STATUS,onFlushStatus);
                  break;
               case SharedObjectFlushStatus.FLUSHED:
                  break;
            }
            
         }
      }
      
      private static function onFlushStatus(param1:NetStatusEvent) : void {
         switch(param1.info.code)
         {
            case "SharedObject.Flush.Success":
               break;
            case "SharedObject.Flush.Failed":
               break;
         }
         
         cookieSharedObject.removeEventListener(NetStatusEvent.NET_STATUS,onFlushStatus);
      }
      
      public static function deleteLocalCookie() : void {
         if(cookieSharedObject)
         {
            try
            {
               cookieSharedObject.clear();
            }
            catch(err:Error)
            {
            }
         }
      }
      
      public static function commitValueWithKey(param1:String, param2:*) : void {
         if(!cookieSharedObject)
         {
            return;
         }
         if(param2 == "null" || param2 == null)
         {
            return;
         }
         cookieSharedObject.data[param1] = param2;
      }
      
      public static function getValueWithKey(param1:String) : * {
         if(!cookieSharedObject)
         {
            return null;
         }
         return cookieSharedObject.data[param1];
      }
      
      public static function clearValueWithKey(param1:String) : void {
         var inKey:String = param1;
         try
         {
            if(cookieSharedObject.data.hasOwnProperty(inKey))
            {
               delete cookieSharedObject.data[[inKey]];
            }
         }
         catch(err:Error)
         {
         }
      }
   }
}
