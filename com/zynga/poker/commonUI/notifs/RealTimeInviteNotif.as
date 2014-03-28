package com.zynga.poker.commonUI.notifs
{
   import com.zynga.display.SafeImageLoader;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.draw.ShinyButton;
   import com.zynga.geom.Size;
   import com.zynga.locale.LocaleManager;
   import flash.text.TextFormatAlign;
   import flash.text.TextFieldAutoSize;
   import flash.events.MouseEvent;
   import com.zynga.draw.pokerUIbutton.PokerUIButton;
   import flash.geom.Point;
   import flash.events.Event;
   import flash.net.URLRequest;
   import com.zynga.draw.ComplexColorContainer;
   import flash.display.LineScaleMode;
   import flash.display.GradientType;
   import caurina.transitions.Tweener;
   import com.zynga.poker.commonUI.events.InviteUserEvent;
   import com.zynga.poker.commonUI.events.CommonVEvent;
   import com.zynga.poker.commonUI.events.CloseNotifEvent;
   
   public class RealTimeInviteNotif extends BaseNotif
   {
      
      public function RealTimeInviteNotif(param1:Object, param2:Boolean) {
         alpha = 1;
         this._data = param1;
         this._isInLobby = param2;
         this._hasBeenAddedToDisplayList = false;
         _willWaitForCallToExpand = false;
         super();
      }
      
      public static const EXPAND_UPWARD:int = 0;
      
      public static const EXPAND_DOWNWARD:int = 1;
      
      private const DEFAULT_WIDTH:Number = 232.0;
      
      private const DEFAULT_HEIGHT:Number = 60.0;
      
      private const DEFAULT_CORNER_RADIUS:Number = 6.0;
      
      private var _userImage:SafeImageLoader;
      
      private var _messageField:EmbeddedFontTextField;
      
      private var _subMessageField:EmbeddedFontTextField;
      
      private var _inviteButton:ShinyButton;
      
      private var _data:Object;
      
      private var _isInLobby:Boolean;
      
      private var _hasBeenAddedToDisplayList:Boolean;
      
      override protected function setup() : void {
         var _loc2_:String = null;
         _size = new Size(this.DEFAULT_WIDTH,this.DEFAULT_HEIGHT);
         _cornerRadius = this.DEFAULT_CORNER_RADIUS;
         _expandDirection = EXPAND_DOWNWARD;
         var _loc1_:String = LocaleManager.localize("flash.friendSelector.notifs.realTimeBuddyNamePlaceholder");
         for (_loc2_ in this._data)
         {
         }
         this._messageField = new EmbeddedFontTextField(LocaleManager.localize("flash.friendSelector.notifs.realTimeBuddyToInviteJoined",{"name":(this._data["label"]?this._data["label"]:_loc1_)}),"Main",14,16777215,TextFormatAlign.LEFT);
         this._messageField.autoSize = TextFieldAutoSize.LEFT;
         this._messageField.multiline = true;
         this._messageField.wordWrap = true;
         this._messageField.width = 116;
         this._subMessageField = new EmbeddedFontTextField(LocaleManager.localize("flash.friendSelector.notifs.realTimeInviteMessage"),"Main",12,16777215,TextFormatAlign.LEFT);
         this._subMessageField.autoSize = TextFieldAutoSize.LEFT;
         this._subMessageField.multiline = true;
         this._subMessageField.wordWrap = true;
         this._subMessageField.width = 116;
         this._inviteButton = new ShinyButton(LocaleManager.localize("flash.friendSelector.buttons.inviteButton"),48,22);
         this._inviteButton.addEventListener(MouseEvent.CLICK,this.onInviteButtonClick,false,0,true);
         if(this._isInLobby)
         {
            this.hideInvite();
         }
         _closeButton = new PokerUIButton();
         _closeButton.style = PokerUIButton.BUTTONSTYLE_LIVEJOINCLOSE;
         _closeButton.alignToPoint(new Point(_size.width - (_closeButton.width + 2),2));
         _closeButton.addEventListener(MouseEvent.CLICK,this.onCloseButtonClick,false,0,true);
         this._userImage = new SafeImageLoader("http://statics.poker.static.zynga.com/poker/www/img/ladder_default_user.png");
         this._userImage.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onUserImageLoadComplete,false,0,true);
         this._userImage.mouseEnabled = false;
         this._userImage.load(new URLRequest(this._data["source"]));
         this._userImage.alpha = 0.0;
         addChildAnimated(this._messageField);
         addChildAnimated(this._subMessageField);
         addChildAnimated(this._inviteButton);
         addChildAnimated(_closeButton);
         this.draw();
         if(height > this.defaultHeight)
         {
            this._messageField.visible = false;
            this._subMessageField.visible = false;
         }
         if(!hasEventListener(Event.ADDED))
         {
            addEventListener(Event.ADDED,this.onAddedToDisplayList,false,0,true);
         }
         if(!hasEventListener(Event.REMOVED_FROM_STAGE))
         {
            addEventListener(Event.REMOVED_FROM_STAGE,this.cleanUp,false,0,true);
         }
      }
      
      override protected function draw() : void {
         var _loc1_:ComplexColorContainer = new ComplexColorContainer();
         _loc1_.alphas = [1,1];
         _loc1_.colors = [5394769,2302755];
         _loc1_.ratios = [0,255];
         _loc1_.width = _size.width;
         _loc1_.height = _size.height;
         _loc1_.rotation = 90;
         graphics.clear();
         graphics.lineStyle(2,0,1,true,LineScaleMode.NONE);
         graphics.lineGradientStyle(GradientType.LINEAR,_loc1_.colors,_loc1_.alphas,_loc1_.ratios,_loc1_.matrix);
         graphics.beginFill(0,1);
         graphics.drawRoundRect(0.0,0.0,_size.width,_size.height,_cornerRadius,_cornerRadius);
         graphics.endFill();
         this._userImage.x = 4;
         this._userImage.y = 4;
         this._messageField.x = 58;
         this._messageField.y = 4;
         this._subMessageField.x = this._messageField.x;
         this._subMessageField.y = this._messageField.y + this._messageField.height;
         this._inviteButton.x = _size.width - (this._inviteButton.width + 7);
         this._inviteButton.y = (_size.height - this._inviteButton.height) / 2;
      }
      
      public function get defaultWidth() : Number {
         return this.DEFAULT_WIDTH;
      }
      
      public function get defaultHeight() : Number {
         return this.DEFAULT_HEIGHT;
      }
      
      public function get defaultSize() : Size {
         return new Size(this.DEFAULT_WIDTH,this.DEFAULT_HEIGHT);
      }
      
      public function set shouldWaitForCallToExpand(param1:Boolean) : void {
         _willWaitForCallToExpand = param1;
      }
      
      public function get shouldWaitForCallToExpand() : Boolean {
         return _willWaitForCallToExpand;
      }
      
      public function set expandDirection(param1:int) : void {
         _expandDirection = param1;
      }
      
      public function get expandDirection() : int {
         return _expandDirection;
      }
      
      public function get zid() : String {
         return this._data["uid"];
      }
      
      public function get data() : Object {
         return this._data;
      }
      
      public function set size(param1:Size) : void {
         var heightDifference:Number = NaN;
         var defaultDifference:Number = NaN;
         var newY:Number = NaN;
         var inSize:Size = param1;
         if(!this._hasBeenAddedToDisplayList || (_willWaitForCallToExpand))
         {
            _deferredSize = inSize;
            return;
         }
         this.draw();
         var startBlock:Function = function():void
         {
            _messageField.visible = true;
            _subMessageField.visible = true;
            draw();
         };
         var updateBlock:Function = function():void
         {
            draw();
         };
         var completionBlock:Function = function():void
         {
            draw();
         };
         Tweener.addTween(this._messageField,
            {
               "alpha":0.0,
               "time":0.5,
               "transition":"easeInQuart"
            });
         Tweener.addTween(this._subMessageField,
            {
               "alpha":0.0,
               "time":0.5,
               "transition":"easeInQuart"
            });
         if(_expandDirection == EXPAND_UPWARD)
         {
            heightDifference = Math.max(height,inSize.height) - Math.min(height,inSize.height);
            defaultDifference = height - this.defaultHeight;
            newY = y - heightDifference;
            if(defaultDifference)
            {
               newY = newY - defaultDifference;
            }
            Tweener.addTween(this,
               {
                  "y":newY,
                  "time":0.5,
                  "delay":0.5,
                  "transition":"easeInOutQuart"
               });
         }
         Tweener.addTween(_size,
            {
               "width":inSize.width,
               "height":inSize.height,
               "time":0.5,
               "delay":0.5,
               "transition":"easeInOutQuart",
               "onStart":startBlock,
               "onUpdate":updateBlock,
               "onComplete":completionBlock
            });
         Tweener.addTween(this._messageField,
            {
               "alpha":1,
               "time":0.5,
               "delay":1,
               "transition":"easeOutQuart"
            });
         Tweener.addTween(this._subMessageField,
            {
               "alpha":1,
               "time":0.5,
               "delay":1,
               "transition":"easeOutQuart"
            });
      }
      
      public function performSizeAnimation() : void {
         if(_willWaitForCallToExpand)
         {
            _willWaitForCallToExpand = false;
            if(_deferredSize)
            {
               this.size = _deferredSize;
            }
         }
      }
      
      public function hideInvite() : void {
         this._inviteButton.visible = false;
      }
      
      public function showInvite() : void {
         this._inviteButton.visible = true;
      }
      
      override public function cleanUp(param1:Event) : void {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.cleanUp);
      }
      
      private function onAddedToDisplayList(param1:Event) : void {
         removeEventListener(Event.ADDED,this.onAddedToDisplayList);
         this._hasBeenAddedToDisplayList = true;
         if(height > this.defaultHeight)
         {
            _deferredSize = new Size(_size.width,this._messageField.y + this._messageField.height + this._subMessageField.height + 18);
         }
         if(_deferredSize)
         {
            this.size = _deferredSize;
         }
      }
      
      private function onInviteButtonClick(param1:MouseEvent) : void {
         dispatchEvent(new InviteUserEvent(CommonVEvent.INVITE_USER,this._data,"notif"));
         dispatchEvent(new CloseNotifEvent(CommonVEvent.CLOSE_NOTIF,this));
      }
      
      private function onCloseButtonClick(param1:MouseEvent) : void {
         _closedByCloseButtonClick = true;
         dispatchEvent(new CloseNotifEvent(CommonVEvent.CLOSE_NOTIF,this));
      }
      
      private function onUserImageLoadComplete(param1:Event) : void {
         this._userImage.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onUserImageLoadComplete);
         var _loc2_:Number = 50;
         var _loc3_:Number = 50;
         this._userImage.width = _loc2_;
         this._userImage.height = _loc3_;
         addChildAnimated(this._userImage);
      }
   }
}
