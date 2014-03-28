package com.zynga.poker
{
   import flash.events.EventDispatcher;
   import com.zynga.io.LoadUrlVars;
   import com.zynga.events.URLEvent;
   
   public class LoadBalancer extends EventDispatcher
   {
      
      public function LoadBalancer(param1:PokerGlobalData) {
         super();
         this.pgData = param1;
         this.nameList = new Array();
         this.ipList = new Array();
         this.maxUsersList = new Array();
         this.curUsersList = new Array();
         this.curStatusList = new Array();
         this.serverTypeList = new Array();
         this.serverLangList = new Array();
         this.idList = new Array();
         this.aServerList = new Array();
         this.portOrderList = new Array();
         this.connectionTimeoutList = new Array();
         this.pollRateList = new Array();
         this.aPrevServerId = new Array();
         this.aConnFailList = new Array();
      }
      
      public static const onServerChosen:String = "onServerChosen";
      
      public static const serverListParsed:String = "serverListParsed";
      
      private var pgData:PokerGlobalData;
      
      private var nameList:Array;
      
      private var ipList:Array;
      
      private var maxUsersList:Array;
      
      public var curUsersList:Array;
      
      private var curStatusList:Array;
      
      public var serverTypeList:Array;
      
      private var serverLangList:Array;
      
      public var idList:Array;
      
      public var aServerList:Array;
      
      private var shootoutList:Array;
      
      private var premiumShootoutList:Array;
      
      private var portOrderList:Array;
      
      private var connectionTimeoutList:Array;
      
      private var pollRateList:Array;
      
      public var aPrevServerId:Array;
      
      public var aConnFailList:Array;
      
      public var configModel:ConfigModel;
      
      private function init() : void {
         this.nameList = new Array();
         this.ipList = new Array();
         this.maxUsersList = new Array();
         this.curUsersList = new Array();
         this.curStatusList = new Array();
         this.serverTypeList = new Array();
         this.serverLangList = new Array();
         this.idList = new Array();
         this.aServerList = new Array();
         this.shootoutList = new Array();
         this.premiumShootoutList = new Array();
         this.portOrderList = new Array();
         this.connectionTimeoutList = new Array();
         this.pollRateList = new Array();
      }
      
      public function chooseBestServer() : void {
         this.getServerList();
      }
      
      public function getServerList() : void {
         this.init();
         var _loc1_:String = String(new Date().getTime());
         var _loc2_:Object = this.configModel.getFeatureConfig("user");
         var _loc3_:String = (_loc2_) && (_loc2_.userLocale)?_loc2_.userLocale:"en";
         var _loc4_:String = (_loc2_) && (_loc2_.langPref)?_loc2_.langPref:"en";
         var _loc5_:String = this.configModel.getStringForFeatureConfig("smartfox","region","");
         var _loc6_:* = "";
         var _loc7_:* = "";
         if(this.pgData.dispMode == "weekly")
         {
            _loc6_ = "tourney";
         }
         else
         {
            if(this.configModel.getIntForFeatureConfig("table","showdownRoomId"))
            {
               _loc6_ = "showdown";
            }
            else
            {
               if(this.pgData.dispMode == "tournament")
               {
                  _loc6_ = "sitngo";
               }
               else
               {
                  if(this.pgData.dispMode == "shootout" || this.configModel.getIntForFeatureConfig("shootout","shootoutId",-1) > -1)
                  {
                     _loc6_ = "shootout";
                  }
                  else
                  {
                     if(this.pgData.dispMode == "premium")
                     {
                        _loc6_ = "premium";
                     }
                  }
               }
            }
         }
         var _loc8_:Object = 
            {
               "uid":this.pgData.zid,
               "nocache":_loc1_,
               "locale":_loc3_,
               "lang":_loc4_,
               "region":_loc5_
            };
         if(_loc6_)
         {
            _loc8_["server_type"] = _loc6_;
         }
         if(_loc7_)
         {
            _loc8_["shootout_round"] = _loc7_;
         }
         _loc8_["version"] = 2;
         var _loc9_:String = this.configModel.getStringForFeatureConfig("core","server_status_path");
         if(!_loc9_)
         {
            return;
         }
         if(this.configModel.getBooleanForFeatureConfig("core","adjustCasinoList"))
         {
            _loc8_["adj"] = 1;
         }
         var _loc10_:LoadUrlVars = new LoadUrlVars();
         _loc10_.addEventListener(URLEvent.onLoaded,this.onServerStatus);
         _loc10_.loadURL(_loc9_,_loc8_);
      }
      
      private function onServerStatus(param1:URLEvent) : void {
         var _loc2_:LoadUrlVars = LoadUrlVars(param1.target);
         _loc2_.removeEventListener(URLEvent.onLoaded,this.onServerStatus);
         if(param1.bSuccess)
         {
            this.parseServerList(param1.data);
            if(!this.pgData.bUserDisconnect)
            {
               this.findBestServer();
            }
         }
         else
         {
            dispatchEvent(new LBEvent(LBEvent.serverStatusError));
         }
      }
      
      private function parseServerList(param1:String) : void {
         var _loc6_:Array = null;
         var _loc7_:* = false;
         var _loc8_:* = false;
         var _loc9_:* = false;
         var _loc10_:* = 0;
         var _loc11_:Array = null;
         var _loc2_:Array = param1.split("\n");
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_.length-1)
         {
            if(_loc2_[_loc3_].substring(0,1) != "#")
            {
               _loc6_ = _loc2_[_loc3_].split(",");
               _loc7_ = false;
               _loc8_ = false;
               _loc9_ = false;
               _loc10_ = 0;
               while(_loc10_ < _loc6_.length)
               {
                  _loc11_ = _loc6_[_loc10_].split("=");
                  if(_loc11_[0] == "ip")
                  {
                     this.ipList.push(_loc11_[1]);
                  }
                  else
                  {
                     if(_loc11_[0] == "name")
                     {
                        this.nameList.push(_loc11_[1]);
                     }
                     else
                     {
                        if(_loc11_[0] == "maxUsers")
                        {
                           this.maxUsersList.push(int(_loc11_[1]));
                        }
                        else
                        {
                           if(_loc11_[0] == "uCount")
                           {
                              this.curUsersList.push(int(_loc11_[1]));
                           }
                           else
                           {
                              if(_loc11_[0] == "status")
                              {
                                 this.curStatusList.push(_loc11_[1]);
                              }
                              else
                              {
                                 if(_loc11_[0] == "id")
                                 {
                                    this.idList.push(_loc11_[1]);
                                 }
                                 else
                                 {
                                    if(_loc11_[0] == "type")
                                    {
                                       this.serverTypeList.push(_loc11_[1]);
                                    }
                                    else
                                    {
                                       if(_loc11_[0] == "langPref")
                                       {
                                          this.serverLangList.push(_loc11_[1].toLowerCase());
                                       }
                                       else
                                       {
                                          if(_loc11_[0] == "portOrder")
                                          {
                                             this.portOrderList.push(_loc11_[1].split(":"));
                                             _loc7_ = true;
                                          }
                                          else
                                          {
                                             if(_loc11_[0] == "connectionTimeout")
                                             {
                                                this.connectionTimeoutList.push(_loc11_[1]);
                                                _loc8_ = true;
                                             }
                                             else
                                             {
                                                if(_loc11_[0] == "pollRate")
                                                {
                                                   this.pollRateList.push(_loc11_[1]);
                                                   _loc9_ = true;
                                                }
                                                else
                                                {
                                                   dispatchEvent(new LBEvent(LBEvent.serverListError));
                                                }
                                             }
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
                  _loc10_++;
               }
               if(!_loc7_)
               {
                  this.portOrderList.push([]);
               }
               if(!_loc8_)
               {
                  this.connectionTimeoutList.push(0);
               }
               if(!_loc9_)
               {
                  this.pollRateList.push(0);
               }
            }
            _loc3_++;
         }
         var _loc4_:Number = 0;
         this.aServerList = new Array();
         var _loc5_:* = 0;
         while(_loc5_ < this.ipList.length)
         {
            if((this.curStatusList[_loc5_] == "OK" || this.curStatusList[_loc5_] == "Preferred") && (this.serverTypeList[_loc5_] == "normal" || this.serverTypeList[_loc5_] == "sitngo" || this.serverTypeList[_loc5_].indexOf("special") == 0))
            {
               this.aServerList.push(
                  {
                     "label":this.nameList[_loc5_],
                     "data":this.ipList[_loc5_],
                     "id":this.idList[_loc5_],
                     "users":this.curUsersList[_loc5_],
                     "portOrder":this.portOrderList[_loc5_],
                     "connectionTimeout":this.connectionTimeoutList[_loc5_],
                     "pollRate":this.pollRateList[_loc5_]
                  });
            }
            _loc4_ = _loc4_ + Number(this.curUsersList[_loc5_]);
            _loc5_++;
         }
         this.pgData.usersOnline = _loc4_;
         dispatchEvent(new LBEvent(LBEvent.onParseServerList));
      }
      
      public function getServerIdByType(param1:String) : String {
         var _loc2_:* = 0;
         while(_loc2_ < this.serverTypeList.length)
         {
            if((this.serverTypeList[_loc2_] as String).indexOf(param1) >= 0)
            {
               return this.idList[_loc2_];
            }
            _loc2_++;
         }
         return "";
      }
      
      private function findBestServer() : void {
         var _loc3_:* = NaN;
         var _loc11_:String = null;
         var _loc12_:* = 0;
         var _loc13_:* = false;
         var _loc14_:* = 0;
         var _loc15_:* = 0;
         var _loc1_:Number = 100;
         var _loc2_:* = -1;
         var _loc4_:Object = this.configModel.getFeatureConfig("core");
         var _loc5_:Array = new Array();
         var _loc6_:Array = new Array();
         var _loc7_:Array = new Array();
         var _loc8_:Array = new Array();
         this.shootoutList = new Array();
         this.premiumShootoutList = new Array();
         var _loc9_:* = 0;
         while(_loc9_ < this.ipList.length)
         {
            if(this.pgData.dispMode == "weekly")
            {
               if(this.curStatusList[_loc9_] == "OK" && this.serverTypeList[_loc9_] == "tourney")
               {
                  _loc3_ = this.curUsersList[_loc9_] / this.maxUsersList[_loc9_] * 100;
                  if(_loc3_ <= 100 && _loc3_ <= _loc1_ && !this.checkConnFail(this.idList[_loc9_]))
                  {
                     _loc1_ = _loc3_;
                     _loc2_ = _loc9_;
                  }
               }
               if(this.curStatusList[_loc9_] == "Preferred" && this.serverTypeList[_loc9_] == "tourney")
               {
                  _loc5_.push(_loc9_);
               }
            }
            else
            {
               if(this.configModel.getIntForFeatureConfig("table","showdownRoomId"))
               {
                  if(this.curStatusList[_loc9_] == "OK" && this.serverTypeList[_loc9_] == "showdown")
                  {
                     _loc3_ = this.curUsersList[_loc9_] / this.maxUsersList[_loc9_] * 100;
                     if(_loc3_ < _loc1_ && !this.checkConnFail(this.idList[_loc9_]))
                     {
                        _loc1_ = _loc3_;
                        _loc2_ = _loc9_;
                     }
                  }
                  if(this.curStatusList[_loc9_] == "Preferred" && this.serverTypeList[_loc9_] == "showdown")
                  {
                     _loc5_.push(_loc9_);
                  }
               }
               else
               {
                  if(this.pgData.dispMode == "tournament")
                  {
                     if(this.curStatusList[_loc9_] == "OK" && this.serverTypeList[_loc9_] == "sitngo")
                     {
                        _loc3_ = this.curUsersList[_loc9_] / this.maxUsersList[_loc9_] * 100;
                        if(_loc3_ <= 100 && _loc3_ <= _loc1_ && !this.checkConnFail(this.idList[_loc9_]))
                        {
                           _loc1_ = _loc3_;
                           _loc2_ = _loc9_;
                        }
                     }
                     if(this.curStatusList[_loc9_] == "Preferred" && this.serverTypeList[_loc9_] == "sitngo")
                     {
                        _loc5_.push(_loc9_);
                     }
                  }
                  else
                  {
                     if(this.pgData.dispMode == "shootout" || this.configModel.getIntForFeatureConfig("shootout","shootoutId",-1) > -1)
                     {
                        _loc11_ = this.serverTypeList[_loc9_];
                        if(_loc11_.indexOf("shootout") === 0)
                        {
                           _loc12_ = int(_loc11_.charAt(_loc11_.length-1));
                           if(this.curStatusList[_loc9_] === "OK")
                           {
                              if(this.shootoutList[_loc12_] == undefined)
                              {
                                 this.shootoutList[_loc12_] = new Array();
                              }
                              this.shootoutList[_loc12_].push(_loc9_);
                           }
                           else
                           {
                              if(this.curStatusList[_loc9_] === "Preferred")
                              {
                                 _loc5_.push(_loc9_);
                              }
                           }
                        }
                     }
                     else
                     {
                        if(this.pgData.dispMode == "premium")
                        {
                           _loc11_ = this.serverTypeList[_loc9_];
                           if(this.curStatusList[_loc9_] == "OK" && !(_loc11_.indexOf("premium_so") == -1))
                           {
                              _loc12_ = int(_loc11_.split("premium_so")[1]);
                              if(this.premiumShootoutList[_loc12_] != undefined)
                              {
                                 this.premiumShootoutList[_loc12_].push(_loc9_);
                              }
                              else
                              {
                                 this.premiumShootoutList[_loc12_] = new Array();
                                 this.premiumShootoutList[_loc12_].push(_loc9_);
                              }
                           }
                           if(this.curStatusList[_loc9_] == "Preferred" && this.serverTypeList[_loc9_] == "premium_so")
                           {
                              _loc5_.push(_loc9_);
                           }
                        }
                        else
                        {
                           if(this.curStatusList[_loc9_] == "Preferred")
                           {
                              _loc5_.push(_loc9_);
                           }
                           else
                           {
                              if(!(this.pgData.server_type == null) && this.serverTypeList[_loc9_] == this.pgData.server_type)
                              {
                                 _loc6_.push(_loc9_);
                              }
                              else
                              {
                                 if(this.curStatusList[_loc9_] == "OK" && this.serverTypeList[_loc9_] == "normal")
                                 {
                                    if(this.serverLangList[_loc9_] == this.configModel.getStringForFeatureConfig("user","langPref"))
                                    {
                                       _loc8_.push(_loc9_);
                                    }
                                    else
                                    {
                                       if(this.serverLangList[_loc9_] == "en")
                                       {
                                          _loc7_.push(_loc9_);
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
            _loc9_++;
         }
         var _loc10_:Number = 0;
         if(_loc5_.length > 0)
         {
            _loc2_ = _loc5_[0];
         }
         else
         {
            if(_loc6_.length > 0)
            {
               _loc10_ = 0;
               while(_loc10_ < _loc6_.length)
               {
                  _loc9_ = _loc6_[_loc10_];
                  _loc3_ = this.curUsersList[_loc9_] / this.maxUsersList[_loc9_] * 100;
                  if(_loc3_ <= 100 && _loc3_ <= _loc1_ && !this.checkConnFail(this.idList[_loc9_]))
                  {
                     _loc1_ = _loc3_;
                     _loc2_ = _loc9_;
                  }
                  _loc10_++;
               }
            }
            else
            {
               if(_loc8_.length > 0)
               {
                  _loc10_ = 0;
                  while(_loc10_ < _loc8_.length)
                  {
                     _loc9_ = _loc8_[_loc10_];
                     _loc3_ = this.curUsersList[_loc9_] / this.maxUsersList[_loc9_] * 100;
                     if(_loc3_ <= 100 && _loc3_ <= _loc1_ && !this.checkConnFail(this.idList[_loc9_]))
                     {
                        _loc1_ = _loc3_;
                        _loc2_ = _loc9_;
                     }
                     _loc10_++;
                  }
                  if(_loc2_ == -1 && _loc7_.length > 0)
                  {
                     _loc10_ = 0;
                     while(_loc10_ < _loc7_.length)
                     {
                        _loc9_ = _loc7_[_loc10_];
                        _loc3_ = this.curUsersList[_loc9_] / this.maxUsersList[_loc9_] * 100;
                        if(_loc3_ <= 100 && _loc3_ <= _loc1_ && !this.checkConnFail(this.idList[_loc9_]))
                        {
                           _loc1_ = _loc3_;
                           _loc2_ = _loc9_;
                        }
                        _loc10_++;
                     }
                  }
               }
               else
               {
                  if(_loc7_.length > 0)
                  {
                     _loc10_ = 0;
                     while(_loc10_ < _loc7_.length)
                     {
                        _loc9_ = _loc7_[_loc10_];
                        _loc3_ = this.curUsersList[_loc9_] / this.maxUsersList[_loc9_] * 100;
                        if(_loc3_ <= 100 && _loc3_ <= _loc1_ && !this.checkConnFail(this.idList[_loc9_]))
                        {
                           _loc1_ = _loc3_;
                           _loc2_ = _loc9_;
                        }
                        _loc10_++;
                     }
                  }
               }
            }
         }
         if(this.pgData.joiningContact == true || this.pgData.joiningAnyTable == true || this.pgData.joinPrevServ == true)
         {
            this.pgData.joinPrevServ = false;
            _loc13_ = false;
            _loc15_ = 0;
            while(_loc15_ < this.idList.length)
            {
               if(this.idList[_loc15_] == this.pgData.newServerId)
               {
                  _loc14_ = _loc15_;
                  _loc13_ = true;
                  break;
               }
               _loc15_++;
            }
            if(_loc13_ == false)
            {
               this.pgData.joiningContact = false;
               this.pgData.joiningAnyTable = false;
               this.findBestServer();
               return;
            }
            this.pgData.serverName = this.nameList[_loc14_];
            this.pgData.ip = this.ipList[_loc14_];
            this.pgData.serverId = this.idList[_loc14_];
            if(_loc4_)
            {
               _loc4_.sZone = this.getZone(this.serverTypeList[_loc14_]);
            }
            dispatchEvent(new LBEvent(LBEvent.onServerChosen));
         }
         else
         {
            if(this.pgData.dispMode == "shootout" || this.configModel.getIntForFeatureConfig("shootout","shootoutId",-1) > -1)
            {
               _loc14_ = this.findShootoutServer();
               if(_loc14_ != -1)
               {
                  this.pgData.serverName = this.nameList[_loc14_];
                  this.pgData.ip = this.ipList[_loc14_];
                  this.pgData.serverId = this.idList[_loc14_];
                  if(_loc4_)
                  {
                     _loc4_.sZone = this.getZone(this.serverTypeList[_loc14_]);
                  }
                  dispatchEvent(new LBEvent(LBEvent.onServerChosen));
               }
               else
               {
                  dispatchEvent(new LBEvent(LBEvent.findServerError));
               }
            }
            else
            {
               if(this.pgData.dispMode == "premium")
               {
                  _loc14_ = this.findShootoutServer();
                  if(_loc14_ != -1)
                  {
                     this.pgData.serverName = this.nameList[_loc14_];
                     this.pgData.ip = this.ipList[_loc14_];
                     this.pgData.serverId = this.idList[_loc14_];
                     if(_loc4_)
                     {
                        _loc4_.sZone = this.getZone(this.serverTypeList[_loc14_]);
                     }
                     dispatchEvent(new LBEvent(LBEvent.onServerChosen));
                  }
                  else
                  {
                     dispatchEvent(new LBEvent(LBEvent.findServerError));
                  }
               }
               else
               {
                  if(_loc2_ != -1)
                  {
                     this.pgData.serverName = this.nameList[_loc2_];
                     this.pgData.ip = this.ipList[_loc2_];
                     this.pgData.serverId = this.idList[_loc2_];
                     if(_loc4_)
                     {
                        _loc4_.sZone = this.getZone(this.serverTypeList[_loc2_]);
                     }
                     dispatchEvent(new LBEvent(LBEvent.onServerChosen));
                  }
                  else
                  {
                     dispatchEvent(new LBEvent(LBEvent.findServerError));
                  }
               }
            }
         }
      }
      
      private function findShootoutServer() : int {
         var _loc2_:Array = null;
         var _loc3_:* = 0;
         var _loc6_:* = NaN;
         var _loc7_:* = 0;
         var _loc1_:Number = this.pgData.dispMode == "shootout"?this.pgData.soUser.nRound:this.pgData.soPremiumId;
         var _loc4_:Number = 100;
         var _loc5_:* = -1;
         var _loc8_:Array = this.pgData.dispMode == "shootout"?this.shootoutList:this.premiumShootoutList;
         if(_loc8_[_loc1_] != undefined)
         {
            _loc2_ = _loc8_[_loc1_];
            _loc7_ = 0;
            while(_loc7_ < _loc2_.length)
            {
               _loc3_ = _loc2_[_loc7_];
               _loc6_ = this.curUsersList[_loc3_] / this.maxUsersList[_loc3_] * 100;
               if(_loc6_ <= 100 && _loc6_ <= _loc4_ && !this.checkConnFail(this.idList[_loc3_]))
               {
                  _loc4_ = _loc6_;
                  _loc5_ = _loc3_;
               }
               _loc7_++;
            }
            if(_loc5_ != -1)
            {
               return _loc5_;
            }
         }
         var _loc9_:Number = _loc1_ + 1;
         while(_loc9_ < _loc8_.length)
         {
            if(_loc8_[_loc9_] != undefined)
            {
               _loc2_ = _loc8_[_loc9_];
               _loc7_ = 0;
               while(_loc7_ < _loc2_.length)
               {
                  _loc3_ = _loc2_[_loc7_];
                  _loc6_ = this.curUsersList[_loc3_] / this.maxUsersList[_loc3_] * 100;
                  if(_loc6_ <= 100 && _loc6_ <= _loc4_ && !this.checkConnFail(this.idList[_loc3_]))
                  {
                     _loc4_ = _loc6_;
                     _loc5_ = _loc3_;
                  }
                  _loc7_++;
               }
               if(_loc5_ != -1)
               {
                  return _loc5_;
               }
            }
            _loc9_++;
         }
         _loc9_ = _loc1_-1;
         while(_loc9_ >= 0)
         {
            if(_loc8_[_loc9_] != undefined)
            {
               _loc2_ = _loc8_[_loc9_];
               _loc7_ = 0;
               while(_loc7_ < _loc2_.length)
               {
                  _loc3_ = _loc2_[_loc7_];
                  _loc6_ = this.curUsersList[_loc3_] / this.maxUsersList[_loc3_] * 100;
                  if(_loc6_ <= 100 && _loc6_ <= _loc4_ && !this.checkConnFail(this.idList[_loc3_]))
                  {
                     _loc4_ = _loc6_;
                     _loc5_ = _loc3_;
                  }
                  _loc7_++;
               }
               if(_loc5_ != -1)
               {
                  return _loc5_;
               }
            }
            _loc9_--;
         }
         return _loc5_;
      }
      
      public function findMTTHomeServer() : String {
         var _loc3_:* = NaN;
         var _loc1_:Number = 100;
         var _loc2_:* = -1;
         var _loc4_:Array = new Array();
         var _loc5_:Array = new Array();
         var _loc6_:Array = new Array();
         var _loc7_:Array = new Array();
         var _loc8_:* = 0;
         while(_loc8_ < this.ipList.length)
         {
            if(this.curStatusList[_loc8_] == "Preferred" && this.serverTypeList[_loc8_] == "normal")
            {
               _loc4_.push(_loc8_);
            }
            else
            {
               if(this.curStatusList[_loc8_] == "OK" && this.serverTypeList[_loc8_] == "normal")
               {
                  if(this.serverLangList[_loc8_] == this.configModel.getStringForFeatureConfig("user","langPref"))
                  {
                     _loc7_.push(_loc8_);
                  }
                  else
                  {
                     if(this.serverLangList[_loc8_] == "en")
                     {
                        _loc6_.push(_loc8_);
                     }
                  }
               }
            }
            _loc8_++;
         }
         var _loc9_:Number = 0;
         if(_loc4_.length > 0)
         {
            _loc2_ = _loc4_[0];
         }
         else
         {
            if(_loc7_.length > 0)
            {
               _loc9_ = 0;
               while(_loc9_ < _loc7_.length)
               {
                  _loc8_ = _loc7_[_loc9_];
                  _loc3_ = this.curUsersList[_loc8_] / this.maxUsersList[_loc8_] * 100;
                  if(_loc3_ <= 100 && _loc3_ <= _loc1_ && !this.checkConnFail(this.idList[_loc8_]))
                  {
                     _loc1_ = _loc3_;
                     _loc2_ = _loc8_;
                  }
                  _loc9_++;
               }
               if(_loc2_ == -1 && _loc6_.length > 0)
               {
                  _loc9_ = 0;
                  while(_loc9_ < _loc6_.length)
                  {
                     _loc8_ = _loc6_[_loc9_];
                     _loc3_ = this.curUsersList[_loc8_] / this.maxUsersList[_loc8_] * 100;
                     if(_loc3_ <= 100 && _loc3_ <= _loc1_ && !this.checkConnFail(this.idList[_loc8_]))
                     {
                        _loc1_ = _loc3_;
                        _loc2_ = _loc8_;
                     }
                     _loc9_++;
                  }
               }
            }
            else
            {
               if(_loc6_.length > 0)
               {
                  _loc9_ = 0;
                  while(_loc9_ < _loc6_.length)
                  {
                     _loc8_ = _loc6_[_loc9_];
                     _loc3_ = this.curUsersList[_loc8_] / this.maxUsersList[_loc8_] * 100;
                     if(_loc3_ <= 100 && _loc3_ <= _loc1_ && !this.checkConnFail(this.idList[_loc8_]))
                     {
                        _loc1_ = _loc3_;
                        _loc2_ = _loc8_;
                     }
                     _loc9_++;
                  }
               }
            }
         }
         var _loc10_:* = "";
         if(_loc2_ != -1)
         {
            _loc10_ = this.ipList[_loc2_];
         }
         return _loc10_;
      }
      
      public function getServerType(param1:String) : String {
         var _loc2_:* = 0;
         while(_loc2_ < this.idList.length)
         {
            if(this.idList[_loc2_] == param1)
            {
               return this.serverTypeList[_loc2_];
            }
            _loc2_++;
         }
         return "";
      }
      
      public function getServerLanguage(param1:String) : String {
         var _loc2_:* = 0;
         while(_loc2_ < this.idList.length)
         {
            if(this.idList[_loc2_] == param1)
            {
               return this.serverLangList[_loc2_];
            }
            _loc2_++;
         }
         return "";
      }
      
      public function getZone(param1:String) : String {
         switch(param1)
         {
            case "normal":
               return "TexasHoldemUp";
            case "tourney":
               return "PokerTourney";
            case "sitngo":
            case "showdown":
               return "PokerSitNGo";
            case "shootout":
            case "shootout1":
            case "shootout2":
            case "shootout3":
            case "premium_so":
               return "PokerShootout";
            case "PokerMtt":
               return "TexasHoldemUp";
            default:
               if(param1.indexOf("special") == 0)
               {
                  return "TexasSpecial";
               }
               return "TexasHoldemUp";
         }
         
      }
      
      public function addPrevServerId(param1:Number) : void {
         var _loc2_:Number = this.getServerArrayIndexWithServerId(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         var _loc3_:String = this.serverTypeList[_loc2_];
         var _loc4_:Object = this.getPrevServerId(_loc3_);
         if(_loc4_ == null)
         {
            _loc4_ = new Object();
            _loc4_.serverType = _loc3_;
            _loc4_.id = param1;
            this.aPrevServerId.push(_loc4_);
         }
         else
         {
            this.updatePrevServerId(_loc3_,param1);
         }
      }
      
      public function updatePrevServerId(param1:String, param2:Number) : void {
         var _loc4_:Object = null;
         var _loc3_:* = 0;
         while(_loc3_ < this.aPrevServerId.length)
         {
            _loc4_ = this.aPrevServerId[_loc3_];
            if(_loc4_.serverType == param1)
            {
               _loc4_.id = param2;
               this.aPrevServerId[_loc3_] = _loc4_;
               return;
            }
            _loc3_++;
         }
      }
      
      public function getPrevServerId(param1:String) : Object {
         var _loc3_:Object = null;
         var _loc2_:* = 0;
         while(_loc2_ < this.aPrevServerId.length)
         {
            _loc3_ = this.aPrevServerId[_loc2_];
            if(_loc3_.serverType == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getServerArrayIndexWithServerId(param1:Number) : Number {
         var _loc2_:Number = 0;
         while(_loc2_ < this.idList.length)
         {
            if(this.idList[_loc2_] == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function getPrevServerOfType(param1:String) : Number {
         var _loc2_:Object = this.getPrevServerId(param1);
         if(_loc2_ != null)
         {
            return _loc2_.id;
         }
         return -1;
      }
      
      public function addConnFail(param1:Number) : void {
         var _loc2_:* = 0;
         while(_loc2_ < this.aConnFailList.length)
         {
            if(this.aConnFailList[_loc2_] == param1)
            {
               return;
            }
            _loc2_++;
         }
         this.aConnFailList.push(param1);
      }
      
      public function clearConnFail() : void {
         this.aConnFailList = new Array();
      }
      
      public function checkConnFail(param1:Number) : Boolean {
         var _loc2_:* = 0;
         while(_loc2_ < this.aConnFailList.length)
         {
            if(this.aConnFailList[_loc2_] == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function getPortOrder(param1:String) : Array {
         var _loc2_:* = 0;
         while(_loc2_ < this.idList.length)
         {
            if(this.idList[_loc2_] == param1)
            {
               return this.portOrderList[_loc2_];
            }
            _loc2_++;
         }
         return [];
      }
      
      public function getConnectionTimeout(param1:String) : int {
         var _loc2_:* = 0;
         while(_loc2_ < this.idList.length)
         {
            if(this.idList[_loc2_] == param1)
            {
               return this.connectionTimeoutList[_loc2_];
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function getPollRate(param1:String) : int {
         var _loc2_:* = 0;
         while(_loc2_ < this.idList.length)
         {
            if(this.idList[_loc2_] == param1)
            {
               return this.pollRateList[_loc2_];
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function getServerIdByIp(param1:String) : String {
         var _loc2_:Object = null;
         for each (_loc2_ in this.aServerList)
         {
            if(_loc2_.data == param1)
            {
               return _loc2_.id;
            }
         }
         return "";
      }
      
      public function getServerTypeByIp(param1:String) : String {
         var _loc2_:int = this.ipList.length-1;
         while(_loc2_ >= 0)
         {
            if(this.ipList[_loc2_] == param1)
            {
               return this.serverTypeList[_loc2_];
            }
            _loc2_--;
         }
         return "";
      }
      
      public function getServerIp(param1:String) : String {
         var _loc2_:Object = null;
         for each (_loc2_ in this.aServerList)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_.data;
            }
         }
         return "";
      }
      
      public function getServerName(param1:String) : String {
         var _loc2_:Object = null;
         for each (_loc2_ in this.aServerList)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_.label;
            }
         }
         return "";
      }
      
      public function getServerNameByIp(param1:String) : String {
         var _loc2_:Object = null;
         for each (_loc2_ in this.aServerList)
         {
            if(_loc2_.data == param1)
            {
               return _loc2_.label;
            }
         }
         return "";
      }
   }
}
