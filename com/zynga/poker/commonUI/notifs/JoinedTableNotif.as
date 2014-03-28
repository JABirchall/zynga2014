package com.zynga.poker.commonUI.notifs
{
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.display.SafeImageLoader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.text.TextFieldAutoSize;
   import com.zynga.locale.LocaleManager;
   
   public class JoinedTableNotif extends BaseNotif
   {
      
      public function JoinedTableNotif(param1:Object) {
         super();
         this.data = param1;
         this.ldrPic = new SafeImageLoader("http://statics.poker.static.zynga.com/poker/www/img/ladder_default_user.png");
         this.ldrPic.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onPicLoadComplete);
         this.ldrPic.mouseEnabled = false;
         this.ldrPic.load(new URLRequest(param1["source"]));
         if(param1["label"].length > 16)
         {
            param1["label"] = param1["label"].slice(0,16) + "...";
         }
         this.nameField = new EmbeddedFontTextField(param1["label"]?param1["label"]:"","Main",14,16777215);
         this.nameField.autoSize = TextFieldAutoSize.LEFT;
         this.nameField.x = 57;
         this.nameField.y = 0.0;
         addChildAnimated(this.nameField);
         this.messageField = new EmbeddedFontTextField(LocaleManager.localize("flash.friendSelector.notifs.joinedMessage"),"Main",12,16777215);
         this.messageField.x = 57;
         this.messageField.y = 19;
         addChildAnimated(this.messageField);
      }
      
      private var nameField:EmbeddedFontTextField;
      
      private var messageField:EmbeddedFontTextField;
      
      public var data:Object;
      
      public var ldrPic:SafeImageLoader;
      
      override public function cleanUp(param1:Event) : void {
         super.cleanUp(param1);
      }
      
      public function init() : void {
      }
      
      public function get zid() : String {
         return this.data["uid"];
      }
      
      private function onPicLoadComplete(param1:Event) : void {
         this.ldrPic.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onPicLoadComplete);
         var _loc2_:Number = 50;
         var _loc3_:Number = 50;
         this.ldrPic.height = _loc3_;
         this.ldrPic.width = _loc2_;
         this.ldrPic.x = 4;
         this.ldrPic.y = 4;
         addChildAnimated(this.ldrPic);
      }
   }
}
