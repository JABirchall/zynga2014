package com.zynga.poker.layers
{
   import flash.display.Sprite;
   
   public class Layer extends Sprite
   {
      
      public function Layer(param1:String, param2:int=0) {
         super();
         this._key = param1;
         this._index = param2;
      }
      
      private var _key:String;
      
      private var _index:int;
      
      public function get key() : String {
         return this._key;
      }
      
      public function get childIndex() : int {
         return this._index;
      }
      
      public function removeAllChildren() : void {
         while(numChildren)
         {
            removeChildAt(numChildren-1);
         }
      }
   }
}
