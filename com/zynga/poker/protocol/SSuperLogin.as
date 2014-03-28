package com.zynga.poker.protocol
{
   import com.adobe.serialization.json.JSON;
   
   public class SSuperLogin extends Object
   {
      
      public function SSuperLogin(param1:String, param2:String, param3:String, param4:Number, param5:String, param6:Number, param7:Number, param8:String, param9:int, param10:Number, param11:Number, param12:Number, param13:String, param14:String, param15:String, param16:int, param17:int, param18:int, param19:int, param20:int, param21:Object, param22:int, param23:int) {
         super();
         this.userId = param1;
         this.pass = param13;
         this.zone = param14;
         var _loc24_:Object = 
            {
               "user":this.userId,
               "pic_url":param2,
               "rank":this._userRank,
               "pic_lrg_url":param3,
               "sn_id":param4,
               "profile_url":"",
               "tourneyState":param5,
               "protoVersion":param6,
               "capabilities":param7,
               "clientType":param8,
               "clientId":param9,
               "autoRoom":param10,
               "autoJoin":param11,
               "lobbyList":param12,
               "locale":param15,
               "hideGifts":param16,
               "PGIBuyAndSend":param17,
               "PGIViewAndDisplay":param18,
               "newUserInstall":param19,
               "emailSubscribed":param20,
               "phpToSfxVars":param21,
               "buildVersion":param22,
               "UnreachableProtect":param23
            };
         if((_loc24_.hasOwnProperty("clientId")) && _loc24_["clientId"] == -1)
         {
            _loc24_["clientId"] = null;
         }
         var _loc25_:String = com.adobe.serialization.json.JSON.encode(_loc24_);
         this.props_JSON_ESC = escape(_loc25_);
      }
      
      public var userId:String;
      
      public var pass:String;
      
      public var zone:String;
      
      public var props_JSON_ESC:String;
      
      private var _userRank:int = 0;
   }
}
