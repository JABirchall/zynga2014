package com.zynga.poker.commands.selfcontained.module
{
   import com.zynga.poker.commands.SelfContainedCommand;
   import com.zynga.poker.module.interfaces.IModuleController;
   
   public class HideModuleCommand extends SelfContainedCommand
   {
      
      public function HideModuleCommand(param1:String, param2:Object=null, param3:Function=null) {
         super(param2,param3);
         this._id = param1;
      }
      
      private var _id:String;
      
      override public function execute() : void {
         var _loc1_:IModuleController = registry.getObject(IModuleController);
         _loc1_.hideModule(this._id);
      }
   }
}
