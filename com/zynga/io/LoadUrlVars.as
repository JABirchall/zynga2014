package com.zynga.io
{
   import flash.events.EventDispatcher;
   import flash.net.URLVariables;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLLoader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import com.zynga.events.URLEvent;
   import flash.net.navigateToURL;
   
   public class LoadUrlVars extends EventDispatcher
   {
      
      public function LoadUrlVars() {
         super();
      }
      
      public var data:String;
      
      public function loadURL(param1:String, param2:Object=null, param3:String="GET") : void {
         var _loc6_:URLVariables = null;
         var _loc7_:String = null;
         var _loc4_:URLRequest = new URLRequest(param1);
         if(param2 != null)
         {
            _loc6_ = new URLVariables();
            for (_loc7_ in param2)
            {
               _loc6_[_loc7_] = param2[_loc7_];
            }
            if(param3 == "GET")
            {
               _loc4_.method = URLRequestMethod.GET;
            }
            else
            {
               if(param3 == "POST")
               {
                  _loc4_.method = URLRequestMethod.POST;
               }
            }
            _loc4_.data = _loc6_;
         }
         var _loc5_:URLLoader = new URLLoader();
         _loc5_.addEventListener(Event.COMPLETE,this.onUrlLoaded);
         _loc5_.addEventListener(IOErrorEvent.IO_ERROR,this.onUrlError);
         _loc5_.load(_loc4_);
      }
      
      private function onUrlLoaded(param1:Event) : void {
         var _loc2_:Object = param1.target;
         this.data = _loc2_.data;
         dispatchEvent(new URLEvent(URLEvent.onLoaded,true,_loc2_.data));
      }
      
      private function onUrlError(param1:IOErrorEvent) : void {
         dispatchEvent(new URLEvent(URLEvent.onLoaded,false));
         dispatchEvent(new URLEvent(URLEvent.onIOError,false,param1.text));
      }
      
      public function navigateURL(param1:String, param2:String) : void {
         navigateToURL(new URLRequest(param1),param2);
      }
   }
}
