package com.zynga.poker.table.positioning
{
   public class PlayerPositionPathNode extends Object
   {
      
      public function PlayerPositionPathNode(param1:uint, param2:Number, param3:Function) {
         super();
         this._toMappedPosition = param1;
         this._duration = param2;
         this._ease = param3;
      }
      
      private var _toMappedPosition:uint;
      
      private var _duration:Number;
      
      private var _ease:Function;
      
      public function get toMappedPosition() : uint {
         return this._toMappedPosition;
      }
      
      public function get duration() : Number {
         return this._duration;
      }
      
      public function get ease() : Function {
         return this._ease;
      }
   }
}
