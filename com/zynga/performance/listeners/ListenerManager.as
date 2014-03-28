package com.zynga.performance.listeners
{
   import com.zynga.performance.memory.Disposable;
   import flash.utils.Dictionary;
   import flash.events.IEventDispatcher;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.display.DisplayObjectContainer;
   import com.yahoo.astra.utils.DisplayObjectUtil;
   import flash.display.DisplayObject;
   import com.adobe.utils.DictionaryUtil;
   
   public class ListenerManager extends Disposable
   {
      
      public function ListenerManager() {
         super();
      }
      
      private static const DEFAULT:String = "default";
      
      private static var m_listeners:Dictionary;
      
      public static function addEventListener(param1:IEventDispatcher, param2:String, param3:Function, param4:int=0, param5:String="default", param6:Boolean=false) : ListenerInfo {
         var info:ListenerInfo = null;
         var a_dispatcher:IEventDispatcher = param1;
         var a_type:String = param2;
         var a_listener:Function = param3;
         var a_priority:int = param4;
         var a_group:String = param5;
         var a_removeAfterUse:Boolean = param6;
         if(!a_dispatcher || (hasEventListener(a_dispatcher,a_type,a_listener)))
         {
            return null;
         }
         var handler:Function = function(param1:Event):void
         {
            var _loc3_:Function = arguments.callee;
            if(info.shouldRemoveAfterUse)
            {
               ListenerManager.removeEventListener(a_dispatcher,a_type,a_listener);
            }
            a_listener(param1);
         };
         info = new ListenerInfo(a_dispatcher,a_type,a_listener,handler,a_removeAfterUse);
         if(!m_listeners[getKey(a_dispatcher)])
         {
            m_listeners[getKey(a_dispatcher)] = [];
         }
         var listenerGroups:Array = getListeners(a_dispatcher);
         if(!listenerGroups.hasOwnProperty(a_group))
         {
            listenerGroups[a_group] = [];
         }
         var listeners:Array = listenerGroups[a_group];
         listeners.push(info);
         a_dispatcher.addEventListener(a_type,handler,false,a_priority,false);
         return info;
      }
      
      public static function addOnceEventListener(param1:IEventDispatcher, param2:String, param3:Function, param4:int=0, param5:String="default") : ListenerInfo {
         return addEventListener(param1,param2,param3,param4,param5,true);
      }
      
      public static function addClickListener(param1:IEventDispatcher, param2:Function, param3:int=0, param4:String="default") : ListenerInfo {
         var _loc5_:Array = addMouseListeners(param1,param2,null,null,param3,param4);
         if(_loc5_.length > 0)
         {
            return _loc5_[0];
         }
         return null;
      }
      
      public static function addMouseListeners(param1:IEventDispatcher, param2:Function, param3:Function, param4:Function, param5:int=0, param6:String="default") : Array {
         var _loc7_:Array = [];
         if(param2 != null)
         {
            _loc7_.push(addEventListener(param1,MouseEvent.CLICK,param2,param5,param6));
         }
         if(param3 != null)
         {
            _loc7_.push(addEventListener(param1,MouseEvent.ROLL_OVER,param3,param5,param6));
         }
         if(param4 != null)
         {
            _loc7_.push(addEventListener(param1,MouseEvent.ROLL_OUT,param4,param5,param6));
         }
         return _loc7_;
      }
      
      private static function getKey(param1:IEventDispatcher) : Object {
         return param1;
      }
      
      public static function getListeners(param1:IEventDispatcher) : Array {
         var _loc2_:Array = m_listeners[getKey(param1)]?m_listeners[getKey(param1)]:[];
         return _loc2_;
      }
      
      public static function numListeners(param1:IEventDispatcher, param2:Boolean=false) : int {
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc3_:* = 0;
         if(param1 is DisplayObjectContainer)
         {
            _loc3_ = DisplayObjectUtil.getTotalListeners(param1 as DisplayObjectContainer,param2);
         }
         else
         {
            _loc4_ = ListenerManager.getListeners(param1);
            for each (_loc5_ in _loc4_)
            {
               _loc3_ = _loc3_ + _loc5_.length;
            }
         }
         return _loc3_;
      }
      
      public static function hasListeners(param1:IEventDispatcher) : Boolean {
         var _loc4_:Array = null;
         var _loc2_:* = false;
         var _loc3_:Array = getListeners(param1);
         for each (_loc4_ in _loc3_)
         {
            _loc2_ = true;
            return _loc2_;
         }
      }
      
      public static function numListenersOfType(param1:IEventDispatcher, param2:String) : int {
         var _loc5_:Array = null;
         var _loc6_:ListenerInfo = null;
         var _loc3_:* = 0;
         var _loc4_:Array = getListeners(param1);
         for each (_loc5_ in _loc4_)
         {
            for each (_loc6_ in _loc5_)
            {
               if(_loc6_.type == param2)
               {
                  _loc3_++;
               }
            }
         }
         return _loc3_;
      }
      
      public static function getListenersByGroup(param1:IEventDispatcher, param2:String="default") : Array {
         var _loc3_:Array = getListeners(param1);
         return _loc3_.hasOwnProperty(param2)?_loc3_[param2]:[];
      }
      
      public static function removeEventListener(param1:IEventDispatcher, param2:String, param3:Function) : void {
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:ListenerInfo = null;
         if(!param1)
         {
            return;
         }
         if(!hasListeners(param1))
         {
            return;
         }
         var _loc4_:ListenerInfo = new ListenerInfo(param1,param2,param3);
         var _loc5_:Array = getListeners(param1);
         for (_loc6_ in _loc5_)
         {
            _loc7_ = _loc5_[_loc6_];
            _loc8_ = _loc7_.length;
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               _loc10_ = _loc7_[_loc9_];
               if(_loc10_.equals(_loc4_))
               {
                  _loc7_.splice(_loc9_,1);
                  param1.removeEventListener(param2,_loc10_.handler);
                  _loc10_.dispose();
                  if(_loc7_.length == 0)
                  {
                     delete m_listeners[getKey(param1)][[_loc6_]];
                  }
                  break;
               }
               _loc9_++;
            }
         }
         if(ListenerManager.numListeners(param1) == 0)
         {
            delete m_listeners[[getKey(param1)]];
         }
      }
      
      public static function removeAllListeners(param1:IEventDispatcher, param2:Boolean=false) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public static function removeListenersForGroup(param1:IEventDispatcher, param2:String, param3:Boolean=true) : void {
         var _loc6_:ListenerInfo = null;
         var _loc7_:DisplayObjectContainer = null;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:DisplayObject = null;
         var _loc4_:Array = getListenersByGroup(param1,param2);
         var _loc5_:int = _loc4_.length;
         if(_loc5_ == 0)
         {
            return;
         }
         for each (_loc6_ in _loc4_)
         {
            param1.removeEventListener(_loc6_.type,_loc6_.listener);
            _loc6_.dispose();
         }
         _loc4_.length = 0;
         delete m_listeners[param1][[param2]];
         if(param3)
         {
            if(param1 is DisplayObjectContainer)
            {
               _loc7_ = param1 as DisplayObjectContainer;
               _loc8_ = _loc7_.numChildren;
               _loc9_ = 0;
               while(_loc9_ < _loc8_)
               {
                  _loc10_ = _loc7_.getChildAt(_loc9_);
                  ListenerManager.removeListenersForGroup(_loc10_,param2,true);
                  _loc9_++;
               }
            }
         }
      }
      
      public static function hasEventListener(param1:IEventDispatcher, param2:String, param3:Function) : Boolean {
         var _loc7_:Array = null;
         var _loc8_:ListenerInfo = null;
         var _loc4_:* = false;
         var _loc5_:ListenerInfo = new ListenerInfo(param1,param2,param3);
         var _loc6_:Array = getListeners(param1);
         for each (_loc7_ in _loc6_)
         {
            for each (_loc8_ in _loc7_)
            {
               if(_loc8_.equals(_loc5_))
               {
                  _loc4_ = true;
                  break;
               }
            }
         }
         return _loc4_;
      }
      
      public static function dispose() : void {
         var _loc1_:IEventDispatcher = null;
         for each (_loc1_ in m_listeners)
         {
            removeAllListeners(_loc1_);
         }
         DictionaryUtil.deleteAllKeys(m_listeners);
      }
   }
}
