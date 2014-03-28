package com.zynga.poker.table.asset
{
   import flash.display.MovieClip;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.text.TextFieldAutoSize;
   
   public class TableInfo extends MovieClip
   {
      
      public function TableInfo(param1:String="", param2:String="") {
         super();
         this.blindsTextField = new EmbeddedFontTextField("","Calibri",10,16777215);
         this.blindsTextField.autoSize = TextFieldAutoSize.LEFT;
         addChild(this.blindsTextField);
         this.serverAndTableTextField = new EmbeddedFontTextField("","Calibri",10,16777215);
         this.serverAndTableTextField.autoSize = TextFieldAutoSize.LEFT;
         addChild(this.serverAndTableTextField);
         if(param1)
         {
            this.blinds = param1;
         }
         if(param2)
         {
            this.serverAndTable = param2;
         }
      }
      
      private var blindsTextField:EmbeddedFontTextField;
      
      private var serverAndTableTextField:EmbeddedFontTextField;
      
      private var _blinds:String = "";
      
      private var _serverAndTable:String = "";
      
      public function get blinds() : String {
         return this._blinds;
      }
      
      public function set blinds(param1:String) : void {
         this._blinds = param1;
         this.blindsTextField.text = this._blinds;
         this.repositionText();
      }
      
      public function get serverAndTable() : String {
         return this._serverAndTable;
      }
      
      public function set serverAndTable(param1:String) : void {
         this._serverAndTable = param1;
         this.serverAndTableTextField.text = this._serverAndTable;
         this.repositionText();
      }
      
      private function repositionText() : void {
         this.serverAndTableTextField.x = -Math.round(this.serverAndTableTextField.width);
         this.serverAndTableTextField.y = -Math.round(this.serverAndTableTextField.height);
         this.blindsTextField.x = -Math.round(this.blindsTextField.width);
         this.blindsTextField.y = this.serverAndTableTextField.y - Math.round(this.blindsTextField.textHeight);
      }
   }
}
