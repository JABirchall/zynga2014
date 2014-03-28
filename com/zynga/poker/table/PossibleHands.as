package com.zynga.poker.table
{
   public class PossibleHands extends Object
   {
      
      public function PossibleHands() {
         super();
      }
      
      public static function run(param1:Array, param2:int=0) : String {
         var _loc9_:String = null;
         var _loc10_:* = 0;
         var _loc11_:Function = null;
         var _loc12_:Array = null;
         var _loc13_:Array = null;
         var _loc14_:* = NaN;
         var _loc15_:String = null;
         var _loc16_:String = null;
         var _loc17_:String = null;
         var _loc3_:Array = param1.concat();
         var _loc4_:Array = [checkRoyalFlush,checkStraightFlush,checkFourOfAKind,checkFullHouse,checkFlush,checkStraight,checkThreeOfAKind,checkTwoPair,checkPair,checkHighCard];
         var _loc5_:* = 0;
         var _loc6_:Array = _loc3_.concat();
         var _loc7_:* = 0;
         while(_loc7_ < _loc4_.length - param2)
         {
            if(_loc5_ == 0)
            {
               _loc11_ = _loc4_[_loc7_];
               _loc12_ = _loc3_.concat();
               _loc13_ = _loc11_(_loc12_);
               if(_loc13_[0] != 0)
               {
                  _loc5_ = _loc13_[0];
                  if(_loc5_ == -1)
                  {
                     _loc5_ = 0;
                  }
                  _loc6_ = [];
                  _loc6_ = _loc13_[1].concat();
               }
            }
            _loc7_++;
         }
         var _loc8_:String = _loc5_.toString();
         _loc6_.sortOn(["used","rank"],[Array.DESCENDING,Array.DESCENDING | Array.NUMERIC]);
         for (_loc9_ in _loc6_)
         {
            if(int(_loc9_) < 5)
            {
               _loc14_ = _loc6_[_loc9_].rank;
               _loc15_ = _loc14_.toString();
               _loc16_ = "";
               if(_loc14_ < 10)
               {
                  _loc16_ = "0";
               }
               _loc17_ = _loc16_ + _loc15_;
               _loc8_ = _loc8_ + _loc17_;
            }
         }
         _loc10_ = 0;
         while(_loc8_.length < 11)
         {
            _loc8_ = _loc8_ + "0";
            _loc10_++;
         }
         return _loc8_;
      }
      
      public static function checkHighCard(param1:Array) : Array {
         var _loc4_:String = null;
         var _loc2_:* = 2;
         var _loc3_:Array = param1.concat();
         for (_loc4_ in _loc3_)
         {
            if(_loc3_[_loc4_].rank == 1)
            {
               _loc3_[_loc4_].rank = 14;
            }
         }
         _loc3_.sortOn("rank",Array.DESCENDING | Array.NUMERIC);
         return [-1,_loc3_];
      }
      
      public static function checkPair(param1:Array) : Array {
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         var _loc9_:Object = null;
         var _loc2_:* = 2;
         var _loc3_:Array = param1.concat();
         _loc3_.sortOn("rank",Array.DESCENDING | Array.NUMERIC);
         if(_loc3_.length < _loc2_)
         {
            return [0];
         }
         var _loc4_:* = false;
         var _loc5_:Array = null;
         if(_loc3_.length >= _loc2_)
         {
            loop0:
            for (_loc6_ in _loc3_)
            {
               _loc7_ = _loc3_[_loc6_];
               for (_loc8_ in _loc3_)
               {
                  _loc9_ = _loc3_[_loc8_];
                  if(!(_loc6_ == _loc8_) && _loc7_.rank == _loc9_.rank)
                  {
                     _loc3_[_loc6_].used = 1;
                     _loc3_[_loc8_].used = 1;
                     _loc4_ = true;
                     break loop0;
                  }
               }
            }
            _loc5_ = _loc4_?[1,_loc3_]:[0];
         }
         return _loc5_;
      }
      
      public static function checkTwoPair(param1:Array) : Array {
         var _loc5_:String = null;
         var _loc6_:* = 0;
         var _loc2_:Array = null;
         var _loc3_:* = 4;
         var _loc4_:Array = param1.concat();
         for (_loc5_ in _loc4_)
         {
            if(_loc4_[_loc5_].rank == 1)
            {
               _loc4_[_loc5_].rank = 14;
            }
         }
         _loc4_.sortOn("rank",Array.DESCENDING | Array.NUMERIC);
         if(_loc4_.length < _loc3_)
         {
            return [0];
         }
         var _loc7_:* = 0;
         var _loc8_:Array = new Array(14);
         _loc6_ = 0;
         while(_loc6_ < _loc8_.length)
         {
            _loc8_[_loc6_] = [];
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc8_[_loc4_[_loc6_].rank-1].push(_loc6_);
            _loc4_[_loc6_].used = 0;
            _loc6_++;
         }
         _loc6_ = _loc8_.length-1;
         while(_loc6_ >= 0 && _loc7_ < 2)
         {
            if(_loc8_[_loc6_].length == 2)
            {
               _loc7_++;
               _loc4_[_loc8_[_loc6_][0]].used = 1;
               _loc4_[_loc8_[_loc6_][1]].used = 1;
            }
            _loc6_--;
         }
         _loc2_ = _loc7_ == 2?[2,_loc4_]:[0];
         return _loc2_;
      }
      
      public static function checkThreeOfAKind(param1:Array) : Array {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public static function checkStraight(param1:Array) : Array {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public static function checkStraightAceLow(param1:Array) : Array {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public static function checkFlush(param1:Array) : Array {
         var _loc4_:String = null;
         var _loc5_:* = false;
         var _loc6_:Array = null;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:String = null;
         var _loc12_:Object = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:String = null;
         var _loc2_:* = 5;
         var _loc3_:Array = param1.concat();
         _loc3_.sortOn("suit",Array.NUMERIC);
         if(_loc3_.length < _loc2_)
         {
            return [0];
         }
         for (_loc4_ in _loc3_)
         {
            if(_loc3_[_loc4_].rank == 1)
            {
               _loc3_[_loc4_].rank = 14;
            }
         }
         _loc5_ = false;
         _loc6_ = null;
         _loc7_ = 0;
         _loc8_ = 0;
         _loc9_ = 0;
         _loc10_ = 0;
         if(_loc3_.length >= _loc2_)
         {
            for (_loc11_ in _loc3_)
            {
               _loc12_ = _loc3_[_loc11_];
               if(_loc12_.suit == 0)
               {
                  _loc7_++;
               }
               if(_loc12_.suit == 1)
               {
                  _loc8_++;
               }
               if(_loc12_.suit == 2)
               {
                  _loc9_++;
               }
               if(_loc12_.suit == 3)
               {
                  _loc10_++;
               }
            }
            if(_loc7_ >= 5)
            {
               for (_loc13_ in _loc3_)
               {
                  if(_loc3_[_loc13_].suit == 0)
                  {
                     _loc3_[_loc13_].used = 1;
                  }
               }
            }
            if(_loc8_ >= 5)
            {
               for (_loc14_ in _loc3_)
               {
                  if(_loc3_[_loc14_].suit == 1)
                  {
                     _loc3_[_loc14_].used = 1;
                  }
               }
            }
            if(_loc9_ >= 5)
            {
               for (_loc15_ in _loc3_)
               {
                  if(_loc3_[_loc15_].suit == 2)
                  {
                     _loc3_[_loc15_].used = 1;
                  }
               }
            }
            if(_loc10_ >= 5)
            {
               for (_loc16_ in _loc3_)
               {
                  if(_loc3_[_loc16_].suit == 3)
                  {
                     _loc3_[_loc16_].used = 1;
                  }
               }
            }
            if(_loc7_ >= 5 || _loc8_ >= 5 || _loc9_ >= 5 || _loc10_ >= 5)
            {
               _loc5_ = true;
            }
            _loc6_ = _loc5_?[5,_loc3_]:[0];
         }
         return _loc6_;
      }
      
      public static function checkFullHouse(param1:Array) : Array {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public static function checkFourOfAKind(param1:Array) : Array {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public static function checkStraightFlush(param1:Array) : Array {
         var _loc4_:String = null;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:String = null;
         var _loc12_:* = false;
         var _loc13_:Object = null;
         var _loc14_:* = 0;
         var _loc15_:Array = null;
         var _loc16_:String = null;
         var _loc17_:String = null;
         var _loc18_:* = 0;
         var _loc19_:Object = null;
         var _loc20_:* = NaN;
         var _loc2_:* = 5;
         var _loc3_:Array = param1.concat();
         for (_loc4_ in _loc3_)
         {
            if(_loc3_[_loc4_].rank == 14)
            {
               _loc3_[_loc4_].rank = 1;
            }
         }
         _loc3_.sortOn("rank",Array.DESCENDING | Array.NUMERIC);
         if(_loc3_.length < _loc2_)
         {
            return [0];
         }
         var _loc5_:* = false;
         var _loc6_:Array = null;
         if(_loc3_.length >= _loc2_)
         {
            _loc7_ = 0;
            _loc8_ = 0;
            _loc9_ = 0;
            _loc10_ = 0;
            for (_loc11_ in _loc3_)
            {
               _loc13_ = _loc3_[_loc11_];
               if(_loc13_.suit == 0)
               {
                  _loc7_++;
               }
               if(_loc13_.suit == 1)
               {
                  _loc8_++;
               }
               if(_loc13_.suit == 2)
               {
                  _loc9_++;
               }
               if(_loc13_.suit == 3)
               {
                  _loc10_++;
               }
            }
            _loc12_ = false;
            if(_loc7_ >= 5 || _loc8_ >= 5 || _loc9_ >= 5 || _loc10_ >= 5)
            {
               _loc12_ = true;
            }
            if(_loc12_)
            {
               if(_loc7_ >= 5)
               {
                  _loc14_ = 0;
               }
               if(_loc8_ >= 5)
               {
                  _loc14_ = 1;
               }
               if(_loc9_ >= 5)
               {
                  _loc14_ = 2;
               }
               if(_loc10_ >= 5)
               {
                  _loc14_ = 3;
               }
               _loc15_ = new Array();
               for (_loc16_ in _loc3_)
               {
                  if(_loc3_[_loc16_].suit == _loc14_)
                  {
                     _loc15_.push(_loc3_[_loc16_]);
                  }
               }
               for (_loc17_ in _loc15_)
               {
                  _loc18_ = int(_loc17_);
                  if(_loc18_ <= Math.abs(5 - _loc15_.length) && _loc15_.length >= 5)
                  {
                     _loc19_ = _loc15_[_loc18_];
                     _loc20_ = _loc19_.rank;
                     if(_loc15_[_loc18_ + 1].rank == _loc20_-1 && _loc15_[_loc18_ + 2].rank == _loc20_ - 2 && _loc15_[_loc18_ + 3].rank == _loc20_ - 3 && _loc15_[_loc18_ + 4].rank == _loc20_ - 4)
                     {
                        _loc15_[_loc18_].used = 1;
                        _loc15_[_loc18_ + 1].used = 1;
                        _loc15_[_loc18_ + 2].used = 1;
                        _loc15_[_loc18_ + 3].used = 1;
                        _loc15_[_loc18_ + 4].used = 1;
                        _loc5_ = true;
                        break;
                     }
                  }
               }
               _loc6_ = _loc5_?[8,_loc15_]:[0];
            }
            else
            {
               _loc6_ = [0];
            }
         }
         return _loc6_;
      }
      
      public static function checkRoyalFlush(param1:Array) : Array {
         var _loc6_:String = null;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:String = null;
         var _loc12_:* = false;
         var _loc13_:Object = null;
         var _loc14_:* = 0;
         var _loc15_:Array = null;
         var _loc16_:String = null;
         var _loc17_:String = null;
         var _loc18_:* = 0;
         var _loc19_:Object = null;
         var _loc20_:* = NaN;
         var _loc2_:* = 5;
         var _loc3_:Array = param1.concat();
         _loc3_.sortOn("rank",Array.NUMERIC);
         if(_loc3_.length < _loc2_)
         {
            return [0];
         }
         var _loc4_:* = false;
         var _loc5_:Array = null;
         if(_loc3_.length >= _loc2_)
         {
            for (_loc6_ in _loc3_)
            {
               if(_loc3_[_loc6_].rank == 1)
               {
                  _loc3_[_loc6_].rank = 14;
               }
            }
            _loc7_ = 0;
            _loc8_ = 0;
            _loc9_ = 0;
            _loc10_ = 0;
            for (_loc11_ in _loc3_)
            {
               _loc13_ = _loc3_[_loc11_];
               if(_loc13_.suit == 0)
               {
                  _loc7_++;
               }
               if(_loc13_.suit == 1)
               {
                  _loc8_++;
               }
               if(_loc13_.suit == 2)
               {
                  _loc9_++;
               }
               if(_loc13_.suit == 3)
               {
                  _loc10_++;
               }
            }
            _loc12_ = false;
            if(_loc7_ >= 5 || _loc8_ >= 5 || _loc9_ >= 5 || _loc10_ >= 5)
            {
               _loc12_ = true;
            }
            if(_loc12_)
            {
               if(_loc7_ >= 5)
               {
                  _loc14_ = 0;
               }
               if(_loc8_ >= 5)
               {
                  _loc14_ = 1;
               }
               if(_loc9_ >= 5)
               {
                  _loc14_ = 2;
               }
               if(_loc10_ >= 5)
               {
                  _loc14_ = 3;
               }
               _loc15_ = new Array();
               for (_loc16_ in _loc3_)
               {
                  if(_loc3_[_loc16_].suit == _loc14_)
                  {
                     _loc15_.push(_loc3_[_loc16_]);
                  }
               }
               _loc15_.sortOn("rank",Array.NUMERIC);
               for (_loc17_ in _loc15_)
               {
                  _loc18_ = int(_loc17_);
                  if(_loc18_ <= Math.abs(5 - _loc15_.length) && _loc15_.length >= 5)
                  {
                     _loc19_ = _loc15_[_loc18_];
                     _loc20_ = _loc19_.rank;
                     if(_loc15_[_loc18_ + 1].rank == _loc20_ + 1 && _loc15_[_loc18_ + 2].rank == _loc20_ + 2 && _loc15_[_loc18_ + 3].rank == _loc20_ + 3 && _loc15_[_loc18_ + 4].rank == _loc20_ + 4 && _loc15_[_loc18_ + 4].rank == 14)
                     {
                        _loc15_[_loc18_].used = 1;
                        _loc15_[_loc18_ + 1].used = 1;
                        _loc15_[_loc18_ + 2].used = 1;
                        _loc15_[_loc18_ + 3].used = 1;
                        _loc15_[_loc18_ + 4].used = 1;
                        _loc4_ = true;
                        break;
                     }
                  }
               }
               _loc5_ = _loc4_?[9,_loc15_]:[0];
            }
            else
            {
               _loc5_ = [0];
            }
         }
         return _loc5_;
      }
   }
}
