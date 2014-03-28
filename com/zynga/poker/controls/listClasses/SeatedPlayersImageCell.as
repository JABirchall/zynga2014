package com.zynga.poker.controls.listClasses
{
   import fl.controls.listClasses.CellRenderer;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.display.SafeImageLoader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.text.TextFieldAutoSize;
   
   public class SeatedPlayersImageCell extends CellRenderer
   {
      
      public function SeatedPlayersImageCell() {
         super();
         this.safeLoader = new SafeImageLoader("http://statics.poker.static.zynga.com/poker/www/img/ladder_default_user.png");
         this.safeLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onSafeLoaderComplete);
         addChild(this.safeLoader);
         setStyle("upSkin",CustomCellBg);
         setStyle("downSkin",CustomCellBg);
         setStyle("overSkin",CustomCellBg);
         setStyle("selectedUpSkin",CustomCellBg);
         setStyle("selectedDownSkin",CustomCellBg);
         setStyle("selectedOverSkin",CustomCellBg);
         setStyle("textOverlayAlpha",0);
         this.title = new EmbeddedFontTextField("","MainLight",10);
         this.title.autoSize = TextFieldAutoSize.LEFT;
         this.title.x = 44;
         this.title.y = 6;
         this.title.width = 100;
         this.title.multiline = true;
         this.title.wordWrap = true;
         this.title.selectable = false;
         addChild(this.title);
         useHandCursor = false;
      }
      
      private var title:EmbeddedFontTextField;
      
      private var safeLoader:SafeImageLoader;
      
      private var _source:Object;
      
      private function onSafeLoaderComplete(param1:Event) : void {
         drawNow();
      }
      
      public function get source() : Object {
         return this._source;
      }
      
      public function set source(param1:Object) : void {
         if(!param1)
         {
            param1 = "http://statics.poker.static.zynga.com/poker/www/img/ladder_default_user.png";
         }
         if(this._source != param1)
         {
            this._source = param1;
            this.safeLoader.load(param1 is String?new URLRequest(param1 as String):param1 as URLRequest);
         }
      }
      
      override protected function drawLayout() : void {
         if(data.source == null)
         {
            data.source = "http://statics.poker.static.zynga.com/poker/www/img/ladder_default_user.png";
         }
         if(data.source != null)
         {
            this.source = data.source;
         }
         var _loc1_:Number = getStyleValue("imagePadding") as Number;
         this.safeLoader.x = 10;
         this.safeLoader.y = 5;
         this.safeLoader.mouseEnabled = false;
         this.safeLoader.width = 32;
         this.safeLoader.height = 32;
         this.title.text = data.label;
         this.title.y = this.safeLoader.y + Math.round((this.safeLoader.height - this.title.height) / 2);
         textField.visible = false;
      }
   }
}
