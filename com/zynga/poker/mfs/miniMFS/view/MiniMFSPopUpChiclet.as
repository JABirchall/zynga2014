package com.zynga.poker.mfs.miniMFS.view
{
   import flash.display.Sprite;
   import fl.controls.CheckBox;
   import flash.events.MouseEvent;
   import com.zynga.poker.mfs.miniMFS.events.MiniMFSPopUpChicletEvent;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class MiniMFSPopUpChiclet extends Sprite
   {
      
      public function MiniMFSPopUpChiclet(param1:Object=null) {
         var _loc3_:Sprite = null;
         super();
         this.playerName = param1.first_name + " " + param1.last_name;
         this.playerNameReversed = param1.last_name + " " + param1.first_name;
         this.UID = param1.zid;
         var _loc2_:* = 200;
         _loc3_ = new Sprite();
         _loc3_.graphics.beginFill(255);
         _loc3_.graphics.drawRect(0,0,_loc2_,18);
         _loc3_.graphics.endFill();
         _loc3_.visible = false;
         _loc3_.mouseEnabled = false;
         addChild(_loc3_);
         this.chicletCheckbox = new CheckBox();
         this.chicletCheckbox.textField.autoSize = TextFieldAutoSize.LEFT;
         this.chicletCheckbox.textField.height = 15;
         this.chicletCheckbox.hitArea = _loc3_;
         this.chicletCheckbox.setStyle("textFormat",new TextFormat("_sans",13,0,null,null,null,null,null,"left"));
         this.chicletCheckbox.y = 1;
         this.chicletCheckbox.label = this.playerName;
         this.chicletCheckbox.buttonMode = true;
         this.chicletCheckbox.addEventListener(MouseEvent.CLICK,this.onChicletClicked,false,0,true);
         this.chicletCheckbox.height = 15;
         this.chicletCheckbox.labelPlacement = "right";
         this.chicletCheckbox.x = 0;
         addChild(this.chicletCheckbox);
         this.selected = false;
      }
      
      private var chicletCheckbox:CheckBox = null;
      
      private var _chicletSelected:Boolean;
      
      public var playerName:String;
      
      public var playerNameReversed:String;
      
      public var UID:String;
      
      public var arrayIndex:int;
      
      public function set selected(param1:Boolean) : void {
         this._chicletSelected = param1;
         this.chicletCheckbox.selected = param1;
      }
      
      public function get selected() : Boolean {
         return this._chicletSelected;
      }
      
      private function onChicletClicked(param1:MouseEvent) : void {
         this.dispatchEvent(new MiniMFSPopUpChicletEvent(MiniMFSPopUpChicletEvent.TYPE_CLICKED));
      }
   }
}
