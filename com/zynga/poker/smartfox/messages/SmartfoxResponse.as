package com.zynga.poker.smartfox.messages
{
   import com.adobe.serialization.json.JSON;
   
   public class SmartfoxResponse extends SmartfoxMessage
   {
      
      public function SmartfoxResponse(param1:Object) {
         var _loc2_:* = "";
         if(param1.type == SmartfoxMessage.TYPE_XML)
         {
            _loc2_ = param1.dataObj._cmd;
         }
         else
         {
            if(param1.type == SmartfoxMessage.TYPE_STR)
            {
               _loc2_ = param1.dataObj[0];
            }
            else
            {
               if(param1.type == SmartfoxMessage.TYPE_JSON)
               {
                  _loc2_ = param1.dataObj.commandName;
               }
            }
         }
         super(_loc2_,param1.type);
         this._data = param1.dataObj;
      }
      
      private var _data:Object;
      
      public function getIntByKey(param1:String, param2:int=0) : int {
         return this.getTypedValueByKey(param1,int,param2);
      }
      
      public function getIntByIndex(param1:int, param2:int=0) : int {
         return this.getTypedValueByIndex(param1,int,param2);
      }
      
      public function getStringByKey(param1:String, param2:String=null) : String {
         return this.getTypedValueByKey(param1,String,param2);
      }
      
      public function getStringByIndex(param1:int, param2:String=null) : String {
         return this.getTypedValueByIndex(param1,String,param2);
      }
      
      public function getNumberByKey(param1:String) : Number {
         return this.getTypedValueByKey(param1,Number,null);
      }
      
      public function getNumberByIndex(param1:int) : Number {
         return this.getTypedValueByIndex(param1,Number,null);
      }
      
      public function getObjectByKey(param1:String) : Object {
         return this.getTypedValueByKey(param1,Object,null);
      }
      
      public function getObjectByIndex(param1:int) : Object {
         return this.getTypedValueByIndex(param1,Object,null);
      }
      
      public function getJsonObjectByKey(param1:String) : Object {
         var _loc2_:String = this.getTypedValueByKey(param1,String,null);
         if(_loc2_)
         {
            return com.adobe.serialization.json.JSON.decode(_loc2_);
         }
         return null;
      }
      
      public function getJsonObjectByIndex(param1:int) : Object {
         var _loc2_:String = this.getTypedValueByIndex(param1,String,null);
         if(_loc2_)
         {
            return com.adobe.serialization.json.JSON.decode(_loc2_);
         }
         return null;
      }
      
      public function getArrayByKey(param1:String) : Array {
         return this.getTypedValueByKey(param1,Array,null);
      }
      
      public function getArrayByIndex(param1:int) : Array {
         return this.getTypedValueByIndex(param1,Array,null);
      }
      
      private function getTypedValueByKey(param1:String, param2:Class, param3:*) : * {
         var _loc4_:* = param3;
         if(type == SmartfoxMessage.TYPE_XML || type == SmartfoxMessage.TYPE_JSON)
         {
            if(this._data[param1] as param2 != null)
            {
               _loc4_ = this._data[param1];
            }
         }
         return _loc4_ as param2;
      }
      
      private function getTypedValueByIndex(param1:int, param2:Class, param3:*) : * {
         var _loc4_:* = param3;
         if(type == SmartfoxMessage.TYPE_STR)
         {
            if(this._data[param1] as param2 != null)
            {
               _loc4_ = this._data[param1];
            }
         }
         return _loc4_ as param2;
      }
   }
}
