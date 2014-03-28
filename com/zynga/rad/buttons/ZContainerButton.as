package com.zynga.rad.buttons
{
   import com.zynga.rad.containers.IPropertiesBubbler;
   import flash.geom.Rectangle;
   import flash.display.MovieClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.DisplayObject;
   
   public class ZContainerButton extends ZButton implements IPropertiesBubbler
   {
      
      public function ZContainerButton() {
         super();
         assert(!(this.contentContainer == null),"ZContainerButton must include a contentContainer");
         this.contentContainer.mouseChildren = false;
         this.contentContainer.mouseEnabled = false;
      }
      
      private var _contentBounds:Rectangle;
      
      public var contentContainer:MovieClip;
      
      override protected function wrapStates() : void {
         up.backing.width = m_originalWidth;
         up.width = m_originalWidth;
         over.backing.width = m_originalWidth;
         over.width = m_originalWidth;
         down.backing.width = m_originalWidth;
         down.width = m_originalWidth;
         disabled.backing.width = m_originalWidth;
         disabled.width = m_originalWidth;
         super.wrapStates();
      }
      
      public function getNamedInstances(param1:Object, param2:DisplayObjectContainer=null) : void {
         IPropertiesBubbler(this.contentContainer).getNamedInstances(param1,param2);
      }
      
      override public function destroy() : void {
         this.contentContainer = null;
         super.destroy();
      }
      
      override public function doLayout() : void {
         var _loc1_:MovieClip = null;
         this.contentContainer.doLayout();
         for each (_loc1_ in m_states)
         {
            if(!(_loc1_.backing == null) && _loc1_.backing is DisplayObject)
            {
               _loc1_.backing.width = m_originalWidth;
            }
         }
      }
   }
}
