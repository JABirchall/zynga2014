package com.zynga.poker
{
   import com.zynga.io.ExternalCall;
   
   public class ConfigService extends Object implements IConfigService
   {
      
      public function ConfigService() {
         super();
      }
      
      public function loadConfigForFeature(param1:String) : * {
         return ExternalCall.getInstance().call("zc.feature.flash.getConfigForFeature",param1);
      }
   }
}
