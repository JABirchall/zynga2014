package com.zynga.poker.table.positioning
{
   import __AS3__.vec.Vector;
   
   public class PlayerPositionSchema extends Object
   {
      
      public function PlayerPositionSchema(param1:uint, param2:uint) {
         super();
         this._position = param1;
         this._mappedPosition = param2;
         this._tweenPath = null;
      }
      
      private var _position:uint;
      
      private var _mappedPosition:uint;
      
      private var _tweenPath:Vector.<PlayerPositionPathNode>;
      
      public function get position() : uint {
         return this._position;
      }
      
      public function get mappedPosition() : uint {
         return this._mappedPosition;
      }
      
      public function set mappedPosition(param1:uint) : void {
         this._mappedPosition = param1;
      }
      
      public function get tweenPath() : Vector.<PlayerPositionPathNode> {
         return this._tweenPath;
      }
      
      public function set tweenPath(param1:Vector.<PlayerPositionPathNode>) : void {
         this._tweenPath = param1;
      }
   }
}
