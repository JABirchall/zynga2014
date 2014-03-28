package com.zynga.poker
{
   import com.zynga.io.ExternalCall;
   
   public class SSLMigration extends Object
   {
      
      public function SSLMigration() {
         super();
      }
      
      private static const aNonSecureURLsPairedToSecure:Array;
      
      private static const SECURE_URL:int = 1;
      
      private static const INSECURE_URL:int = 0;
      
      private static var bEnableSSL:Boolean = false;
      
      public static var collectionUrlPrefix:String;
      
      public static function log(param1:*) : void {
         ExternalCall.getInstance().call("console.log",param1);
      }
      
      public static function get isSSLEnabled() : Boolean {
         return bEnableSSL;
      }
      
      public static function set isSSLEnabled(param1:Boolean) : void {
         bEnableSSL = param1;
      }
      
      public static function getSecureURL(param1:String) : String {
         var _loc2_:* = 0;
         if(!(param1.indexOf("http") == 0) && !(collectionUrlPrefix == null) && !(collectionUrlPrefix == ""))
         {
            param1 = collectionUrlPrefix + param1;
            return param1;
         }
         if(isSSLEnabled)
         {
            if(param1.indexOf("https") != 0)
            {
               if(param1.indexOf("http") == 0)
               {
                  if(param1.length > 0)
                  {
                     _loc2_ = 0;
                     while(_loc2_ < aNonSecureURLsPairedToSecure.length)
                     {
                        if(param1.search(aNonSecureURLsPairedToSecure[_loc2_][INSECURE_URL]) == 0)
                        {
                           param1 = aNonSecureURLsPairedToSecure[_loc2_][SECURE_URL] + param1.substr(String(aNonSecureURLsPairedToSecure[_loc2_][INSECURE_URL]).length);
                           break;
                        }
                        _loc2_++;
                     }
                  }
               }
            }
         }
         return param1;
      }
      
      public static function getAppropriateProfileImageUrl(param1:String) : String {
         var _loc2_:* = 2;
         if(isSSLEnabled)
         {
            if(param1.search(aNonSecureURLsPairedToSecure[_loc2_][INSECURE_URL]) == 0)
            {
               param1 = aNonSecureURLsPairedToSecure[_loc2_][SECURE_URL] + param1.substr(String(aNonSecureURLsPairedToSecure[_loc2_][INSECURE_URL]).length);
            }
         }
         else
         {
            if(param1.search(aNonSecureURLsPairedToSecure[_loc2_][SECURE_URL]) == 0)
            {
               param1 = aNonSecureURLsPairedToSecure[_loc2_][INSECURE_URL] + param1.substr(String(aNonSecureURLsPairedToSecure[_loc2_][SECURE_URL]).length);
            }
         }
         return param1;
      }
      
      public static function getAppProtocol() : String {
         if(isSSLEnabled)
         {
            return "https://";
         }
         return "http://";
      }
   }
}
