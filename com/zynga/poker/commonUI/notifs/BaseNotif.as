package com.zynga.poker.commonUI.notifs
{
   import com.zynga.draw.CasinoSprite;
   import com.zynga.poker.lobby.asset.DrawFrame;
   import flash.display.MovieClip;
   import com.zynga.geom.Size;
   import com.zynga.draw.pokerUIbutton.PokerUIButton;
   import flash.geom.Point;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import com.zynga.draw.ComplexColorContainer;
   import flash.display.LineScaleMode;
   import flash.display.GradientType;
   import flash.display.DisplayObjectContainer;
   import com.zynga.poker.commonUI.events.CloseNotifEvent;
   import com.zynga.poker.commonUI.events.CommonVEvent;
   
   public class BaseNotif extends CasinoSprite
   {
      
      public function BaseNotif() {
         super();
         alpha = 0.0;
         this.setup();
      }
      
      public static const EXPAND_UPWARD:int = 0;
      
      public static const EXPAND_DOWNWARD:int = 1;
      
      private const DEFAULT_WIDTH:Number = 219.0;
      
      private const DEFAULT_HEIGHT:Number = 102.0;
      
      private const DEFAULT_HEIGHT_OFFSET:Number = 17.0;
      
      private const DEFAULT_CORNER_RADIUS:Number = 6.0;
      
      private var frame:DrawFrame;
      
      private var bg:MovieClip;
      
      protected var _size:Size;
      
      protected var _deferredSize:Size;
      
      protected var _cornerRadius:Number;
      
      protected var _expandDirection:int;
      
      protected var _willWaitForCallToExpand:Boolean;
      
      protected var _closeButton:PokerUIButton;
      
      protected var _closedByCloseButtonClick:Boolean = false;
      
      protected function setup() : void {
         this._size = new Size(this.DEFAULT_WIDTH,this.DEFAULT_HEIGHT);
         this._cornerRadius = this.DEFAULT_CORNER_RADIUS;
         this._closeButton = new PokerUIButton();
         this._closeButton.style = PokerUIButton.BUTTONSTYLE_LIVEJOINCLOSE;
         this._closeButton.alignToPoint(new Point(this._size.width - (this._closeButton.width + 2),2));
         this._closeButton.addEventListener(MouseEvent.CLICK,this.onCloseClick,false,0,true);
         addChildAnimated(this._closeButton);
         if(!hasEventListener(MouseEvent.CLICK))
         {
            addEventListener(MouseEvent.CLICK,this.onFrameClick,false,0,true);
         }
         if(!hasEventListener(Event.REMOVED_FROM_STAGE))
         {
            addEventListener(Event.REMOVED_FROM_STAGE,this.cleanUp,false,0,true);
         }
         this.draw();
      }
      
      protected function draw() : void {
         var _loc1_:ComplexColorContainer = new ComplexColorContainer();
         _loc1_.alphas = [1,1];
         _loc1_.colors = [5394769,2302755];
         _loc1_.ratios = [0,255];
         _loc1_.width = this._size.width;
         _loc1_.height = this._size.height;
         _loc1_.rotation = 90;
         graphics.clear();
         graphics.lineStyle(2,0,1,true,LineScaleMode.NONE);
         graphics.lineGradientStyle(GradientType.LINEAR,_loc1_.colors,_loc1_.alphas,_loc1_.ratios,_loc1_.matrix);
         graphics.beginFill(0,1);
         graphics.drawRoundRect(0.0,0.0,this._size.width,this._size.height,this._cornerRadius,this._cornerRadius);
         graphics.endFill();
      }
      
      public function get closedByCloseButtonClick() : Boolean {
         return this._closedByCloseButtonClick;
      }
      
      public function cleanUp(param1:Event) : void {
         this._closeButton.removeEventListener(MouseEvent.CLICK,this.onCloseClick);
         removeEventListener(MouseEvent.CLICK,this.onFrameClick);
         removeEventListener(Event.REMOVED_FROM_STAGE,this.cleanUp);
      }
      
      private function onFrameClick(param1:MouseEvent) : void {
         var _loc2_:DisplayObjectContainer = this.parent;
         _loc2_.swapChildren(this,_loc2_.getChildAt(_loc2_.numChildren-1));
      }
      
      private function onCloseClick(param1:MouseEvent) : void {
         this._closedByCloseButtonClick = true;
         dispatchEvent(new CloseNotifEvent(CommonVEvent.CLOSE_NOTIF,this));
      }
   }
}
