package com.zynga.rad.lists
{
   import flash.display.DisplayObject;
   import com.zynga.rad.containers.ILayout;
   import com.zynga.rad.BaseUI;
   
   public class ListItem extends Object
   {
      
      public function ListItem(param1:Function=null, param2:DisplayObject=null, param3:Object=null) {
         super();
         this.factory = param1;
         this.item = param2;
         this.data = param3;
      }
      
      public var factory:Function;
      
      public var item:DisplayObject;
      
      public var data:Object;
      
      public function generateItem() : void {
         if(!this.item)
         {
            this.item = this.factory();
            if(this.item is ILayout)
            {
               ILayout(this.item).doLayout();
            }
         }
      }
      
      public function destroy() : void {
         this.factory = null;
         if(this.item is BaseUI)
         {
            BaseUI(this.item).destroy();
         }
      }
   }
}
