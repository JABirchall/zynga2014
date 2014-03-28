package com.zynga.rad.containers.anchors
{
   import com.zynga.rad.BaseUI;
   import com.zynga.rad.containers.ILayout;
   import com.zynga.rad.containers.IPropertiesBubbler;
   import com.zynga.rad.containers.IPostLayout;
   import com.zynga.rad.containers.ZContainer;
   import flash.geom.Point;
   import __AS3__.vec.Vector;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import flash.display.DisplayObjectContainer;
   import com.zynga.rad.util.ZuiUtil;
   
   public dynamic class BaseAnchor extends BaseUI implements ILayout, IPropertiesBubbler, IPostLayout
   {
      
      public function BaseAnchor() {
         var _loc3_:DisplayObject = null;
         this.m_layouts = new Vector.<ILayout>();
         this.m_postLayouts = new Vector.<IPostLayout>();
         super();
         var _loc1_:* = 0;
         while(_loc1_ < numChildren)
         {
            _loc3_ = getChildAt(_loc1_);
            if(_loc3_ is ILayout)
            {
               this.m_layouts.push(_loc3_);
            }
            if(_loc3_ is IPostLayout)
            {
               this.m_postLayouts.push(_loc3_);
            }
            _loc1_++;
         }
         this.m_topLevelAnchor = this;
         var _loc2_:DisplayObjectContainer = this.parent;
         while(true)
         {
            if(_loc2_ is BaseAnchor)
            {
               this.m_topLevelAnchor = BaseAnchor(_loc2_);
               _loc2_ = _loc2_.parent;
            }
            else
            {
               if(_loc2_ is ZContainer)
               {
                  break;
               }
               assert(false,"Anchor " + this + " must be connected to a ZContainer or another Anchor");
            }
         }
         
         this.m_parentContainer = ZContainer(_loc2_);
         this.m_originalPosition = new Point(this.m_topLevelAnchor.x,this.m_topLevelAnchor.y);
      }
      
      protected var m_parentContainer:ZContainer;
      
      protected var m_topLevelAnchor:BaseAnchor;
      
      protected var m_originalPosition:Point;
      
      private var m_layouts:Vector.<ILayout>;
      
      private var m_postLayouts:Vector.<IPostLayout>;
      
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
         this.m_layouts.length = 0;
         this.m_layouts = null;
         this.m_postLayouts.length = 0;
         this.m_postLayouts = null;
         this.m_parentContainer = null;
         this.m_topLevelAnchor = null;
         this.m_originalPosition = null;
         super.destroy();
      }
      
      public function doPostLayout() : void {
         var _loc1_:IPostLayout = null;
         for each (_loc1_ in this.m_postLayouts)
         {
            _loc1_.doPostLayout();
         }
      }
      
      function getTopLevelAnchorBounds(param1:DisplayObject) : Rectangle {
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
      
      override public function getBounds(param1:DisplayObject) : Rectangle {
         var _loc3_:* = 0;
         var _loc4_:DisplayObject = null;
         var _loc2_:Rectangle = new Rectangle();
         if(this.m_topLevelAnchor is DoNotIgnoreAnchor || parent is BaseAnchor)
         {
            _loc3_ = 0;
            while(_loc3_ < numChildren)
            {
               _loc4_ = getChildAt(_loc3_);
               _loc2_ = _loc2_.union(_loc4_.getBounds(param1));
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      public function doLayout() : void {
         var _loc2_:DisplayObject = null;
         if(this == this.m_topLevelAnchor)
         {
            this.m_topLevelAnchor.x = this.m_originalPosition.x;
            this.m_topLevelAnchor.y = this.m_originalPosition.y;
         }
         var _loc1_:* = 0;
         while(_loc1_ < numChildren)
         {
            _loc2_ = getChildAt(_loc1_);
            if(_loc2_ is ILayout)
            {
               ILayout(_loc2_).doLayout();
            }
            _loc1_++;
         }
      }
      
      public function getNamedInstances(param1:Object, param2:DisplayObjectContainer=null) : void {
         ZuiUtil.getNamedInstances(this,param1,param2);
      }
   }
}
