package com.zynga.rad.buttons
{
   import com.zynga.rad.containers.IPropertiesBubbler;
   import flash.geom.Rectangle;
   import flash.display.MovieClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.DisplayObject;
   
   public class ZContainerTabButton extends ZTabButton implements IPropertiesBubbler
   {
      
      public function ZContainerTabButton() {
         super();
         assert(!(this.contentContainer == null),"ZContainerTabButton must include a contentContainer");
         this.contentContainer.mouseChildren = false;
         this.contentContainer.mouseEnabled = false;
      }
      
      private var _contentBounds:Rectangle;
      
      public var contentContainer:MovieClip;
      
      override protected function wrapStates() : void {
         if(up.backing != null)
         {
            up.backing.width = m_originalWidth;
         }
         up.width = m_originalWidth;
         if(over.backing != null)
         {
            over.backing.width = m_originalWidth;
         }
         over.width = m_originalWidth;
         if(down.backing != null)
         {
            down.backing.width = m_originalWidth;
         }
         down.width = m_originalWidth;
         if(disabled.backing != null)
         {
            disabled.backing.width = m_originalWidth;
         }
         disabled.width = m_originalWidth;
         if(selected.backing != null)
         {
            selected.backing.width = m_originalWidth;
         }
         selected.width = m_originalWidth;
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
      
      override public function set pane(param1:DisplayObject) : void {
         super.pane = param1;
      }
      
      override public function get pane() : DisplayObject {
         return super.pane;
      }
      
      override public function click() : void {
         super.click();
      }
   }
}
