package com.zynga.poker.table.todo
{
   import com.zynga.poker.feature.FeatureModel;
   import flash.events.IEventDispatcher;
   import flash.events.EventDispatcher;
   import flash.events.Event;
   
   public class TodoIconModel extends FeatureModel implements IEventDispatcher
   {
      
      public function TodoIconModel() {
         super();
      }
      
      public const MODEL_UPDATE_EVENT:String = "todoModelUpdate";
      
      private var _dispatcher:EventDispatcher;
      
      public var name:String;
      
      public var url:String;
      
      public var tooltip:String;
      
      public var cb:String;
      
      public var hideOnClick:Boolean;
      
      public var startDisabled:Boolean;
      
      private var _count:int;
      
      public function get count() : int {
         return this._count;
      }
      
      public function set count(param1:int) : void {
         if(param1 == 0 && this._count > 0)
         {
            this._count = -1;
         }
         else
         {
            this._count = param1;
         }
      }
      
      override public function init() : void {
         this._dispatcher = new EventDispatcher();
      }
      
      public function populate(param1:Object) : void {
         var _loc2_:String = null;
         for (_loc2_ in param1)
         {
            this[_loc2_] = param1[_loc2_];
         }
         this.dispatchEvent(new Event(this.MODEL_UPDATE_EVENT));
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean=false, param4:int=0, param5:Boolean=false) : void {
         this._dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function dispatchEvent(param1:Event) : Boolean {
         return this._dispatcher.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean {
         return this._dispatcher.hasEventListener(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean=false) : void {
         this._dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function willTrigger(param1:String) : Boolean {
         return this._dispatcher.willTrigger(param1);
      }
   }
}
