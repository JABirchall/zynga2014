package com.zynga.poker.commands.selfcontained.module
{
   import com.zynga.poker.commands.SelfContainedCommand;
   import com.zynga.poker.module.interfaces.IModuleController;
   import com.zynga.poker.module.ModuleEvent;
   
   public class LoadModuleCommand extends SelfContainedCommand
   {
      
      public function LoadModuleCommand(param1:String, param2:Function=null, param3:Function=null, param4:Function=null) {
         super(null,param2);
         this._id = param1;
         this._failHandler = param3;
         this._progressHandler = param4;
      }
      
      private var _controller:IModuleController;
      
      private var _id:String;
      
      private var _failHandler:Function;
      
      private var _progressHandler:Function;
      
      override public function execute() : void {
         this._controller = registry.getObject(IModuleController);
         this.addListeners();
         this._controller.loadModule(this._id,this._progressHandler);
      }
      
      private function onModuleLoad(param1:ModuleEvent) : void {
         if(param1.id == this._id)
         {
            _handler.call(this,param1);
            this.removeListeners();
         }
      }
      
      private function onModuleLoadFailure(param1:ModuleEvent) : void {
         if(param1.id == this._id)
         {
            this._failHandler.call(this,param1);
            this.removeListeners();
         }
      }
      
      private function onModuleProgress(param1:ModuleEvent) : void {
         if(param1.id == this._id)
         {
            this._progressHandler.call(this,param1);
         }
      }
      
      private function addListeners() : void {
         if(this._controller)
         {
            if(_handler != null)
            {
               this._controller.addEventListener(ModuleEvent.MODULE_LOADED_EVENT,this.onModuleLoad);
            }
            if(this._failHandler != null)
            {
               this._controller.addEventListener(ModuleEvent.MODULE_LOADFAILED_EVENT,this.onModuleLoadFailure);
            }
            if(this._progressHandler != null)
            {
               this._controller.addEventListener(ModuleEvent.MODULE_PROGRESS_EVENT,this.onModuleProgress);
            }
         }
      }
      
      private function removeListeners() : void {
         if(this._controller)
         {
            if(_handler != null)
            {
               this._controller.removeEventListener(ModuleEvent.MODULE_LOADED_EVENT,this.onModuleLoad);
            }
            if(this._failHandler != null)
            {
               this._controller.removeEventListener(ModuleEvent.MODULE_LOADFAILED_EVENT,this.onModuleLoadFailure);
            }
            if(this._progressHandler != null)
            {
               this._controller.removeEventListener(ModuleEvent.MODULE_PROGRESS_EVENT,this.onModuleProgress);
            }
         }
      }
   }
}
