package com.greensock.loading
{
   import com.greensock.loading.core.DisplayObjectLoader;
   import flash.events.Event;
   import flash.display.Bitmap;
   
   public class ImageLoader extends DisplayObjectLoader
   {
      
      public function ImageLoader(param1:*, param2:Object=null) {
         super(param1,param2);
         _type = "ImageLoader";
      }
      
      private static var _classActivated:Boolean;
      
      override protected function _initHandler(param1:Event) : void {
         _determineScriptAccess();
         if(!_scriptAccessDenied)
         {
            _content = Bitmap(_loader.content);
            _content.smoothing = Boolean(!(this.vars.smoothing == false));
         }
         else
         {
            _content = _loader;
         }
         super._initHandler(param1);
      }
   }
}
