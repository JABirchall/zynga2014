package com.zynga.poker.table
{
   import flash.utils.Dictionary;
   
   public class UIDObfuscator extends Object
   {
      
      public function UIDObfuscator() {
         this._uidDict = new Dictionary();
         this._keyDict = new Dictionary();
         super();
      }
      
      private var _uidDict:Dictionary;
      
      private var _keyDict:Dictionary;
      
      private var _incrementer:Number = -1.0;
      
      public function addUserWithUID(param1:String) : Number {
         if(!this._keyDict[param1])
         {
            this._incrementer++;
            this._keyDict[param1] = this._incrementer;
            this._uidDict[this._incrementer] = param1;
         }
         return this._keyDict[param1];
      }
      
      public function getUIDWithObfuscationIndex(param1:Number) : String {
         return this._uidDict[param1];
      }
      
      public function getObfuscationIndexWithUID(param1:String) : Number {
         return this._keyDict[param1];
      }
   }
}
