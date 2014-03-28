package com.zynga.rad.lists
{
   import com.zynga.rad.BaseUI;
   import com.zynga.rad.containers.ILayout;
   import flash.display.MovieClip;
   import flash.display.DisplayObject;
   
   public dynamic class VStackList extends BaseUI implements ILayout
   {
      
      public function VStackList() {
         this.m_listItems = [];
         super();
      }
      
      private var m_listItems:Array;
      
      private var m_height:Number = 0;
      
      private var m_padding:Number = 0;
      
      private var m_sortFunction:Function;
      
      public var backing:MovieClip;
      
      public function addItem(param1:BaseUI, param2:int=0) : void {
         if(this.m_listItems.indexOf(param1) >= 0)
         {
            return;
         }
         this.m_listItems.push(param1);
         this.addChild(param1);
         if(this.m_sortFunction != null)
         {
            this.m_listItems.sort(this.m_sortFunction);
         }
         this.m_height = 0;
         for each (param1 in this.m_listItems)
         {
            param1.y = this.m_height;
            this.m_height = this.m_height + (param1.height + this.m_padding);
         }
      }
      
      public function removeItem(param1:BaseUI, param2:Boolean=true) : void {
         var _loc4_:DisplayObject = null;
         var _loc3_:int = this.m_listItems.indexOf(param1);
         if(_loc3_ >= 0)
         {
            this.m_listItems.splice(_loc3_,1);
            if(param1.parent == this)
            {
               removeChild(param1);
            }
            if(param2)
            {
               param1.destroy();
            }
            this.m_height = 0;
            for each (_loc4_ in this.m_listItems)
            {
               _loc4_.y = this.m_height;
               this.m_height = this.m_height + (_loc4_.height + this.m_padding);
            }
         }
      }
      
      public function clear() : void {
         var _loc1_:BaseUI = null;
         for each (_loc1_ in this.m_listItems)
         {
            _loc1_.destroy();
            if(_loc1_.parent == this)
            {
               removeChild(_loc1_);
            }
         }
         this.m_listItems.length = 0;
         this.m_height = 0;
      }
      
      public function set padding(param1:Number) : void {
         this.m_padding = param1;
      }
      
      public function get items() : Array {
         return this.m_listItems;
      }
      
      public function set sortFunction(param1:Function) : void {
         this.m_sortFunction = param1;
      }
      
      public function sort() : void {
         var _loc1_:BaseUI = null;
         if(this.m_sortFunction != null)
         {
            this.m_listItems.sort(this.m_sortFunction);
            this.m_height = 0;
            for each (_loc1_ in this.m_listItems)
            {
               _loc1_.y = this.m_height;
               this.m_height = this.m_height + (_loc1_.height + this.m_padding);
            }
         }
      }
      
      public function doLayout() : void {
         if((this.backing) && (this.backing.parent))
         {
            this.backing.parent.removeChild(this.backing);
         }
      }
   }
}
