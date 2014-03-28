package it.gotoandplay.smartfoxserver.http
{
   import flash.events.EventDispatcher;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   import flash.net.URLRequestMethod;
   import flash.events.TimerEvent;
   import flash.net.URLVariables;
   import flash.net.URLLoader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   
   public class HttpConnection extends EventDispatcher
   {
      
      public function HttpConnection() {
         this.connectTimer = new Timer(20000,1);
         super();
         this.codec = new RawProtocolCodec();
         this.urlLoaderFactory = new LoaderFactory(this.handleResponse,this.handleIOError);
      }
      
      private static const HANDSHAKE:String = "connect";
      
      private static const DISCONNECT:String = "disconnect";
      
      private static const CONN_LOST:String = "ERR#01";
      
      public static const HANDSHAKE_TOKEN:String = "#";
      
      private static const servletUrl:String = "BlueBox/HttpBox.do";
      
      private static const paramName:String = "sfsHttp";
      
      private var sessionId:String;
      
      private var connected:Boolean = false;
      
      private var ipAddr:String;
      
      private var port:int;
      
      private var webUrl:String;
      
      private var urlLoaderFactory:LoaderFactory;
      
      private var urlRequest:URLRequest;
      
      private var connectTimer:Timer;
      
      private var timedout:Boolean = false;
      
      private var codec:IHttpProtocolCodec;
      
      public function getSessionId() : String {
         return this.sessionId;
      }
      
      public function isConnected() : Boolean {
         return this.connected;
      }
      
      public function connect(param1:String, param2:int=8080, param3:int=20000) : void {
         this.ipAddr = param1;
         this.port = param2;
         this.webUrl = "http://" + this.ipAddr + ":" + this.port + "/" + servletUrl;
         this.sessionId = null;
         this.urlRequest = new URLRequest(this.webUrl);
         this.urlRequest.method = URLRequestMethod.POST;
         this.connectTimer.delay = param3;
         this.connectTimer.repeatCount = 1;
         this.connectTimer.addEventListener(TimerEvent.TIMER,this.connectTimeoutHandler);
         this.timedout = false;
         this.connectTimer.start();
         this.send(HANDSHAKE);
      }
      
      private function connectTimeoutHandler(param1:TimerEvent) : void {
         this.connectTimer.removeEventListener(TimerEvent.TIMER,this.connectTimeoutHandler);
         var _loc2_:Object = {};
         _loc2_.message = "timed out";
         this.timedout = true;
         var _loc3_:HttpEvent = new HttpEvent(HttpEvent.onHttpError,_loc2_);
         dispatchEvent(_loc3_);
      }
      
      public function close() : void {
         this.send(DISCONNECT);
         this.connected = false;
      }
      
      public function send(param1:String) : void {
         var _loc2_:URLVariables = null;
         var _loc3_:URLLoader = null;
         if((this.connected) || !this.connected && param1 == HANDSHAKE || !this.connected && param1 == "poll")
         {
            _loc2_ = new URLVariables();
            _loc2_[paramName] = this.codec.encode(this.sessionId,param1);
            this.urlRequest.data = _loc2_;
            if(param1 != "poll")
            {
            }
            _loc3_ = this.urlLoaderFactory.getLoader();
            _loc3_.data = _loc2_;
            _loc3_.load(this.urlRequest);
         }
      }
      
      private function handleResponse(param1:Event) : void {
         var _loc4_:HttpEvent = null;
         var _loc2_:URLLoader = param1.target as URLLoader;
         var _loc3_:String = _loc2_.data as String;
         var _loc5_:Object = {};
         if(_loc3_.charAt(0) == HANDSHAKE_TOKEN)
         {
            this.connectTimer.removeEventListener(TimerEvent.TIMER,this.connectTimeoutHandler);
            if(this.sessionId == null)
            {
               if(!this.timedout)
               {
                  this.sessionId = this.codec.decode(_loc3_);
                  this.connected = true;
                  _loc5_.sessionId = this.sessionId;
                  _loc5_.success = true;
                  _loc4_ = new HttpEvent(HttpEvent.onHttpConnect,_loc5_);
                  dispatchEvent(_loc4_);
               }
            }
         }
         else
         {
            if(_loc3_.indexOf(CONN_LOST) == 0)
            {
               if(!this.connected)
               {
                  return;
               }
               _loc5_.data = {};
               _loc4_ = new HttpEvent(HttpEvent.onHttpClose,_loc5_);
            }
            else
            {
               _loc5_.data = _loc3_;
               _loc4_ = new HttpEvent(HttpEvent.onHttpData,_loc5_);
            }
            dispatchEvent(_loc4_);
         }
      }
      
      private function handleIOError(param1:IOErrorEvent) : void {
         var _loc2_:Object = {};
         _loc2_.message = param1.text;
         var _loc3_:HttpEvent = new HttpEvent(HttpEvent.onHttpError,_loc2_);
         dispatchEvent(_loc3_);
      }
   }
}
