package com.zynga.poker.commands.selfcontained
{
   import com.zynga.poker.commands.SelfContainedCommand;
   import com.zynga.poker.nav.INavController;
   
   public class DeselectSideNavItemCommand extends SelfContainedCommand
   {
      
      public function DeselectSideNavItemCommand(param1:String) {
         super({"itemName":param1});
      }
      
      override public function execute() : void {
         registry.getObject(INavController).setSidebarItemsDeselected(payload.itemName);
      }
   }
}
