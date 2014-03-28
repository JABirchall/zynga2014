package com.zynga.poker.commands.selfcontained
{
   import com.zynga.poker.commands.SelfContainedCommand;
   import com.zynga.poker.nav.INavController;
   import com.zynga.poker.nav.NavController;
   
   public class PositionSideNavCommand extends SelfContainedCommand
   {
      
      public function PositionSideNavCommand(param1:int) {
         super();
         this._positionType = param1;
      }
      
      public static const POSITION_LOBBY:int = 0;
      
      public static const POSITION_TABLE:int = 1;
      
      private var _positionType:int;
      
      override public function execute() : void {
         var _loc1_:NavController = registry.getObject(INavController) as NavController;
         if(!(_loc1_ == null) && !(_loc1_.navView == null))
         {
            _loc1_.navView.positionSideNav(this._positionType);
         }
      }
   }
}
