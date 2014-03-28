package com.zynga.rad.containers.layouts
{
   import flash.display.DisplayObject;
   
   public dynamic class SpacingData extends Object
   {
      
      public function SpacingData(param1:DisplayObject) {
         super();
         this.m_object = param1;
         this.originalX = this.m_object.x;
         this.originalY = this.m_object.y;
      }
      
      public var top:Number = 0;
      
      public var left:Number = 0;
      
      public var rightEdge:Number = 0;
      
      private var m_object:DisplayObject;
      
      public var originalWidth:Number;
      
      public var originalX:Number;
      
      public var originalY:Number;
      
      public function get object() : DisplayObject {
         return this.m_object;
      }
      
      public function destroy() : void {
         this.m_object = null;
      }
   }
}
