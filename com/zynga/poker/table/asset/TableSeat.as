package com.zynga.poker.table.asset
{
   import flash.display.Sprite;
   import com.zynga.interfaces.ITableSeat;
   import flash.display.MovieClip;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.geom.Point;
   import flash.events.MouseEvent;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.locale.LocaleManager;
   import flash.text.TextFieldAutoSize;
   
   public class TableSeat extends Sprite implements ITableSeat
   {
      
      public function TableSeat() {
         super();
         this.seat = PokerClassProvider.getObject("chickletSit");
         this.seat.gotoAndStop(1);
         addChild(this.seat);
         this.seatTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.table.chicklet.sit"),"Main",20,16777215);
         this.seatTextField.autoSize = TextFieldAutoSize.LEFT;
         this.seatTextField.fitInWidth(this.seat.width);
         this.seatTextField.x = -Math.round(this.seatTextField.width / 2);
         this.seatTextField.y = -Math.round(this.seatTextField.height / 2);
         addChild(this.seatTextField);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onSitMouseDown);
         buttonMode = true;
         mouseChildren = false;
      }
      
      private var seat:MovieClip;
      
      private var seatTextField:EmbeddedFontTextField;
      
      private var _seatNumber:int = -1;
      
      public function init(param1:int, param2:Point) : void {
         this.position = param2;
         this._seatNumber = param1;
      }
      
      public function showSeat(param1:Boolean) : void {
         this.visible = param1;
      }
      
      public function get seatNumber() : int {
         return this._seatNumber;
      }
      
      public function set position(param1:Point) : void {
         this.x = param1.x;
         this.y = param1.y;
      }
      
      private function onMouseOver(param1:MouseEvent) : void {
         this.seat.gotoAndStop(2);
         this.seatTextField.fontColor = 3947580;
      }
      
      private function onMouseOut(param1:MouseEvent) : void {
         this.seat.gotoAndStop(1);
         this.seatTextField.fontColor = 16777215;
      }
      
      private function onSitMouseDown(param1:MouseEvent) : void {
         this.seat.gotoAndStop(3);
         this.seatTextField.fontColor = 0;
      }
   }
}
