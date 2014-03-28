package com.zynga.poker.nav
{
   import flash.events.Event;
   
   public interface INavController
   {
      
      function setSidebarItemsSelected(param1:String="") : void;
      
      function showSideNav(param1:Event=null) : void;
   }
}
