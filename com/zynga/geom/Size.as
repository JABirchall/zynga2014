package com.zynga.geom
{
   public class Size extends Object
   {
      
      public function Size(param1:Number=0.0, param2:Number=0.0) {
         super();
         this._width = param1;
         this._height = param2;
      }
      
      private var _width:Number;
      
      private var _height:Number;
      
      public function set width(param1:Number) : void {
         this._width = param1;
      }
      
      public function get width() : Number {
         return this._width;
      }
      
      public function set height(param1:Number) : void {
         this._height = param1;
      }
      
      public function get height() : Number {
         return this._height;
      }
      
      public function toString() : String {
         return new String("w:" + this._width + " h:" + this._height);
      }
   }
}
