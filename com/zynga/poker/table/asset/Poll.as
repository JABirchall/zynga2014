package com.zynga.poker.table.asset
{
   import flash.display.MovieClip;
   import com.zynga.text.HtmlTextBox;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import com.zynga.poker.table.events.view.TVEPollEvent;
   import flash.geom.Matrix;
   import flash.display.GradientType;
   import com.zynga.poker.PokerClassProvider;
   import flash.filters.DropShadowFilter;
   
   public class Poll extends MovieClip
   {
      
      public function Poll(param1:String, param2:String) {
         super();
         this.id = param1;
         this.question = param2;
         var _loc3_:Matrix = new Matrix();
         _loc3_.createGradientBox(this.containerWidth,this.containerHeight,Math.PI / 2,0,0);
         graphics.lineStyle(1,5000268,1,true);
         graphics.beginGradientFill(GradientType.LINEAR,[14540253,12303291],[1,1],[0,255],_loc3_);
         graphics.drawRoundRect(0,0,this.containerWidth,this.containerHeight,10,10);
         graphics.endFill();
         var _loc4_:HtmlTextBox = new HtmlTextBox("MainSemi","POLL QUESTION",10,1657751,"left");
         _loc4_.x = this.containerPadding;
         _loc4_.y = Math.round(this.containerPadding + _loc4_.height / 2);
         addChild(_loc4_);
         this.closeButton = PokerClassProvider.getUntypedObject("PollCloseButton") as SimpleButton;
         this.closeButton.x = Math.round(this.containerWidth - this.containerPadding - this.closeButton.width);
         this.closeButton.y = this.containerPadding;
         addChild(this.closeButton);
         this.yesButton = PokerClassProvider.getUntypedObject("PollYesButton") as SimpleButton;
         this.yesButton.x = Math.round(this.containerWidth / 4 - this.yesButton.width / 2);
         this.yesButton.y = Math.round(this.containerHeight - this.containerPadding - this.yesButton.height);
         addChild(this.yesButton);
         this.noButton = PokerClassProvider.getUntypedObject("PollNoButton") as SimpleButton;
         this.noButton.x = Math.round(this.containerWidth / 4 * 3 - this.noButton.width / 2);
         this.noButton.y = Math.round(this.containerHeight - this.containerPadding - this.noButton.height);
         addChild(this.noButton);
         this.closeButton.addEventListener(MouseEvent.CLICK,this.onCloseButtonClick,false,0,true);
         this.yesButton.addEventListener(MouseEvent.CLICK,this.onYesButtonClick,false,0,true);
         this.noButton.addEventListener(MouseEvent.CLICK,this.onNoButtonClick,false,0,true);
         filters = [new DropShadowFilter(4,45,0,0.25)];
      }
      
      private var containerWidth:Number = 170;
      
      private var containerHeight:Number = 57;
      
      private var containerPadding:Number = 3;
      
      private var _id:String = "";
      
      private var _question:String = "";
      
      private var questionTextBox:HtmlTextBox = null;
      
      private var closeButton:SimpleButton = null;
      
      private var yesButton:SimpleButton = null;
      
      private var noButton:SimpleButton = null;
      
      public function get id() : String {
         return this._id;
      }
      
      public function set id(param1:String) : void {
         this._id = param1;
      }
      
      public function get question() : String {
         return this._question;
      }
      
      public function set question(param1:String) : void {
         this._question = param1;
         if(this.questionTextBox == null)
         {
            this.questionTextBox = new HtmlTextBox("MainSemi",this._question,10,0,"left",false,true,false,this.containerWidth - this.containerPadding * 2);
            this.questionTextBox.x = this.containerPadding;
            this.questionTextBox.y = 14;
            addChild(this.questionTextBox);
         }
         else
         {
            this.questionTextBox.updateText(this._question);
         }
      }
      
      private function onCloseButtonClick(param1:MouseEvent) : void {
         dispatchEvent(new TVEPollEvent(TVEPollEvent.POLL_CLOSE));
      }
      
      private function onYesButtonClick(param1:MouseEvent) : void {
         dispatchEvent(new TVEPollEvent(TVEPollEvent.POLL_YES));
      }
      
      private function onNoButtonClick(param1:MouseEvent) : void {
         dispatchEvent(new TVEPollEvent(TVEPollEvent.POLL_NO));
      }
   }
}
