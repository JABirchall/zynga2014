package com.zynga.utils
{
   import flash.net.SharedObject;
   
   public class FlashCookie extends Object
   {
      
      public function FlashCookie(param1:String) {
         super();
         this.mLocalSO = SharedObject.getLocal(param1,"/");
      }
      
      private var mLocalSO:SharedObject;
      
      private var kbDebugTrace:Boolean = false;
      
      private function OnStatus(param1:Object) : void {
         var _loc2_:Object = null;
         for (_loc2_ in param1)
         {
         }
      }
      
      public function Save() : void {
         var _loc1_:String = this.mLocalSO.flush();
         switch(_loc1_)
         {
            case "pending":
               break;
            case true:
               break;
            case false:
               break;
         }
         
      }
      
      public function SetValue(param1:String, param2:Object) : void {
         this.mLocalSO.data[param1] = param2;
         this.Save();
      }
      
      public function GetValue(param1:String, param2:Object) : Object {
         if(this.mLocalSO.data[param1] == undefined)
         {
            return param2;
         }
         return this.mLocalSO.data[param1];
      }
      
      public function ClearAllValues() : void {
         this.mLocalSO.clear();
      }
      
      private function dbTrace(param1:String) : void {
         if(this.kbDebugTrace)
         {
         }
      }
   }
}
