package com.zynga
{
   import com.zynga.rad.BaseUI;
   
   public class BaseObject extends Object
   {
      
      public function BaseObject() {
         super();
      }
      
      protected function assert(param1:Boolean, param2:String) : void {
         if(!param1)
         {
            if(BaseUI.logger)
            {
               BaseUI.logger.error(param2);
            }
            throw new Error("Assertion failed: " + param2);
         }
         else
         {
            return;
         }
      }
   }
}
