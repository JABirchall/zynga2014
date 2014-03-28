package com.zynga.poker.lobby
{
   import flash.display.MovieClip;
   import com.zynga.display.SafeImageLoader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class BuzzSlide extends MovieClip
   {
      
      public function BuzzSlide(param1:String, param2:String, param3:String, param4:Number) {
         super();
         buttonMode = param2?true:false;
         mouseChildren = false;
         this.imageUrl = param1;
         this.linkUrl = param2;
         this.linkTarget = param3;
         this.duration = param4;
         this.imageLoader = new SafeImageLoader();
         this.imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onImageLoaderComplete);
         this.imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onImageLoaderIOError);
         this.imageLoader.load(new URLRequest(param1));
         addChild(this.imageLoader);
      }
      
      public var imageUrl:String;
      
      public var linkUrl:String;
      
      public var linkTarget:String;
      
      public var duration:Number;
      
      public var slideID:String;
      
      public var imageLoader:SafeImageLoader;
      
      private var _loaded:Boolean = false;
      
      private function onImageLoaderComplete(param1:Event) : void {
         this._loaded = true;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function onImageLoaderIOError(param1:Event) : void {
      }
      
      public function get loaded() : Boolean {
         return this._loaded;
      }
   }
}
