package it.gotoandplay.smartfoxserver.http
{
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   
   public class LoaderFactory extends Object
   {
      
      public function LoaderFactory(param1:Function, param2:Function, param3:int=2) {
         super();
         this.responseHandler = param1;
         this.errorHandler = param2;
      }
      
      private static const DEFAULT_POOL_SIZE:int = 2;
      
      private var currentLoaderIndex:int;
      
      private var responseHandler:Function;
      
      private var errorHandler:Function;
      
      public function getLoader() : URLLoader {
         var _loc1_:URLLoader = new URLLoader();
         _loc1_.dataFormat = URLLoaderDataFormat.TEXT;
         _loc1_.addEventListener(Event.COMPLETE,this.responseHandler);
         _loc1_.addEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
         _loc1_.addEventListener(IOErrorEvent.NETWORK_ERROR,this.errorHandler);
         return _loc1_;
      }
   }
}
