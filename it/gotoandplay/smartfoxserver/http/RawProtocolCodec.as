package it.gotoandplay.smartfoxserver.http
{
   public class RawProtocolCodec extends Object implements IHttpProtocolCodec
   {
      
      public function RawProtocolCodec() {
         super();
      }
      
      private static const SESSION_ID_LEN:int = 32;
      
      public function encode(param1:String, param2:String) : String {
         return (param1 == null?"":param1) + param2;
      }
      
      public function decode(param1:String) : String {
         var _loc2_:String = null;
         if(param1.charAt(0) == HttpConnection.HANDSHAKE_TOKEN)
         {
            _loc2_ = param1.substr(1,SESSION_ID_LEN);
         }
         return _loc2_;
      }
   }
}
