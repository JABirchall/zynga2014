package com.zynga.rad.containers.layouts
{
   import com.zynga.rad.BaseUI;
   import com.zynga.rad.containers.ILayout;
   import com.zynga.rad.containers.IPropertiesBubbler;
   import com.zynga.rad.containers.IMutable;
   import flash.utils.Dictionary;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import com.zynga.rad.util.ZuiUtil;
   import flash.geom.Rectangle;
   import __AS3__.vec.*;
   
   public dynamic class BaseLayout extends BaseUI implements ILayout, IPropertiesBubbler, IMutable
   {
      
      public function BaseLayout() {
         var _loc1_:* = 0;
         var _loc2_:DisplayObject = null;
         var _loc3_:SpacingData = null;
         this.m_objectToDataMap = new Dictionary();
         this.m_removedObjectsToDataMap = new Dictionary();
         super();
         this.m_sortedChildren = new Vector.<SpacingData>(0);
         _loc1_ = 0;
         while(_loc1_ < numChildren)
         {
            _loc2_ = getChildAt(_loc1_);
            _loc3_ = new SpacingData(_loc2_);
            this.m_objectToDataMap[_loc3_.object] = _loc3_;
            this.m_sortedChildren.push(_loc3_);
            _loc1_++;
         }
         this.m_sortedChildren.sort(this.sortingFunction);
      }
      
      protected var m_sortedChildren:Vector.<SpacingData>;
      
      protected var m_objectToDataMap:Dictionary;
      
      protected var m_removedObjectsToDataMap:Dictionary;
      
      override public function destroy() : void {
         var _loc1_:SpacingData = null;
         var _loc2_:* = undefined;
         var _loc3_:* = 0;
         var _loc4_:DisplayObject = null;
         for each (_loc1_ in this.m_sortedChildren)
         {
            _loc1_.destroy();
         }
         if(this.m_sortedChildren != null)
         {
            this.m_sortedChildren.length = 0;
         }
         this.m_sortedChildren = null;
         for (_loc2_ in this.m_objectToDataMap)
         {
            delete this.m_objectToDataMap[[_loc2_]];
         }
         this.m_objectToDataMap = null;
         for (_loc2_ in this.m_removedObjectsToDataMap)
         {
            delete this.m_removedObjectsToDataMap[[_loc2_]];
         }
         this.m_removedObjectsToDataMap = null;
         _loc3_ = 0;
         while(_loc3_ < numChildren)
         {
            _loc4_ = getChildAt(_loc3_);
            if(_loc4_ is BaseUI)
            {
               BaseUI(_loc4_).destroy();
            }
            _loc3_++;
         }
         super.destroy();
      }
      
      protected function sortingFunction(param1:SpacingData, param2:SpacingData) : int {
         throw new Error("Must override sortingFunction in BaseLayout");
      }
      
      public function getNamedInstances(param1:Object, param2:DisplayObjectContainer=null) : void {
         ZuiUtil.getNamedInstances(this,param1,param2);
      }
      
      public function hasItem(param1:DisplayObject) : Boolean {
         var _loc3_:SpacingData = null;
         var _loc2_:* = false;
         if(this.m_objectToDataMap)
         {
            _loc3_ = this.m_removedObjectsToDataMap[param1] as SpacingData;
            _loc2_ = _loc3_ == null;
         }
         return _loc2_;
      }
      
      public function removeItem(param1:DisplayObject) : void {
         var _loc2_:SpacingData = null;
         if(this.m_objectToDataMap)
         {
            _loc2_ = this.m_objectToDataMap[param1] as SpacingData;
            if((_loc2_) && _loc2_.object == param1)
            {
               this.m_removedObjectsToDataMap[param1] = _loc2_;
               if(param1.parent == this)
               {
                  removeChild(param1);
               }
            }
         }
      }
      
      public function addItem(param1:DisplayObject, param2:int=-1) : void {
         var _loc3_:SpacingData = this.m_removedObjectsToDataMap[param1] as SpacingData;
         if((this.m_objectToDataMap[param1]) && (_loc3_) && _loc3_.object == param1)
         {
            delete this.m_removedObjectsToDataMap[[param1]];
         }
         else
         {
            if(this.hasItem(param1))
            {
               return;
            }
            _loc3_ = new SpacingData(param1);
            this.m_objectToDataMap[_loc3_.object] = _loc3_;
            this.m_sortedChildren.push(_loc3_);
            this.m_sortedChildren.sort(this.sortingFunction);
         }
         if(param2 >= 0)
         {
            addChildAt(param1,param2);
         }
         else
         {
            addChild(param1);
         }
      }
      
      public function doLayout() : void {
         throw new Error("BaseLayout.doLayout must be implemented in subclasses");
      }
      
      override public function getBounds(param1:DisplayObject) : Rectangle {
         var _loc4_:DisplayObject = null;
         var _loc2_:Rectangle = new Rectangle();
         var _loc3_:* = 0;
         while(_loc3_ < numChildren)
         {
            _loc4_ = getChildAt(_loc3_);
            _loc2_ = _loc2_.union(_loc4_.getBounds(param1));
            _loc3_++;
         }
         return _loc2_;
      }
   }
}
