package com.zynga.poker
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import com.zynga.poker.registry.IClassRegistry;
   import com.zynga.poker.commands.ICommand;
   import com.zynga.poker.commands.SelfContainedCommand;
   import com.zynga.poker.commands.SmartfoxCommand;
   import com.zynga.poker.commands.JSCommand;
   import com.zynga.io.IExternalCall;
   import com.zynga.poker.commands.IEventDispatcherCommand;
   import flash.events.IEventDispatcher;
   
   public class PokerCommandDispatcher extends EventDispatcher implements ICommandDispatcher
   {
      
      public function PokerCommandDispatcher(param1:Inner) {
         this._dispatcherMap = new Dictionary(true);
         super();
         if(param1 == null)
         {
            throw new Error("PokerCommandDispatcher class cannot be instantiated");
         }
         else
         {
            return;
         }
      }
      
      private static var _instance:PokerCommandDispatcher;
      
      public static function getInstance() : PokerCommandDispatcher {
         if(_instance == null)
         {
            _instance = new PokerCommandDispatcher(new Inner());
         }
         return _instance;
      }
      
      private var _dispatcherMap:Dictionary;
      
      public var registry:IClassRegistry;
      
      public function dispatchCommand(param1:ICommand) : void {
         var _loc2_:SelfContainedCommand = null;
         param1.configModel = this.registry.getObject(ConfigModel);
         if(param1 is SelfContainedCommand)
         {
            _loc2_ = param1 as SelfContainedCommand;
            _loc2_.registry = this.registry;
            _loc2_.execute();
         }
         else
         {
            if(this._dispatcherMap[param1.baseType])
            {
               if(param1 is SmartfoxCommand)
               {
                  (param1 as SmartfoxCommand).execute(this._dispatcherMap[param1.baseType]);
               }
               else
               {
                  if(param1 is JSCommand)
                  {
                     (param1 as JSCommand).execute(this.registry.getObject(IExternalCall));
                  }
                  else
                  {
                     (param1 as IEventDispatcherCommand).execute(this._dispatcherMap[param1.baseType]);
                  }
               }
            }
         }
      }
      
      public function addDispatcherForType(param1:Class, param2:IEventDispatcher) : void {
         this._dispatcherMap[param1] = param2;
      }
   }
}
class Inner extends Object
{
   
   function Inner() {
      super();
   }
}
