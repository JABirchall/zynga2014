package com.zynga.poker.table
{
   import com.zynga.io.ExternalCall;
   
   public class HandStrengthProbabilityCalculator extends Object
   {
      
      public function HandStrengthProbabilityCalculator() {
         super();
      }
      
      public static var strengthMeter:Number = 0;
      
      public static var outs:int = 0;
      
      public static var outCards:Array = new Array();
      
      public static var tweaker:Number = 0;
      
      public static var lastPassHandData:Array;
      
      public static var lastHandStrength:int;
      
      public static var lastReturnedLevel:String;
      
      public static var lastPlayersCount:int;
      
      public static function calculateHandStrength(param1:Array, param2:int, param3:String, param4:int) : void {
         var _loc5_:* = NaN;
         var _loc6_:Array = null;
         var _loc7_:* = 0;
         var _loc8_:String = null;
         var _loc9_:* = NaN;
         var _loc10_:* = 0;
         if(param1.length == 2)
         {
            strengthMeter = getPreflopPercentage(param1,param4);
         }
         else
         {
            if(param1.length >= 5)
            {
               outs = getOutsCount(param1,param2,param3);
               _loc5_ = outs / (52 - param1.length);
               resetCardsUsed(param1);
               _loc6_ = new Array();
               _loc7_ = 2;
               while(_loc7_ < param1.length)
               {
                  _loc6_.push(param1[_loc7_]);
                  _loc7_++;
               }
               _loc8_ = PossibleHands.run(_loc6_);
               _loc9_ = Number(_loc8_.substr(0,1));
               _loc10_ = param2 - _loc9_;
               tweaker = 0.2 * _loc10_ + _loc5_ + (_loc10_ == 0?Number(param2) * 0.05:0);
               if(tweaker > 0.95)
               {
                  tweaker = 0.95;
               }
               strengthMeter = tweaker;
            }
         }
         if(strengthMeter < 0.01)
         {
            strengthMeter = 0.01;
         }
      }
      
      public static function calculateHandStrengthUsingLastValues() : void {
         calculateHandStrength(lastPassHandData,lastHandStrength,lastReturnedLevel,lastPlayersCount);
      }
      
      public static function saveHandStrengthLastValues(param1:Array, param2:int, param3:String, param4:int) : void {
         lastPassHandData = param1;
         lastHandStrength = param2;
         lastReturnedLevel = param3;
         lastPlayersCount = param4;
      }
      
      public static function getPreflopPercentage(param1:Array, param2:int) : Number {
         var _loc3_:Number = ExternalCall.getInstance().call("ZY.App.handStrength.getStrength",param1[0].rank,param1[1].rank,param1[0].suit == param1[1].suit,param2);
         _loc3_ = _loc3_?_loc3_:0;
         if(!(_loc3_ >= 0 && _loc3_ <= 100))
         {
            _loc3_ = 0;
         }
         return _loc3_ / 100;
      }
      
      public static function getOutsCount(param1:Array, param2:int, param3:String) : int {
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = false;
         var _loc8_:* = 0;
         var _loc9_:String = null;
         var _loc10_:Object = null;
         var _loc11_:String = null;
         var _loc12_:* = NaN;
         var _loc13_:* = false;
         var _loc14_:* = 0;
         outs = 0;
         outCards = new Array();
         if(param1.length == 7)
         {
            return outs;
         }
         var _loc4_:* = 1;
         while(_loc4_ < 53)
         {
            _loc5_ = (_loc4_-1) % 13 + 2;
            _loc6_ = int((_loc4_-1) / 13);
            resetCardsUsed(param1);
            _loc7_ = false;
            _loc8_ = 0;
            for (_loc9_ in param1)
            {
               _loc8_ = param1[_loc9_].rank;
               if(_loc8_ == 1)
               {
                  _loc8_ = 14;
               }
               if(_loc5_ == _loc8_ && _loc6_ == param1[_loc9_].suit)
               {
                  _loc7_ = true;
                  break;
               }
            }
            if(!_loc7_)
            {
               _loc10_ = new Object();
               _loc10_.suit = _loc6_;
               _loc10_.rank = _loc5_;
               _loc10_.used = 0;
               param1.push(_loc10_);
               _loc11_ = PossibleHands.run(param1,param2);
               _loc12_ = Number(_loc11_.substr(0,1));
               if(_loc12_ > param2)
               {
                  _loc13_ = false;
                  switch(_loc12_)
                  {
                     case 0:
                        break;
                     case 1:
                        if(cardExistsInSet(_loc10_.rank,param1,0,1))
                        {
                           if(cardBetterThanCommunity(_loc10_.rank,param1))
                           {
                              _loc13_ = true;
                           }
                        }
                        break;
                     case 2:
                        if(cardExistsInSet(_loc10_.rank,param1,0,1))
                        {
                           _loc14_ = int(_loc11_.substr(1,2));
                           if(_loc10_.rank == _loc14_)
                           {
                              _loc14_ = int(_loc11_.substr(5,2));
                           }
                           if(!cardExistsInSet(_loc14_,param1,0,1))
                           {
                              if(cardBetterThanCommunity(_loc10_.rank,param1))
                              {
                                 _loc13_ = true;
                              }
                           }
                           else
                           {
                              _loc13_ = true;
                           }
                        }
                        break;
                     case 3:
                        if(cardExistsInSet(_loc10_.rank,param1,0,1))
                        {
                           _loc13_ = true;
                        }
                        break;
                     case 4:
                        if(atLeastOneHoleCardInCombination(param1[0].rank,param1[1].rank,_loc11_))
                        {
                           _loc13_ = true;
                        }
                        break;
                     case 5:
                        if(atLeastOneHoleCardInCombination(param1[0].rank,param1[1].rank,_loc11_))
                        {
                           _loc13_ = true;
                        }
                        break;
                     case 6:
                        if(atLeastOneHoleCardInCombination(param1[0].rank,param1[1].rank,_loc11_))
                        {
                           _loc13_ = true;
                        }
                        break;
                     case 7:
                        if(cardExistsInSet(_loc10_.rank,param1,0,1))
                        {
                           _loc13_ = true;
                        }
                        break;
                     case 8:
                     case 9:
                        if(atLeastOneHoleCardInCombination(param1[0].rank,param1[1].rank,_loc11_))
                        {
                           _loc13_ = true;
                        }
                        break;
                  }
                  
                  if(_loc13_)
                  {
                     outCards.push(_loc10_);
                     outs++;
                  }
               }
               param1.pop();
            }
            _loc4_++;
         }
         return outs;
      }
      
      private static function cardExistsInSet(param1:int, param2:Array, param3:int, param4:int) : Boolean {
         if(param1 == 1)
         {
            param1 = 14;
         }
         var _loc5_:* = 0;
         var _loc6_:int = param3;
         while(_loc6_ <= param4)
         {
            _loc5_ = param2[_loc6_].rank;
            if(_loc5_ == 1)
            {
               _loc5_ = 14;
            }
            if(param1 == _loc5_)
            {
               return true;
            }
            _loc6_++;
         }
         return false;
      }
      
      private static function cardBetterThanCommunity(param1:int, param2:Array) : Boolean {
         if(param1 == 1)
         {
            param1 = 14;
         }
         var _loc3_:* = 0;
         var _loc4_:* = 2;
         while(_loc4_ < param2.length)
         {
            _loc3_ = param2[_loc4_].rank;
            if(_loc3_ == 1)
            {
               _loc3_ = 14;
            }
            if(param1 < _loc3_)
            {
               return false;
            }
            _loc4_++;
         }
         return true;
      }
      
      private static function resetCardsUsed(param1:Array) : void {
         var _loc2_:* = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_].rank == 1)
            {
               param1[_loc2_].rank = 14;
            }
            param1[_loc2_].used = 0;
            _loc2_++;
         }
      }
      
      private static function convertReturnResultToArray(param1:String) : Array {
         var _loc2_:* = 1;
         var _loc3_:Array = new Array();
         var _loc4_:* = 0;
         while(_loc4_ < 5)
         {
            _loc3_[_loc4_] = new Object();
            _loc3_[_loc4_].rank = int(param1.substr(_loc2_,2));
            _loc2_ = _loc2_ + 2;
            _loc4_++;
         }
         return _loc3_;
      }
      
      private static function atLeastOneHoleCardInCombination(param1:int, param2:int, param3:String) : Boolean {
         var _loc4_:Array = convertReturnResultToArray(param3);
         if((cardExistsInSet(param1,_loc4_,0,_loc4_.length-1)) || (cardExistsInSet(param2,_loc4_,0,_loc4_.length-1)))
         {
            return true;
         }
         return false;
      }
   }
}
