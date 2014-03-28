package com.zynga.poker.table.interfaces
{
   import flash.display.DisplayObject;
   
   public interface IChickletMenu
   {
      
      function show(param1:Number, param2:Number, param3:Array=null, param4:Boolean=false, param5:Boolean=false, param6:Boolean=false, param7:Boolean=false, param8:Boolean=false, param9:Number=0) : void;
      
      function hide() : void;
      
      function updateWithUserData(param1:Array) : void;
      
      function get visible() : Boolean;
      
      function get container() : DisplayObject;
   }
}
