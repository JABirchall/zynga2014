package com.zynga.poker.table.shouts.views
{
   import com.zynga.poker.table.shouts.views.common.ShoutBaseView;
   import com.zynga.display.SafeAssetLoader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import com.zynga.poker.PokerGlobalData;
   
   public class ShoutBasicView extends ShoutBaseView
   {
      
      public function ShoutBasicView(param1:String, param2:Object=null, param3:int=4, param4:int=42) {
         this.PIC_BASE_URL = PokerGlobalData.instance.staticUrlPrefix + "img/shouts/";
         super(param3,param4);
         this._swfUrl = this.PIC_BASE_URL + param1 + this.PIC_TYPE;
         this._swfVars = param2;
         this.loadShoutSWF();
      }
      
      public static const SHOUT_TYPE:int = 4;
      
      public static const SHOUT_CLOSE_TIMEOUT_IN_SECONDS:int = 42;
      
      private const PIC_BASE_URL:String;
      
      private const PIC_TYPE:String = ".swf";
      
      protected var _loader:SafeAssetLoader;
      
      private var _swfUrl:String;
      
      protected var _swfContentName:String;
      
      protected var _swfVars:Object;
      
      private function loadShoutSWF() : void {
         this._loader = new SafeAssetLoader();
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onShoutSWFLoaded,false,0,true);
         this._loader.load(new URLRequest(this._swfUrl));
      }
      
      private function onShoutSWFLoaded(param1:Event) : void {
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onShoutSWFLoaded);
         this._swfContentName = this._loader.content.name;
         this._loader.content.y = (SHOUT_HEIGHT - this._loader.contentLoaderInfo.height) / 2;
         shoutContainer.addChild(this._loader.content);
         this.assetsComplete();
      }
      
      override protected function assetsComplete() : void {
         ready = true;
         super.assetsComplete();
      }
   }
}
