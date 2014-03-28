package com.zynga.poker.table
{
   import flash.display.Sprite;
   import flash.utils.Timer;
   import flash.geom.Point;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.poker.table.events.TVEvent;
   import caurina.transitions.Tweener;
   import flash.events.Event;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import com.zynga.locale.LocaleManager;
   import flash.filters.DropShadowFilter;
   import flash.text.TextFieldAutoSize;
   import flash.events.TimerEvent;
   
   public class TableOverlay extends Sprite
   {
      
      public function TableOverlay(param1:TableView, param2:String, param3:Point=null, param4:String="", param5:String="", param6:String="") {
         super();
         this._tableViewPointer = param1;
         this._type = param2;
         this._label = param4;
         this._gender = param5;
         this._msgContent = param6;
         if(param3)
         {
            this._overlayContext = param3;
         }
         this.init();
      }
      
      public static const SPOTLIGHT:String = "TABLE_SPOTLIGHT";
      
      protected static const SPOTLIGHT_RADIUS:int = 60;
      
      protected static const OVERLAY_DURATION:int = 2500;
      
      protected static const FADE_DURATION_SEC:Number = 0.5;
      
      protected static const OVERLAY_ALPHA:Number = 0.8;
      
      protected var _tableViewPointer:TableView;
      
      protected var _type:String;
      
      protected var _overlay:Sprite;
      
      protected var _timer:Timer;
      
      protected var _overlayContext:Point;
      
      protected var _message:EmbeddedFontTextField;
      
      protected var _label:String;
      
      protected var _gender:String;
      
      protected var _msgContent:String;
      
      public function init() : void {
         this._tableViewPointer.addEventListener(TVEvent.STAND_UP,this.onReasonToClear,false,0,true);
         this._tableViewPointer.addEventListener(TVEvent.LEAVE_TABLE,this.onReasonToClear,false,0,true);
         switch(this._type)
         {
            case SPOTLIGHT:
               this.showSpotlight();
               Tweener.addTween(this._overlay,
                  {
                     "alpha":OVERLAY_ALPHA,
                     "time":FADE_DURATION_SEC,
                     "transition":"linear",
                     "onComplete":function():void
                     {
                        fadeOut();
                     }
                  });
               break;
         }
         
      }
      
      public function destroy() : void {
         this._tableViewPointer.removeEventListener(TVEvent.STAND_UP,this.onReasonToClear);
         this._tableViewPointer.removeEventListener(TVEvent.LEAVE_TABLE,this.onReasonToClear);
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
         if((this._timer) && (this._timer.running))
         {
            this._timer.stop();
         }
         this._type = null;
         this._overlay = null;
         this._timer = null;
         dispatchEvent(new Event(Event.UNLOAD));
      }
      
      protected function showSpotlight() : void {
         this._overlay = new Sprite();
         this._overlay.graphics.beginFill(0,OVERLAY_ALPHA);
         this._overlay.graphics.drawRect(0,0,760,530);
         this._overlay.graphics.endFill();
         this._overlay.name = "tableDarkOverlay";
         this._overlay.alpha = 0;
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16711680);
         _loc1_.graphics.drawCircle(0,0,SPOTLIGHT_RADIUS);
         _loc1_.graphics.endFill();
         _loc1_.name = "tableDarkOverlaySpotlight";
         _loc1_.x = this._overlayContext.x;
         _loc1_.y = this._overlayContext.y;
         this._overlay.addChild(_loc1_);
         var _loc2_:Sprite = new Sprite();
         _loc2_.x = this._overlay.x;
         _loc2_.y = this._overlay.y;
         var _loc3_:BitmapData = new BitmapData(_loc1_.width,_loc1_.height,true,16777215);
         _loc3_.draw(_loc1_,new Matrix(1,0,0,1,SPOTLIGHT_RADIUS,SPOTLIGHT_RADIUS));
         var _loc4_:Bitmap = new Bitmap(_loc3_,"auto",true);
         _loc4_.x = this._overlayContext.x - SPOTLIGHT_RADIUS;
         _loc4_.y = this._overlayContext.y - SPOTLIGHT_RADIUS;
         _loc4_.blendMode = BlendMode.ERASE;
         _loc1_.parent.removeChild(_loc1_);
         _loc2_.addChild(this._overlay);
         this._overlay.x = this._overlay.y = 0;
         _loc2_.addChild(_loc4_);
         _loc2_.blendMode = BlendMode.LAYER;
         var _loc5_:String = LocaleManager.localize("flash.lobby.playerInfo.welcomeExclamation",{"name":
            {
               "type":"tn",
               "name":this._label,
               "gender":this._gender
            }}) + "\n" + (this._msgContent == ""?LocaleManager.localize("flash.table.message.waitNextHandNoLineBreaks"):this._msgContent);
         this._message = new EmbeddedFontTextField(_loc5_,"Main",24,16769299,"center");
         var _loc6_:DropShadowFilter = new DropShadowFilter();
         _loc6_.alpha = 1;
         _loc6_.blurX = _loc6_.blurY = 3;
         _loc6_.angle = 90;
         _loc6_.distance = 2;
         _loc6_.color = 0;
         this._message.autoSize = TextFieldAutoSize.LEFT;
         this._message.fitInWidth(600);
         this._message.x = this._overlay.width / 2 - this._message.width / 2;
         this._message.y = 150;
         this._message.filters = [_loc6_];
         this._overlay.addChild(this._message);
         addChild(_loc2_);
      }
      
      protected function fadeOut() : void {
         this._timer = new Timer(OVERLAY_DURATION,1);
         this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete,false,0,true);
         this._timer.start();
      }
      
      protected function fadeOutTween() : void {
         Tweener.addTween(this._overlay,
            {
               "alpha":0,
               "time":FADE_DURATION_SEC,
               "transition":"linear",
               "onComplete":this.destroy
            });
      }
      
      protected function onTimerComplete(param1:TimerEvent) : void {
         this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         this.fadeOutTween();
      }
      
      public function onReasonToClear(param1:Event=null) : void {
         if((this._timer) && (this._timer.running))
         {
            this._timer.stop();
         }
         this.fadeOutTween();
      }
   }
}
