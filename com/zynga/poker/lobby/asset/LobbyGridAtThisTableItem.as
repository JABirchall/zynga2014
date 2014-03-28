package com.zynga.poker.lobby.asset
{
   import flash.display.Sprite;
   import com.zynga.display.SafeImageLoader;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.text.TextFieldAutoSize;
   
   public class LobbyGridAtThisTableItem extends Sprite
   {
      
      public function LobbyGridAtThisTableItem(param1:String, param2:String, param3:String) {
         super();
         this.url = param1;
         this.playerName = param2;
         this.chipStack = param3;
      }
      
      private var picLoader:SafeImageLoader;
      
      private var playerNameTextField:EmbeddedFontTextField;
      
      private var chipStackTextField:EmbeddedFontTextField;
      
      private var _url:String;
      
      private var _playerName:String;
      
      private var _chipStack:String;
      
      public function get url() : String {
         return this._url;
      }
      
      public function set url(param1:String) : void {
         if(this._url != param1)
         {
            this._url = param1;
            if(this.picLoader == null)
            {
               this.picLoader = new SafeImageLoader();
               this.picLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onPicLoaderComplete);
               this.picLoader.x = 15;
               this.picLoader.y = 15;
               addChild(this.picLoader);
            }
            if(this._url)
            {
               this.picLoader.load(new URLRequest(this._url));
            }
         }
      }
      
      public function get playerName() : String {
         return this._playerName;
      }
      
      public function set playerName(param1:String) : void {
         if(this._playerName != param1)
         {
            this._playerName = param1;
            if(this.playerNameTextField == null)
            {
               this.playerNameTextField = new EmbeddedFontTextField(this._playerName,"MainLight",10,16777215);
               this.playerNameTextField.autoSize = TextFieldAutoSize.LEFT;
               this.playerNameTextField.y = 70;
               addChild(this.playerNameTextField);
            }
            else
            {
               this.playerNameTextField.text = this._playerName;
            }
            this.playerNameTextField.x = 40 - Math.round(this.playerNameTextField.width / 2);
         }
      }
      
      public function get chipStack() : String {
         return this._chipStack;
      }
      
      public function set chipStack(param1:String) : void {
         if(this._chipStack != param1)
         {
            this._chipStack = param1;
            if(this.chipStackTextField == null)
            {
               this.chipStackTextField = new EmbeddedFontTextField(this._chipStack,"MainLight",10,16777215);
               this.chipStackTextField.autoSize = TextFieldAutoSize.LEFT;
               this.chipStackTextField.y = this.playerNameTextField?this.playerNameTextField.y + this.playerNameTextField.textHeight:70;
               addChild(this.chipStackTextField);
            }
            else
            {
               this.chipStackTextField.text = this._chipStack;
            }
            this.chipStackTextField.x = 40 - Math.round(this.chipStackTextField.width / 2);
         }
      }
      
      private function onPicLoaderComplete(param1:Event) : void {
         this.picLoader.width = 50;
         this.picLoader.height = 50;
      }
   }
}
