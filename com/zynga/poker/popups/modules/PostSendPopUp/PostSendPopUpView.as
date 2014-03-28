package com.zynga.poker.popups.modules.PostSendPopUp
{
   import flash.display.MovieClip;
   import com.zynga.display.SafeImageLoader;
   import flash.display.Sprite;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.poker.PokerClassProvider;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import flash.net.URLRequest;
   import caurina.transitions.Tweener;
   
   public class PostSendPopUpView extends MovieClip
   {
      
      public function PostSendPopUpView(param1:int, param2:String, param3:String, param4:Number, param5:String) {
         super();
         this.requestSentCounter = param1;
         this.postSendText = param2;
         this.imageUrl = param3;
         this.scale = param4;
         this._closeButtonClassName = param5 != null?param5:"GenericCloseButton";
         this.setupRequestSentContainer();
      }
      
      public var requestSentCounter:int = 0;
      
      public var postSendText:String = "";
      
      public var imageUrl:String = "";
      
      public var scale:Number = 0;
      
      public var requestSentContainer:MovieClip = null;
      
      public var toasterImageLoader:SafeImageLoader = null;
      
      private var _closeButtonClassName:String;
      
      public function setupRequestSentContainer() : void {
         var _loc1_:Sprite = null;
         var _loc2_:MovieClip = null;
         var _loc3_:EmbeddedFontTextField = null;
         var _loc4_:* = NaN;
         if(this.requestSentCounter)
         {
            this.requestSentContainer = new MovieClip();
            addChild(this.requestSentContainer);
            _loc1_ = new Sprite();
            _loc1_.graphics.beginFill(0);
            _loc1_.graphics.drawRoundRect(0,475,235,92,10,10);
            _loc1_.graphics.endFill();
            this.requestSentContainer.addChildAt(_loc1_,0);
            _loc2_ = PokerClassProvider.getObject(this._closeButtonClassName);
            _loc2_.x = 215 - 4;
            _loc2_.y = 475 + 1;
            _loc2_.buttonMode = true;
            _loc2_.addEventListener(MouseEvent.CLICK,this.onRequestSentCloseButtonClicked,false,0,true);
            this.requestSentContainer.addChild(_loc2_);
            _loc3_ = new EmbeddedFontTextField("","MainSemi",12,16777215,"center");
            _loc4_ = 160;
            _loc3_.x = 65;
            _loc3_.y = 500;
            _loc3_.fitInWidth(_loc4_);
            _loc3_.width = _loc4_;
            _loc3_.wordWrap = true;
            _loc3_.text = this.postSendText.replace(new RegExp("{friends}"),this.requestSentCounter);
            this.requestSentContainer.addChild(_loc3_);
            if(this.imageUrl)
            {
               this.toasterImageLoader = new SafeImageLoader();
               this.toasterImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onToasterImageLoadComplete,false,0,true);
               this.toasterImageLoader.load(new URLRequest(this.imageUrl));
            }
            else
            {
               _loc3_.x = _loc3_.x - 30;
            }
            Tweener.addTween(this.requestSentContainer,
               {
                  "alpha":0.0,
                  "time":2,
                  "delay":5,
                  "transition":"easeOutSine",
                  "onComplete":this.onRequestSentCloseButtonClicked
               });
         }
      }
      
      public function onRequestSentCloseButtonClicked(param1:MouseEvent=null) : void {
         removeChild(this.requestSentContainer);
         this.requestSentContainer = null;
      }
      
      public function onToasterImageLoadComplete(param1:Event) : void {
         this.toasterImageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onToasterImageLoadComplete);
         this.toasterImageLoader.x = 0 + 15;
         this.toasterImageLoader.y = 475 + 20 + 5;
         this.toasterImageLoader.scaleX = this.scale;
         this.toasterImageLoader.scaleY = this.scale;
         this.requestSentContainer.addChild(this.toasterImageLoader);
      }
   }
}
