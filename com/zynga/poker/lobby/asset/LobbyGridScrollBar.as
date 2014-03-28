package com.zynga.poker.lobby.asset
{
   import fl.controls.ScrollBar;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class LobbyGridScrollBar extends ScrollBar
   {
      
      public function LobbyGridScrollBar() {
         super();
      }
      
      private var clickCapture:Sprite;
      
      private var _obj:Object;
      
      public function addParentReference(param1:Object) : void {
         this._obj = param1;
         this.clickCapture = new Sprite();
         this.clickCapture.graphics.beginFill(0,0.0);
         this.clickCapture.graphics.drawRect(-1000,-1000,2000,2000);
         this.clickCapture.graphics.endFill();
         this.clickCapture.visible = false;
         this.clickCapture.addEventListener(MouseEvent.MOUSE_OUT,this.killScrollAction);
         this._obj.addChild(this.clickCapture);
      }
      
      override protected function thumbPressHandler(param1:MouseEvent) : void {
         super.thumbPressHandler(param1);
         this.createClickCapture();
      }
      
      override protected function thumbReleaseHandler(param1:MouseEvent) : void {
         super.thumbReleaseHandler(param1);
         this.destroyClickCapture();
         dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP,param1.bubbles,param1.cancelable,param1.localX,param1.localY,param1.relatedObject,param1.ctrlKey,param1.altKey,param1.shiftKey,param1.buttonDown,param1.delta));
      }
      
      private function killScrollAction(param1:MouseEvent) : void {
         this.thumbReleaseHandler(new MouseEvent(MouseEvent.MOUSE_UP));
      }
      
      private function createClickCapture() : void {
         this.clickCapture.visible = true;
      }
      
      private function destroyClickCapture() : void {
         this.clickCapture.visible = false;
      }
   }
}
