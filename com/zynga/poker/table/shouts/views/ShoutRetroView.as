package com.zynga.poker.table.shouts.views
{
   import com.zynga.poker.table.shouts.views.common.ShoutBaseView;
   import com.zynga.draw.ShinyButton;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.display.SafeAssetLoader;
   import com.zynga.io.ExternalCall;
   import caurina.transitions.Tweener;
   import flash.events.MouseEvent;
   import com.zynga.poker.PokerStageManager;
   import flash.net.URLRequest;
   import flash.events.Event;
   import flash.display.DisplayObject;
   import com.zynga.poker.PokerGlobalData;
   
   public class ShoutRetroView extends ShoutBaseView
   {
      
      public function ShoutRetroView(param1:String, param2:String, param3:String, param4:String) {
         super(SHOUT_TYPE,SHOUT_TIMEOUT_IN_SECONDS);
         this._retroSubType = param1;
         this._title = param2;
         this._picUrl = param3;
         this._buttonText = param4;
         backgroundImageUrl = PokerGlobalData.instance.staticUrlPrefix + "img/popup-achievement-bg.gif";
      }
      
      public static const SHOUT_TYPE:int = 2;
      
      public static const SHOUT_TIMEOUT_IN_SECONDS:int = 0;
      
      private static const SHOUT_BG_HEIGHT:int = 189;
      
      private var _shoutActionBtn:ShinyButton;
      
      private var _shoutTitle:EmbeddedFontTextField;
      
      private var _shoutPicUrl:SafeAssetLoader;
      
      private var _retroSubType:String;
      
      private var _title:String;
      
      private var _picUrl:String;
      
      private var _buttonText:String;
      
      override protected function createForegroundAssets() : void {
         this.createTitle();
         this.createPic();
      }
      
      override public function close() : void {
         ExternalCall.getInstance().call("ZY.App.Shouts.close",this._retroSubType,true);
         Tweener.addTween(this,
            {
               "y":this.y + SHOUT_BG_HEIGHT,
               "time":1,
               "onComplete":onCloseComplete
            });
      }
      
      override public function open() : void {
         this.y = stage.stageHeight;
         this.x = 0;
         Tweener.addTween(this,
            {
               "y":y - SHOUT_BG_HEIGHT,
               "time":1
            });
      }
      
      public function onActionBtnClick(param1:MouseEvent) : void {
         PokerStageManager.hideFullScreenMode();
         ExternalCall.getInstance().call("ZY.App.Shouts.onActionBtnClick",this._retroSubType);
         this.close();
      }
      
      public function createTitle() : void {
         this._shoutTitle = new EmbeddedFontTextField(this._title,"Main",14,16777215,"left",true);
         this._shoutTitle.fitInWidth(185);
         this._shoutTitle.width = 185;
         this._shoutTitle.y = 5;
         this._shoutTitle.x = 7;
         this._shoutTitle.mouseEnabled = false;
         this._shoutTitle.selectable = false;
         addChild(this._shoutTitle);
      }
      
      public function createActionBtn() : void {
         this._shoutActionBtn = new ShinyButton(this._buttonText,90,27,14,16777215,ShinyButton.COLOR_LIGHT_GREEN,"Main",true,5,3,3);
         this._shoutActionBtn.buttonMode = true;
         this._shoutActionBtn.x = 68;
         this._shoutActionBtn.y = 157;
         this._shoutActionBtn.addEventListener(MouseEvent.CLICK,this.onActionBtnClick,false,0,true);
         addChild(this._shoutActionBtn);
      }
      
      public function createPic() : void {
         var _loc1_:URLRequest = new URLRequest(this._picUrl);
         this._shoutPicUrl = new SafeAssetLoader();
         this._shoutPicUrl.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onPicUrlLoadComplete,false,0,true);
         this._shoutPicUrl.load(_loc1_);
      }
      
      public function onPicUrlLoadComplete(param1:Event) : void {
         this._shoutPicUrl.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onPicUrlLoadComplete);
         this._shoutPicUrl.x = 0;
         this._shoutPicUrl.y = 30;
         var _loc2_:DisplayObject = getChildAt(0);
         _loc2_.height = SHOUT_BG_HEIGHT;
         _loc2_.width = 238;
         _loc2_ = getChildAt(1);
         _loc2_.x = _loc2_.x + 4;
         _loc2_.y = _loc2_.y - 4;
         addChild(this._shoutPicUrl);
         this.createActionBtn();
         assetsComplete();
      }
      
      override public function destroy() : void {
         this._shoutPicUrl = null;
         this._shoutTitle = null;
         this._shoutActionBtn = null;
         this._title = null;
         this._picUrl = null;
         this._buttonText = null;
         this._retroSubType = null;
         super.destroy();
      }
   }
}
