package com.zynga.performance.listeners
{
   import com.zynga.performance.memory.IDisposable;
   import flash.events.IEventDispatcher;
   
   public class ListenerInfo extends Object implements IDisposable
   {
      
      public function ListenerInfo(param1:IEventDispatcher, param2:String, param3:Function, param4:Function=null, param5:Boolean=false) {
         super();
         this.m_dispatcher = param1;
         this.m_type = param2;
         this.m_listener = param3;
         this.m_handler = param4;
         this.m_shouldRemoveAfterUse = param5;
      }
      
      public static const EVENT_HANDLED:String = "ListenerInfo:EventHandled";
      
      private var m_dispatcher:IEventDispatcher;
      
      private var m_type:String;
      
      private var m_listener:Function;
      
      private var m_handler:Function;
      
      private var m_shouldRemoveAfterUse:Boolean;
      
      public function get dispatcher() : IEventDispatcher {
         return this.m_dispatcher;
      }
      
      public function get type() : String {
         return this.m_type;
      }
      
      public function get listener() : Function {
         return this.m_listener;
      }
      
      public function get handler() : Function {
         return this.m_handler;
      }
      
      public function get shouldRemoveAfterUse() : Boolean {
         return this.m_shouldRemoveAfterUse;
      }
      
      public function equals(param1:ListenerInfo) : Boolean {
         return param1.dispatcher == this.m_dispatcher && param1.type == this.m_type && param1.listener == this.m_listener;
      }
      
      public function dispose() : void {
         this.m_dispatcher = null;
         this.m_listener = null;
         this.m_handler = null;
      }
   }
}
