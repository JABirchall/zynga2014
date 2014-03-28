package com.zynga.poker.commands.selfcontained.module
{
   import com.zynga.poker.commands.SelfContainedCommand;
   import com.zynga.poker.module.interfaces.IModuleController;
   import flash.display.DisplayObjectContainer;
   import com.zynga.poker.module.ModuleEvent;
   
   public class ShowModuleCommand extends SelfContainedCommand
   {
      
      public function ShowModuleCommand(param1:String, param2:Object=null, param3:Function=null, param4:Function=null, param5:Function=null, param6:DisplayObjectContainer=null) {
         super(param2,param3);
         this._id = param1;
         this._closingHandler = param4;
         this._closeHandler = param5;
         this._loadAttempted = false;
         this._layer = param6;
      }
      
      private var _controller:IModuleController;
      
      private var _id:String;
      
      private var _closeHandler:Function;
      
      private var _loadAttempted:Boolean;
      
      private var _closingHandler:Function;
      
      private var _layer:DisplayObjectContainer;
      
      override public function execute() : void {
         var _loc2_:LoadModuleCommand = null;
         if(this._controller == null)
         {
            this._controller = registry.getObject(IModuleController);
         }
         if(this._loadAttempted == false)
         {
            if(_handler != null)
            {
               this._controller.addEventListener(ModuleEvent.MODULE_WILLOPEN_EVENT,this.onModuleWillOpen);
            }
            if(this._closingHandler != null)
            {
               this._controller.addEventListener(ModuleEvent.MODULE_WILLCLOSE_EVENT,this.onModuleWillClose);
            }
            if(this._closeHandler != null)
            {
               this._controller.addEventListener(ModuleEvent.MODULE_CLOSED_EVENT,this.onModuleClosed);
            }
         }
         var _loc1_:Boolean = this._controller.displayModule(this._id,payload,this._layer);
         if(!_loc1_)
         {
            if(!this._loadAttempted)
            {
               _loc2_ = new LoadModuleCommand(this._id,this.onModuleLoad);
               _loc2_.registry = registry;
               _loc2_.execute();
            }
            else
            {
               if(_handler != null)
               {
                  this._controller.removeEventListener(ModuleEvent.MODULE_WILLOPEN_EVENT,this.onModuleWillOpen);
               }
               if(this._closingHandler != null)
               {
                  this._controller.removeEventListener(ModuleEvent.MODULE_WILLCLOSE_EVENT,this.onModuleWillClose);
               }
               if(this._closeHandler != null)
               {
                  this._controller.removeEventListener(ModuleEvent.MODULE_CLOSED_EVENT,this.onModuleClosed);
               }
            }
         }
      }
      
      private function onModuleLoad(param1:ModuleEvent) : void {
         this._loadAttempted = true;
         this.execute();
      }
      
      private function onModuleWillOpen(param1:ModuleEvent) : void {
         if(param1.id == this._id)
         {
            _handler.call(this,param1);
            this._controller.removeEventListener(ModuleEvent.MODULE_WILLOPEN_EVENT,this.onModuleWillOpen);
         }
      }
      
      private function onModuleWillClose(param1:ModuleEvent) : void {
         if(param1.id == this._id)
         {
            this._closingHandler.call(this,param1);
            this._controller.removeEventListener(ModuleEvent.MODULE_WILLCLOSE_EVENT,this.onModuleWillClose);
         }
      }
      
      private function onModuleClosed(param1:ModuleEvent) : void {
         if(param1.id == this._id)
         {
            this._closeHandler.call(this,param1);
            this._controller.removeEventListener(ModuleEvent.MODULE_CLOSED_EVENT,this.onModuleClosed);
         }
      }
   }
}
