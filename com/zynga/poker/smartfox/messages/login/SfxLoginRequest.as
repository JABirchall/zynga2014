package com.zynga.poker.smartfox.messages.login
{
   import com.zynga.poker.smartfox.messages.SmartfoxRequest;
   import com.adobe.serialization.json.JSON;
   
   public class SfxLoginRequest extends SmartfoxRequest
   {
      
      public function SfxLoginRequest(param1:String) {
         super("superLogin",param1);
         this.init();
      }
      
      private var _autoJoin:Number;
      
      public function set autoJoin(param1:Number) : void {
         this._autoJoin = param1;
      }
      
      private var _autoRoom:Number;
      
      public function set autoRoom(param1:Number) : void {
         this._autoRoom = param1;
      }
      
      private var _buildVersion:int;
      
      public function set buildVersion(param1:int) : void {
         this._buildVersion = param1;
      }
      
      private var _capabilities:Number;
      
      public function set capabilities(param1:Number) : void {
         this._capabilities = param1;
      }
      
      private var _clientId:int;
      
      public function set clientId(param1:int) : void {
         this._clientId = param1;
      }
      
      private var _clientType:String;
      
      public function set clientType(param1:String) : void {
         this._clientType = param1;
      }
      
      private var _emailSubscribed:int;
      
      public function set emailSubscribed(param1:int) : void {
         this._emailSubscribed = param1;
      }
      
      private var _hideGifts:int;
      
      public function set hideGifts(param1:int) : void {
         this._hideGifts = param1;
      }
      
      private var _lobbyList:Number;
      
      public function set lobbyList(param1:Number) : void {
         this._lobbyList = param1;
      }
      
      private var _locale:String;
      
      public function set locale(param1:String) : void {
         this._locale = param1;
      }
      
      private var _newUserInstall:int;
      
      public function set newUserInstall(param1:int) : void {
         this._newUserInstall = param1;
      }
      
      private var _password:String;
      
      public function set password(param1:String) : void {
         this._password = param1;
      }
      
      public function get password() : String {
         return this._password;
      }
      
      private var _pgBuyAndSend:int;
      
      public function set pgBuyAndSend(param1:int) : void {
         this._pgBuyAndSend = param1;
      }
      
      private var _pgViewAndDisplay:int;
      
      public function set pgViewAndDisplay(param1:int) : void {
         this._pgViewAndDisplay = param1;
      }
      
      private var _phpToSfxVars:Object;
      
      public function set phpToSfxVars(param1:Object) : void {
         this._phpToSfxVars = param1;
      }
      
      private var _picLrgUrl:String;
      
      public function set picLrgUrl(param1:String) : void {
         this._picLrgUrl = param1;
      }
      
      private var _picUrl:String;
      
      public function set picUrl(param1:String) : void {
         this._picUrl = param1;
      }
      
      private var _profileUrl:String;
      
      private var _protoVersion:Number;
      
      public function set protoVersion(param1:Number) : void {
         this._protoVersion = param1;
      }
      
      private var _snId:Number;
      
      public function set snId(param1:Number) : void {
         this._snId = param1;
      }
      
      private var _tourneyState:String;
      
      public function set tourneyState(param1:String) : void {
         this._tourneyState = param1;
      }
      
      private var _unreachableProtect:int;
      
      public function set unreachableProtect(param1:int) : void {
         this._unreachableProtect = param1;
      }
      
      private var _userId:String;
      
      public function set userId(param1:String) : void {
         this._userId = param1;
      }
      
      private var _rank:int;
      
      public function set rank(param1:int) : void {
         this._rank = param1;
      }
      
      protected function init() : void {
         this._autoJoin = 1;
         this._autoRoom = 1;
         this._capabilities = 0;
         this._clientId = -1;
         this._clientType = "flash";
         this._lobbyList = 1;
         this._locale = "";
         this._newUserInstall = 0;
         this._password = "";
         this._picLrgUrl = "";
         this._picUrl = "";
         this._profileUrl = "";
         this._rank = 0;
         this._snId = 0;
         this._userId = "";
      }
      
      override public function toSfxObject() : Object {
         return 
            {
               "_cmd":command,
               "autoJoin":this._autoJoin,
               "autoRoom":this._autoRoom,
               "buildVersion":this._buildVersion,
               "capabilities":this._capabilities,
               "clientId":(this._clientId == -1?null:this._clientId),
               "clientType":this._clientType,
               "emailSubscribed":this._emailSubscribed,
               "hideGifts":this._hideGifts,
               "lobbyList":this._lobbyList,
               "locale":this._locale,
               "newUserInstall":this._newUserInstall,
               "pic_lrg_url":this._picLrgUrl,
               "pic_url":this._picUrl,
               "PGIBuyAndSend":this._pgBuyAndSend,
               "PGIViewAndDisplay":this._pgViewAndDisplay,
               "phpToSfxVars":this._phpToSfxVars,
               "profile_url":this._profileUrl,
               "protoVersion":this._protoVersion,
               "rank":this._rank,
               "sn_id":this._snId,
               "tourney_state":this._tourneyState,
               "UnreachableProtect":this._unreachableProtect,
               "user":this._userId
            };
      }
      
      public function toJsonEscapedString() : String {
         var _loc1_:String = com.adobe.serialization.json.JSON.encode(this.toSfxObject());
         return escape(_loc1_);
      }
   }
}
