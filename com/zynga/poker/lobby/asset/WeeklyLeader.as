package com.zynga.poker.lobby.asset
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import com.zynga.text.HtmlTextBox;
   import com.zynga.display.SafeImageLoader;
   import flash.display.Sprite;
   import com.zynga.format.PokerCurrencyFormatter;
   import com.zynga.format.StringUtility;
   import flash.net.URLRequest;
   import flash.events.Event;
   
   public class WeeklyLeader extends MovieClip
   {
      
      public function WeeklyLeader(param1:int) {
         this.picHold = new Sprite();
         super();
         addChild(this.picHold);
         var _loc2_:HtmlTextBox = new HtmlTextBox("Main",param1.toString(),15,0,"left");
         addChild(_loc2_);
         _loc2_.y = 16;
         this.nameField = new TextField();
         this.nameField.width = 85;
         this.nameField.height = 20;
         this.nameField.multiline = false;
         this.nameField.selectable = false;
         this.nameField.embedFonts = true;
         this.nameField.x = 48;
         this.nameField.y = -1;
         this.nameField.htmlText = HtmlTextBox.getHtmlString([
            {
               "font":"Main",
               "color":0,
               "size":12,
               "text":"Firstname"
            }]);
         addChild(this.nameField);
         this.chipsField = new HtmlTextBox("Main","$999.9K",12,25600,"left",true,false,false,100);
         this.chipsField.x = 48;
         this.chipsField.y = 24;
         addChild(this.chipsField);
      }
      
      public var nameField:TextField;
      
      public var chipsField:HtmlTextBox;
      
      public var ldrPic:SafeImageLoader;
      
      public var picHold:Sprite;
      
      public var thisURL:String;
      
      public function loadData(param1:String, param2:String, param3:String) : void {
         this.thisURL = param3;
         this.chipsField.updateText(PokerCurrencyFormatter.numberToCurrency(parseInt(param2),true,1,false));
         this.nameField.htmlText = HtmlTextBox.getHtmlString([
            {
               "font":"Main",
               "color":0,
               "size":12,
               "text":StringUtility.LimitString(7,param1,"...")
            }]);
         this.loadPlayerPic();
      }
      
      private function loadPlayerPic() : void {
         if(this.ldrPic != null)
         {
            if(this.picHold.contains(this.ldrPic))
            {
               this.picHold.removeChild(this.ldrPic);
            }
            this.ldrPic = null;
         }
         var _loc1_:URLRequest = new URLRequest(this.thisURL);
         this.ldrPic = new SafeImageLoader("http://statics.poker.static.zynga.com/poker/www/img/ladder_default_user.png");
         this.ldrPic.visible = false;
         this.ldrPic.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onPicLoadComplete);
         this.ldrPic.load(_loc1_);
      }
      
      private function onPicLoadComplete(param1:Event) : void {
         var _loc6_:* = NaN;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 28;
         var _loc5_:Number = 28;
         if(this.ldrPic.height > _loc5_ || this.ldrPic.width > _loc4_)
         {
            _loc6_ = 1 / Math.max(this.ldrPic.height / _loc5_,this.ldrPic.width / _loc4_);
            this.ldrPic.scaleY = this.ldrPic.scaleY * _loc6_;
            this.ldrPic.scaleX = this.ldrPic.scaleX * _loc6_;
         }
         this.ldrPic.x = 16;
         this.ldrPic.visible = true;
         this.picHold.addChild(this.ldrPic);
      }
   }
}
