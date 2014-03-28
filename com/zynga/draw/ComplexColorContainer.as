package com.zynga.draw
{
   import flash.geom.Matrix;
   import flash.events.EventDispatcher;
   import flash.events.Event;
   
   public class ComplexColorContainer extends Object
   {
      
      public function ComplexColorContainer(param1:Object=null) {
         super();
         if(param1)
         {
            this._colors = param1["colors"] as Array;
            this._alphas = param1["alphas"] as Array;
            this._ratios = param1["ratios"] as Array;
            this._width = Number(param1["width"]);
            this._height = Number(param1["height"]);
            this._rotation = Number(param1["rotation"]);
         }
         this._dispatcher = new EventDispatcher();
      }
      
      private var _colors:Array;
      
      private var _alphas:Array;
      
      private var _ratios:Array;
      
      private var _matrix:Matrix;
      
      private var _width:Number = 0.0;
      
      private var _height:Number = 0.0;
      
      private var _rotation:Number = 0.0;
      
      private var _dispatcher:EventDispatcher;
      
      public function set colors(param1:Array) : void {
         var inArray:Array = param1;
         this._colors = new Array();
         this._colors = inArray.map(function(param1:*, ... rest):*
         {
            return param1;
         });
         this._dispatcher.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function get colors() : Array {
         return this._colors;
      }
      
      public function set alphas(param1:Array) : void {
         var inArray:Array = param1;
         this._alphas = new Array();
         this._alphas = inArray.map(function(param1:*, ... rest):*
         {
            return param1;
         });
         this._dispatcher.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function get alphas() : Array {
         return this._alphas;
      }
      
      public function set ratios(param1:Array) : void {
         var inArray:Array = param1;
         this._ratios = new Array();
         this._ratios = inArray.map(function(param1:*, ... rest):*
         {
            return param1;
         });
         this._dispatcher.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function get ratios() : Array {
         return this._ratios;
      }
      
      public function set width(param1:Number) : void {
         this._width = param1;
         this._dispatcher.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function get width() : Number {
         return this._width;
      }
      
      public function set height(param1:Number) : void {
         this._height = param1;
         this._dispatcher.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function get height() : Number {
         return this._height;
      }
      
      public function set rotation(param1:Number) : void {
         this._rotation = param1;
         this._dispatcher.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function get rotation() : Number {
         return this._rotation;
      }
      
      public function set matrix(param1:Matrix) : void {
         this.matrix = param1.clone();
         this._dispatcher.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function get matrix() : Matrix {
         if(!this._matrix)
         {
            this._matrix = new Matrix();
            this._matrix.createGradientBox(this._width,this._height,this._rotation * Math.PI / 180);
         }
         return this._matrix;
      }
      
      public function clone() : ComplexColorContainer {
         return new ComplexColorContainer(
            {
               "colors":this._colors,
               "alphas":this._alphas,
               "ratios":this._ratios,
               "width":this._width,
               "height":this._height,
               "rotation":this._rotation
            });
      }
      
      public function addEventListener(param1:String, param2:Function) : void {
         this._dispatcher.addEventListener(param1,param2);
      }
      
      public function removeEventListener(param1:String, param2:Function) : void {
         this._dispatcher.removeEventListener(param1,param2);
      }
   }
}
