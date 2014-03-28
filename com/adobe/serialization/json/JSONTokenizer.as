package com.adobe.serialization.json
{
   public class JSONTokenizer extends Object
   {
      
      public function JSONTokenizer(param1:String) {
         super();
         this.jsonString = param1;
         this.loc = 0;
         this.nextChar();
      }
      
      private var obj:Object;
      
      private var jsonString:String;
      
      private var loc:int;
      
      private var ch:String;
      
      public function getNextToken() : JSONToken {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc1_:JSONToken = new JSONToken();
         this.skipIgnored();
         switch(this.ch)
         {
            case "{":
               _loc1_.type = JSONTokenType.LEFT_BRACE;
               _loc1_.value = "{";
               this.nextChar();
               break;
            case "}":
               _loc1_.type = JSONTokenType.RIGHT_BRACE;
               _loc1_.value = "}";
               this.nextChar();
               break;
            case "[":
               _loc1_.type = JSONTokenType.LEFT_BRACKET;
               _loc1_.value = "[";
               this.nextChar();
               break;
            case "]":
               _loc1_.type = JSONTokenType.RIGHT_BRACKET;
               _loc1_.value = "]";
               this.nextChar();
               break;
            case ",":
               _loc1_.type = JSONTokenType.COMMA;
               _loc1_.value = ",";
               this.nextChar();
               break;
            case ":":
               _loc1_.type = JSONTokenType.COLON;
               _loc1_.value = ":";
               this.nextChar();
               break;
            case "t":
               _loc2_ = "t" + this.nextChar() + this.nextChar() + this.nextChar();
               if(_loc2_ == "true")
               {
                  _loc1_.type = JSONTokenType.TRUE;
                  _loc1_.value = true;
                  this.nextChar();
               }
               else
               {
                  this.parseError("Expecting \'true\' but found " + _loc2_);
               }
               break;
            case "f":
               _loc3_ = "f" + this.nextChar() + this.nextChar() + this.nextChar() + this.nextChar();
               if(_loc3_ == "false")
               {
                  _loc1_.type = JSONTokenType.FALSE;
                  _loc1_.value = false;
                  this.nextChar();
               }
               else
               {
                  this.parseError("Expecting \'false\' but found " + _loc3_);
               }
               break;
            case "n":
               _loc4_ = "n" + this.nextChar() + this.nextChar() + this.nextChar();
               if(_loc4_ == "null")
               {
                  _loc1_.type = JSONTokenType.NULL;
                  _loc1_.value = null;
                  this.nextChar();
               }
               else
               {
                  this.parseError("Expecting \'null\' but found " + _loc4_);
               }
               break;
            case "\"":
               _loc1_ = this.readString();
               break;
            default:
               if((this.isDigit(this.ch)) || this.ch == "-")
               {
                  _loc1_ = this.readNumber();
               }
               else
               {
                  if(this.ch == "")
                  {
                     return null;
                  }
                  this.parseError("Unexpected " + this.ch + " encountered");
               }
         }
         
         return _loc1_;
      }
      
      private function readString() : JSONToken {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function readNumber() : JSONToken {
         var _loc1_:JSONToken = new JSONToken();
         _loc1_.type = JSONTokenType.NUMBER;
         var _loc2_:* = "";
         if(this.ch == "-")
         {
            _loc2_ = _loc2_ + "-";
            this.nextChar();
         }
         if(!this.isDigit(this.ch))
         {
            this.parseError("Expecting a digit");
         }
         if(this.ch == "0")
         {
            _loc2_ = _loc2_ + this.ch;
            this.nextChar();
            if(this.isDigit(this.ch))
            {
               this.parseError("A digit cannot immediately follow 0");
            }
         }
         else
         {
            while(this.isDigit(this.ch))
            {
               _loc2_ = _loc2_ + this.ch;
               this.nextChar();
            }
         }
         if(this.ch == ".")
         {
            _loc2_ = _loc2_ + ".";
            this.nextChar();
            if(!this.isDigit(this.ch))
            {
               this.parseError("Expecting a digit");
            }
            while(this.isDigit(this.ch))
            {
               _loc2_ = _loc2_ + this.ch;
               this.nextChar();
            }
         }
         if(this.ch == "e" || this.ch == "E")
         {
            _loc2_ = _loc2_ + "e";
            this.nextChar();
            if(this.ch == "+" || this.ch == "-")
            {
               _loc2_ = _loc2_ + this.ch;
               this.nextChar();
            }
            if(!this.isDigit(this.ch))
            {
               this.parseError("Scientific notation number needs exponent value");
            }
            while(this.isDigit(this.ch))
            {
               _loc2_ = _loc2_ + this.ch;
               this.nextChar();
            }
         }
         var _loc3_:Number = Number(_loc2_);
         if((isFinite(_loc3_)) && !isNaN(_loc3_))
         {
            _loc1_.value = _loc3_;
            return _loc1_;
         }
         this.parseError("Number " + _loc3_ + " is not valid!");
         return null;
      }
      
      private function nextChar() : String {
         return this.ch = this.jsonString.charAt(this.loc++);
      }
      
      private function skipIgnored() : void {
         this.skipWhite();
         this.skipComments();
         this.skipWhite();
      }
      
      private function skipComments() : void {
         if(this.ch == "/")
         {
            this.nextChar();
            switch(this.ch)
            {
               case "/":
                  do
                  {
                     this.nextChar();
                  }
                  while(!(this.ch == "\n") && !(this.ch == ""));
                  
                  this.nextChar();
                  break;
               case "*":
                  this.nextChar();
                  while(true)
                  {
                     if(this.ch == "*")
                     {
                        this.nextChar();
                        if(this.ch == "/")
                        {
                           break;
                        }
                     }
                     else
                     {
                        this.nextChar();
                     }
                     if(this.ch == "")
                     {
                        this.parseError("Multi-line comment not closed");
                     }
                  }
                  
                  this.nextChar();
                  break;
               default:
                  this.parseError("Unexpected " + this.ch + " encountered (expecting \'/\' or \'*\' )");
            }
            
         }
      }
      
      private function skipWhite() : void {
         while(this.isWhiteSpace(this.ch))
         {
            this.nextChar();
         }
      }
      
      private function isWhiteSpace(param1:String) : Boolean {
         return param1 == " " || param1 == "\t" || param1 == "\n";
      }
      
      private function isDigit(param1:String) : Boolean {
         return param1 >= "0" && param1 <= "9";
      }
      
      private function isHexDigit(param1:String) : Boolean {
         var _loc2_:String = param1.toUpperCase();
         return (this.isDigit(param1)) || _loc2_ >= "A" && _loc2_ <= "F";
      }
      
      public function parseError(param1:String) : void {
         throw new JSONParseError(param1,this.loc,this.jsonString);
      }
   }
}
