package com.zynga.poker.mfs.bigMFS.view
{
   import flash.display.MovieClip;
   import fl.controls.CheckBox;
   import flash.events.MouseEvent;
   import com.zynga.poker.popups.modules.events.BigMFSPopUpChicletEvent;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class BigMFSPopUpChiclet extends MovieClip
   {
      
      public function BigMFSPopUpChiclet(param1:Object=null) {
         super();
         this.full_name = param1.first_name + " " + param1.last_name;
         this.zid = param1.zid;
         this._chicletCheckbox = new CheckBox();
         this._chicletCheckbox.textField.autoSize = TextFieldAutoSize.LEFT;
         this._chicletCheckbox.setStyle("textFormat",new TextFormat("_sans",12,0));
         this._chicletCheckbox.x = 0;
         this._chicletCheckbox.y = 0;
         this._chicletCheckbox.label = this.truncateName(this.full_name,MAX_CHICLET_DISPLAY_CHARS);
         this._chicletCheckbox.buttonMode = true;
         this._chicletCheckbox.selected = false;
         this._chicletCheckbox.labelPlacement = "right";
         this._chicletCheckbox.addEventListener(MouseEvent.CLICK,this.onChicletClicked,false,0,true);
         addChild(this._chicletCheckbox);
         this.selected = false;
      }
      
      public static var CHICLET_WIDTH:Number = 132;
      
      public static var CHICLET_HEIGHT:Number = 24;
      
      public static var MAX_CHICLET_DISPLAY_CHARS:Number = 13;
      
      private var _chicletCheckbox:CheckBox = null;
      
      public var full_name:String;
      
      public var zid:String;
      
      public var index:int;
      
      private var _chicletSelected:Boolean;
      
      public function set selected(param1:Boolean) : void {
         this._chicletCheckbox.selected = param1;
      }
      
      public function get selected() : Boolean {
         return this._chicletCheckbox.selected;
      }
      
      private function truncateName(param1:String, param2:int) : String {
         if(param1.length > param2)
         {
            return param1.slice(0,param2) + "...";
         }
         return param1;
      }
      
      private function onChicletClicked(param1:MouseEvent=null) : void {
         this.dispatchEvent(new BigMFSPopUpChicletEvent(BigMFSPopUpChicletEvent.TYPE_CLICKED));
      }
   }
}
