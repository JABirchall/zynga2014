package com.zynga.poker.table.asset
{
   import flash.display.Sprite;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.draw.ShinyButton;
   import com.zynga.display.SafeImageLoader;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import com.zynga.locale.LocaleManager;
   import flash.text.TextFieldAutoSize;
   import flash.events.Event;
   
   public class HSMFreeUsagePromo extends Sprite
   {
      
      public function HSMFreeUsagePromo(param1:Number, param2:Number, param3:Object) {
         super();
         this._width = param1;
         this._height = param2;
         this.setup(param3);
      }
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var titleUpperField:EmbeddedFontTextField;
      
      private var titleField:EmbeddedFontTextField;
      
      private var bodyField1:EmbeddedFontTextField;
      
      private var bodyField2:EmbeddedFontTextField;
      
      public var inviteButton:ShinyButton;
      
      private function setup(param1:Object) : void {
         var _loc2_:SafeImageLoader = null;
         _loc2_ = new SafeImageLoader();
         _loc2_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onBGLoadError,false,0,true);
         _loc2_.load(new URLRequest(param1["bgPic"]));
         this.titleUpperField = new EmbeddedFontTextField(LocaleManager.localize("flash.table.controls.hsmFreeUsagePromo.popup.titleUpper"),"MainCondensed",14,14340871,"left");
         this.titleUpperField.autoSize = TextFieldAutoSize.LEFT;
         this.titleUpperField.fitInWidth(190);
         this.titleUpperField.x = 11;
         this.titleUpperField.y = 5;
         this.titleField = new EmbeddedFontTextField(LocaleManager.localize("flash.table.controls.hsmFreeUsagePromo.popup.title"),"MainCondensed",20,16777215,"left");
         this.titleField.autoSize = TextFieldAutoSize.LEFT;
         this.titleField.fitInWidth(190);
         this.titleField.x = 11;
         this.titleField.y = 20;
         var _loc3_:* = "";
         if(param1["invited"] == 0)
         {
            _loc3_ = LocaleManager.localize("flash.table.controls.hsmFreeUsagePromo.popup.invitedText.zero");
         }
         else
         {
            _loc3_ = LocaleManager.localize("flash.table.controls.hsmFreeUsagePromo.popup.invitedText",
               {
                  "count":param1["invited"],
                  "friend":
                     {
                        "type":"tk",
                        "key":"friend",
                        "attributes":"",
                        "count":param1["invited"]
                     }
               });
         }
         this.bodyField1 = new EmbeddedFontTextField(_loc3_,"MainSemi",12,16777215,"left");
         this.bodyField1.width = this._width - 20;
         this.bodyField1.multiline = true;
         this.bodyField1.wordWrap = true;
         this.bodyField1.x = 12;
         this.bodyField1.y = 110;
         if(param1["toInvite"] == 0)
         {
            _loc3_ = LocaleManager.localize("flash.table.controls.hsmFreeUsagePromo.popup.toInviteText.zero");
         }
         else
         {
            _loc3_ = LocaleManager.localize("flash.table.controls.hsmFreeUsagePromo.popup.toInviteText",
               {
                  "count":param1["toInvite"],
                  "friend":
                     {
                        "type":"tk",
                        "key":"friend",
                        "attributes":"",
                        "count":param1["toInvite"]
                     }
               });
         }
         this.bodyField2 = new EmbeddedFontTextField(_loc3_,"MainSemi",12,16777215,"left");
         this.bodyField2.width = this._width - 20;
         this.bodyField2.multiline = true;
         this.bodyField2.wordWrap = true;
         this.bodyField2.x = 12;
         this.bodyField2.y = 124;
         this.inviteButton = new ShinyButton(LocaleManager.localize("flash.table.controls.hsmFreeUsagePromo.popup.inviteButton"),65,26);
         this.inviteButton.x = 195;
         this.inviteButton.y = 114;
         addChild(_loc2_);
         addChild(this.titleUpperField);
         addChild(this.titleField);
         addChild(this.bodyField1);
         addChild(this.bodyField2);
         addChild(this.inviteButton);
      }
      
      private function onBGLoadError(param1:Event) : void {
         graphics.beginFill(3289650,1);
         graphics.drawRect(0.0,0.0,this._width,this._height);
         graphics.endFill();
      }
   }
}
