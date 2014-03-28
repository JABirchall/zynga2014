package com.zynga.rad.containers
{
   import com.zynga.rad.BaseUI;
   import flash.display.DisplayObjectContainer;
   import com.zynga.rad.util.ZuiUtil;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class EmptyContainer extends BaseUI implements ILayout, IPostLayout, IPropertiesBubbler
   {
      
      public function EmptyContainer() {
         super();
      }
      
      public function getNamedInstances(param1:Object, param2:DisplayObjectContainer=null) : void {
         ZuiUtil.getNamedInstances(this,param1,param2);
      }
      
      public function doLayout() : void {
         var _loc2_:DisplayObject = null;
         var _loc1_:* = 0;
         while(_loc1_ < this.numChildren)
         {
            _loc2_ = this.getChildAt(_loc1_);
            if(_loc2_ is ILayout)
            {
               ILayout(_loc2_).doLayout();
            }
            _loc1_++;
         }
      }
      
      public function doPostLayout() : void {
         var _loc2_:DisplayObject = null;
         var _loc1_:* = 0;
         while(_loc1_ < this.numChildren)
         {
            _loc2_ = this.getChildAt(_loc1_);
            if(_loc2_ is IPostLayout)
            {
               IPostLayout(_loc2_).doPostLayout();
            }
            _loc1_++;
         }
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
      
      override public function destroy() : void {
         var _loc2_:DisplayObject = null;
         var _loc1_:* = 0;
         while(_loc1_ < numChildren)
         {
            _loc2_ = getChildAt(_loc1_);
            if(_loc2_ is BaseUI)
            {
               BaseUI(_loc2_).destroy();
            }
            _loc1_++;
         }
      }
   }
}
