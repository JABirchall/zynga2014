package com.zynga.rad.containers
{
   import com.zynga.rad.BaseUI;
   import flash.display.MovieClip;
   import __AS3__.vec.Vector;
   import flash.geom.Rectangle;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.utils.getQualifiedSuperclassName;
   import com.zynga.rad.util.ZuiUtil;
   
   public dynamic class ZContainer extends BaseUI implements ILayout, IPropertiesBubbler
   {
      
      public function ZContainer() {
         var _loc3_:DisplayObject = null;
         var _loc4_:Rectangle = null;
         this.m_layouts = new Vector.<ILayout>();
         this.m_postLayouts = new Vector.<IPostLayout>();
         super();
         assert(!(this.backing == null),"ZContainer " + this + " must contain an instance names \"backing\". Make sure your class name maps correctly in the swf file! ie. farm2.ui.rad.dialogs.tooltips.GenericHoverDialog");
         var _loc1_:Rectangle = new Rectangle();
         var _loc2_:* = 0;
         while(_loc2_ < numChildren)
         {
            _loc3_ = getChildAt(_loc2_);
            if(_loc3_ is ILayout)
            {
               this.m_layouts.push(_loc3_);
            }
            if(_loc3_ is IPostLayout)
            {
               this.m_postLayouts.push(_loc3_);
            }
            if(_loc3_.name != "backing")
            {
               _loc4_ = _loc3_.getBounds(this);
               _loc1_ = _loc1_.union(_loc4_);
            }
            _loc2_++;
         }
         this.m_backingOriginalBounds = this.backing.getBounds(this);
         this.m_contentOriginalBounds = _loc1_;
         this.m_spacing = new ZContainerSpacingData();
         this.m_spacing.left = _loc1_.left - this.m_backingOriginalBounds.left;
         this.m_spacing.right = this.m_backingOriginalBounds.right - _loc1_.right;
         this.m_spacing.top = _loc1_.top - this.m_backingOriginalBounds.top;
         this.m_spacing.bottom = this.m_backingOriginalBounds.bottom - _loc1_.bottom;
      }
      
      public var backing:MovieClip;
      
      private var m_spacing:ZContainerSpacingData;
      
      private var m_layouts:Vector.<ILayout>;
      
      private var m_postLayouts:Vector.<IPostLayout>;
      
      public var scaleHorizontally:Boolean = true;
      
      public var scaleVertically:Boolean = true;
      
      private var m_backingOriginalBounds:Rectangle;
      
      private var m_contentOriginalBounds:Rectangle;
      
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
         if(this.m_layouts != null)
         {
            this.m_layouts.length = 0;
            this.m_layouts = null;
         }
         if(this.m_postLayouts != null)
         {
            this.m_postLayouts.length = 0;
            this.m_postLayouts = null;
         }
         this.m_spacing = null;
         super.destroy();
      }
      
      public function getNamedInstances(param1:Object, param2:DisplayObjectContainer=null) : void {
         var _loc5_:DisplayObject = null;
         var _loc6_:String = null;
         var _loc3_:Rectangle = new Rectangle();
         var _loc4_:* = 0;
         while(_loc4_ < numChildren)
         {
            _loc5_ = getChildAt(_loc4_);
            _loc6_ = getQualifiedSuperclassName(_loc5_);
            if(!(_loc5_.name.indexOf("instance") == 0) && !(_loc5_.name == "backing") && !(_loc5_.name == "minHeight"))
            {
               param1[_loc5_.name] = _loc5_;
               ZuiUtil.setParentDialog(_loc5_,param2);
            }
            if(_loc5_ is IPropertiesBubbler)
            {
               IPropertiesBubbler(_loc5_).getNamedInstances(param1,param2);
            }
            _loc4_++;
         }
      }
      
      public function doLayout() : void {
         var _loc1_:ILayout = null;
         var _loc2_:Rectangle = null;
         var _loc3_:Rectangle = null;
         var _loc4_:* = 0;
         var _loc5_:DisplayObject = null;
         for each (_loc1_ in this.m_layouts)
         {
            _loc1_.doLayout();
         }
         _loc2_ = new Rectangle();
         _loc4_ = 0;
         while(_loc4_ < numChildren)
         {
            _loc5_ = getChildAt(_loc4_);
            if(_loc5_.name != "backing")
            {
               _loc3_ = _loc5_.getBounds(this);
               _loc2_ = _loc2_.union(_loc3_);
            }
            _loc4_++;
         }
         if(_loc2_.width > 0 && _loc2_.height > 0)
         {
            if(this.scaleHorizontally)
            {
               this.backing.x = this.m_backingOriginalBounds.x;
               this.backing.width = this.m_spacing.left + _loc2_.width + this.m_spacing.right;
               if(this.backing.width < m_minWidth)
               {
                  this.backing.width = m_minWidth;
               }
               else
               {
                  if(this.backing.width > m_maxWidth)
                  {
                     this.backing.width = m_maxWidth;
                  }
               }
            }
            if(this.scaleVertically)
            {
               this.backing.height = this.m_spacing.top + _loc2_.height + this.m_spacing.bottom;
               if(this.backing.height < m_minHeight)
               {
                  this.backing.height = m_minHeight;
               }
               else
               {
                  if(this.backing.height > m_maxHeight)
                  {
                     this.backing.height = m_maxHeight;
                  }
               }
               this.backing.y = this.m_backingOriginalBounds.y;
            }
         }
         this.doPostLayout();
      }
      
      protected function doPostLayout() : void {
         var _loc1_:IPostLayout = null;
         for each (_loc1_ in this.m_postLayouts)
         {
            _loc1_.doPostLayout();
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
   }
}
class ZContainerSpacingData extends Object
{
   
   function ZContainerSpacingData() {
      super();
   }
   
   public var left:Number;
   
   public var right:Number;
   
   public var top:Number;
   
   public var bottom:Number;
}
