package ZLocalization
{
   import Engine.Interfaces.ILocalizer;
   import ZLocalization.conjugator.IConjugator;
   import ZLocalization.substituter.ISubstituter;
   import Engine.Interfaces.ILocale;
   import Engine.Interfaces.ILocalizerContext;
   
   public class FastLocalizer extends Object implements ILocalizer
   {
      
      public function FastLocalizer(param1:StringPackage) {
         this.pointer = new StringPointer();
         super();
         this.stringPackage = param1;
         this.replacementOrders = {};
      }
      
      private static const WHITESPACE:RegExp;
      
      private static const EMPTY_STRING:String = "";
      
      private static const OPEN_BRACE:String = "{";
      
      private static const CLOSE_BRACE:String = "}";
      
      private static const UNDERSCORE:String = "_";
      
      private static const NEWLINE_KEY:String = "nl";
      
      private static const NEWLINE:String = "\n";
      
      private static const VARIATION:String = "_v#";
      
      private static const SPACE:String = " ";
      
      private static const ARTICLES:Array;
      
      private static const GENDERS:Array;
      
      private static const SINGULAR:String = "singular";
      
      private static const PLURAL:String = "plural";
      
      public static const NO_COUNT:int = -2147483648;
      
      private var pointer:StringPointer;
      
      private var _conjugator:IConjugator;
      
      private var _substituter:ISubstituter;
      
      private var stringPackage:StringPackage;
      
      private var replacementOrders:Object;
      
      public function get strings() : StringPackage {
         return this.stringPackage;
      }
      
      public function get locale() : ILocale {
         return this.stringPackage.locale;
      }
      
      public function get localeCode() : String {
         return this.locale.code;
      }
      
      public function get language() : String {
         return this.locale.language;
      }
      
      public function get conjugator() : IConjugator {
         return this._conjugator;
      }
      
      public function set conjugator(param1:IConjugator) : void {
         this._conjugator = param1;
      }
      
      public function get substituter() : ISubstituter {
         return this._substituter;
      }
      
      public function set substituter(param1:ISubstituter) : void {
         this._substituter = param1;
      }
      
      public function context(param1:String) : ILocalizerContext {
         return new LocalizerContext(this,param1);
      }
      
      public function createName(param1:String, param2:String="masc") : LocalizerToken {
         return this.name(param1,param2);
      }
      
      public function createSilent(param1:String="masc") : LocalizerToken {
         return this.silent(param1);
      }
      
      public function createToken(param1:String, param2:String, param3:String="", param4:int=-2.147483648E9) : LocalizerToken {
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc5_:LocalizerToken = this.token(param1,param2,param4);
         if((param3) && !(param3 == ""))
         {
            _loc6_ = param3.split(",");
            for each (_loc7_ in _loc6_)
            {
               if(ARTICLES.indexOf(_loc7_) >= 0)
               {
                  _loc5_.article = _loc7_;
               }
               else
               {
                  if(GENDERS.indexOf(_loc7_) >= 0)
                  {
                     _loc5_.gender = _loc7_;
                  }
                  else
                  {
                     if(_loc7_ == SINGULAR && param4 == NO_COUNT)
                     {
                        _loc5_.plural = SINGULAR;
                     }
                     else
                     {
                        if(_loc7_ == PLURAL && param4 == NO_COUNT)
                        {
                           _loc5_.plural = PLURAL;
                        }
                     }
                  }
               }
            }
         }
         return _loc5_;
      }
      
      public function exists(param1:String, param2:String) : Boolean {
         var _loc3_:StringBundle = this.stringPackage.get(param1);
         return (_loc3_) && (_loc3_.strings.hasOwnProperty(param2));
      }
      
      public function silent(param1:String) : LocalizerToken {
         var _loc2_:LocalizerToken = new LocalizerToken();
         _loc2_.value = "";
         _loc2_.gender = param1;
         return _loc2_;
      }
      
      public function name(param1:Object, param2:String) : LocalizerToken {
         var _loc3_:LocalizerToken = param1 as LocalizerToken;
         if(!_loc3_)
         {
            _loc3_ = new LocalizerToken();
            _loc3_.value = param1;
         }
         _loc3_.gender = param2;
         return _loc3_;
      }
      
      public function token(param1:String, param2:String, param3:int=-2.147483648E9) : LocalizerToken {
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc4_:LocalizerToken = new LocalizerToken();
         _loc4_.context = param1;
         _loc4_.key = param2;
         _loc4_.count = param3;
         var _loc5_:StringBundle = this.stringPackage.get(param1);
         if(_loc5_.defaultAttributes.hasOwnProperty(_loc4_.key))
         {
            _loc6_ = _loc5_.defaultAttributes[_loc4_.key];
            for (_loc7_ in _loc6_)
            {
               if(_loc7_ != "object")
               {
                  _loc4_[_loc7_] = _loc6_[_loc7_];
               }
            }
         }
         return _loc4_;
      }
      
      public function getString(param1:LocalizerToken, param2:int, param3:String, param4:String, param5:String) : String {
         var _loc6_:StringBundle = null;
         var _loc7_:StringBundle = null;
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         var _loc10_:Object = null;
         var _loc11_:String = null;
         var _loc12_:Object = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:String = null;
         var _loc17_:String = null;
         var _loc18_:String = null;
         var _loc19_:String = null;
         var _loc20_:String = null;
         var _loc21_:* = 0;
         var _loc22_:String = null;
         var _loc23_:String = null;
         var _loc24_:String = null;
         var _loc25_:String = null;
         var _loc26_:String = null;
         var _loc27_:String = null;
         var _loc28_:String = null;
         var _loc29_:String = null;
         var _loc30_:String = null;
         var _loc31_:String = null;
         var _loc32_:String = null;
         var _loc33_:String = null;
         var _loc34_:String = null;
         var _loc35_:String = null;
         var _loc36_:String = null;
         var _loc37_:String = null;
         if((!param1.value) && (param1.context) && (param1.key))
         {
            _loc6_ = this.stringPackage.get(param1.context);
            _loc7_ = this.stringPackage.get(param5);
            _loc8_ = _loc6_.strings;
            if((_loc7_.defaultAttributes.hasOwnProperty(param3)) && (_loc7_.defaultAttributes[param3].hasOwnProperty(param4)))
            {
               _loc12_ = _loc7_.defaultAttributes[param3][param4];
               for (_loc13_ in _loc12_)
               {
                  param1[_loc13_] = _loc12_[_loc13_];
               }
            }
            _loc9_ = {};
            if(_loc6_.defaultAttributes.hasOwnProperty(param1.key))
            {
               _loc9_ = _loc6_.defaultAttributes[param1.key];
               for (_loc14_ in _loc9_)
               {
                  if(_loc14_ != "object")
                  {
                     param1[_loc14_] = _loc9_[_loc14_];
                  }
               }
            }
            if(param1.count == NO_COUNT && !_loc9_.count && param1.plural == "")
            {
               param1.plural = "plural";
            }
            if((_loc7_.cases.hasOwnProperty(param3)) && (_loc7_.cases[param3].hasOwnProperty(param4)))
            {
               param1.index = param2;
               _loc15_ = param1.encode();
               _loc16_ = param1.article;
               param1.article = "";
               _loc17_ = param1.encode();
               _loc18_ = param1.plural;
               param1.plural = "";
               _loc19_ = param1.encode();
               param1.article = _loc16_;
               param1.plural = _loc18_;
               if(_loc7_.cases[param3][param4].hasOwnProperty(_loc15_))
               {
                  param1.cases = _loc7_.cases[param3][param4][_loc15_];
               }
               else
               {
                  if(_loc7_.cases[param3][param4].hasOwnProperty(_loc17_))
                  {
                     param1.cases = _loc7_.cases[param3][param4][_loc17_];
                  }
                  else
                  {
                     if(_loc7_.cases[param3][param4].hasOwnProperty(_loc19_))
                     {
                        param1.cases = _loc7_.cases[param3][param4][_loc19_];
                     }
                  }
               }
            }
            _loc10_ = _loc6_.variations.hasOwnProperty(param1.key)?_loc6_.variations[param1.key]:null;
            _loc11_ = param1.encode();
            if((_loc10_) && (_loc10_.hasOwnProperty(_loc11_)))
            {
               param1.value = _loc10_[_loc11_];
            }
            else
            {
               if(_loc10_)
               {
                  _loc21_ = param1.index;
                  if(_loc21_ >= 0)
                  {
                     param1.index = -1;
                     _loc22_ = param1.encode();
                  }
                  _loc23_ = param1.gender;
                  if((_loc23_) && !(_loc23_ == ""))
                  {
                     param1.gender = "";
                     _loc24_ = param1.encode();
                  }
                  if((_loc23_) && _loc21_ >= 0)
                  {
                     param1.index = _loc21_;
                     _loc25_ = param1.encode();
                  }
                  param1.gender = _loc23_;
                  _loc28_ = param1.cases;
                  _loc29_ = param1.article;
                  if(_loc28_ == "" || _loc28_ == null)
                  {
                     param1.article = "";
                     _loc37_ = param1.encode();
                     if((_loc7_.cases.hasOwnProperty(param3)) && (_loc7_.cases[param3].hasOwnProperty(param4)))
                     {
                        if(_loc7_.cases[param3][param4].hasOwnProperty(_loc11_))
                        {
                           param1.cases = _loc7_.cases[param3][param4][_loc11_];
                        }
                        else
                        {
                           if(_loc7_.cases[param3][param4].hasOwnProperty(_loc37_))
                           {
                              param1.cases = _loc7_.cases[param3][param4][_loc37_];
                           }
                        }
                     }
                     else
                     {
                        param1.cases = "accusative";
                     }
                     _loc26_ = param1.encode();
                     param1.index = -1;
                     _loc27_ = param1.encode();
                     param1.index = _loc21_;
                  }
                  param1.article = _loc29_;
                  if((_loc29_) && !(_loc29_ === ""))
                  {
                     param1.article = "";
                     _loc30_ = param1.encode();
                     param1.index = -1;
                     _loc31_ = param1.encode();
                     param1.index = _loc21_;
                     param1.article = _loc29_;
                  }
                  _loc28_ = param1.cases;
                  if((_loc28_) && !(_loc28_ == ""))
                  {
                     param1.cases = "";
                     _loc32_ = param1.encode();
                     param1.index = -1;
                     _loc33_ = param1.encode();
                     param1.index = _loc21_;
                  }
                  _loc34_ = param1.plural;
                  if(!(_loc34_ === SINGULAR) && !(_loc34_ === PLURAL))
                  {
                     param1.count = NO_COUNT;
                     param1.plural = PLURAL;
                     _loc35_ = param1.encode();
                     param1.index = -1;
                     _loc36_ = param1.encode();
                     param1.index = _loc21_;
                  }
                  if(_loc22_)
                  {
                     _loc20_ = _loc10_[_loc22_];
                  }
                  if(!_loc20_ && (_loc26_))
                  {
                     _loc20_ = _loc10_[_loc26_];
                  }
                  if(!_loc20_ && (_loc27_))
                  {
                     _loc20_ = _loc10_[_loc27_];
                  }
                  if(!_loc20_ && (_loc30_))
                  {
                     _loc20_ = _loc10_[_loc31_];
                  }
                  if(!_loc20_ && (_loc31_))
                  {
                     _loc20_ = _loc10_[_loc31_];
                  }
                  if(!_loc20_ && (_loc32_))
                  {
                     _loc20_ = _loc10_[_loc32_];
                  }
                  if(!_loc20_ && (_loc33_))
                  {
                     _loc20_ = _loc10_[_loc33_];
                  }
                  if(!_loc20_ && (_loc35_))
                  {
                     _loc20_ = _loc10_[_loc35_];
                  }
                  if(!_loc20_ && (_loc36_))
                  {
                     _loc20_ = _loc10_[_loc36_];
                  }
                  if(!_loc20_ && (_loc25_))
                  {
                     _loc20_ = _loc10_[_loc25_];
                  }
                  if(!_loc20_ && (_loc24_))
                  {
                     _loc20_ = _loc10_[_loc24_];
                  }
                  param1.gender = _loc23_;
                  param1.index = _loc21_;
               }
               if(!_loc20_)
               {
                  _loc20_ = _loc8_[param1.key];
               }
               param1.value = _loc20_;
            }
         }
         return param1.toString();
      }
      
      public function translate(param1:String, param2:String, param3:Object=null) : String {
         var _loc7_:Object = null;
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:LocalizerToken = null;
         var _loc13_:Object = null;
         var _loc14_:Object = null;
         var _loc4_:String = param2;
         var _loc5_:* = "";
         var _loc6_:StringBundle = this.stringPackage.get(param1);
         if((_loc6_) && (_loc6_.strings.hasOwnProperty(param2)))
         {
            _loc4_ = _loc6_.strings[param2];
            _loc7_ = !_loc6_.defaultAttributes.hasOwnProperty(param2)?null:_loc6_.defaultAttributes[param2];
            _loc8_ = !_loc6_.variations.hasOwnProperty(param2)?null:_loc6_.variations[param2];
            if(_loc4_.indexOf(OPEN_BRACE) >= 0)
            {
               this.pointer.value = _loc4_;
               if(param3)
               {
                  if(_loc8_)
                  {
                     _loc5_ = this.hashKey(param2,this.pointer,_loc7_,param3);
                     if(!(_loc5_ == param2) && (_loc8_.hasOwnProperty(_loc5_)))
                     {
                        this.pointer.value = _loc8_[_loc5_];
                     }
                     else
                     {
                        _loc9_ = {};
                        for (_loc10_ in param3)
                        {
                           _loc12_ = param3[_loc10_] as LocalizerToken;
                           if(_loc12_)
                           {
                              _loc9_[_loc10_] = param3[_loc10_].gender;
                              param3[_loc10_].gender = "";
                           }
                        }
                        _loc5_ = this.hashKey(param2,this.pointer,_loc7_,param3);
                        for (_loc11_ in _loc9_)
                        {
                           param3[_loc11_].gender = _loc9_[_loc11_];
                        }
                        if(!(_loc5_ == param2) && (_loc8_.hasOwnProperty(_loc5_)))
                        {
                           this.pointer.value = _loc8_[_loc5_];
                        }
                        else
                        {
                           _loc13_ = {};
                           _loc14_ = {};
                           for (_loc10_ in param3)
                           {
                              _loc12_ = param3[_loc10_] as LocalizerToken;
                              if((_loc12_) && (!(_loc12_.plural == "singular")) && !(_loc12_.plural == "plural"))
                              {
                                 _loc13_[_loc10_] = param3[_loc10_].plural;
                                 _loc14_[_loc10_] = param3[_loc10_].count;
                                 param3[_loc10_].count = NO_COUNT;
                                 param3[_loc10_].plural = "plural";
                              }
                           }
                           _loc5_ = this.hashKey(param2,this.pointer,_loc7_,param3);
                           for (_loc11_ in _loc13_)
                           {
                              param3[_loc11_].plural = _loc13_[_loc11_];
                              param3[_loc11_].count = _loc14_[_loc11_];
                           }
                           if(!(_loc5_ == param2) && (_loc8_.hasOwnProperty(_loc5_)))
                           {
                              this.pointer.value = _loc8_[_loc5_];
                           }
                        }
                     }
                  }
               }
               else
               {
                  param3 = {};
               }
               param3[NEWLINE_KEY] = NEWLINE;
               this.substitute(this.pointer,param3,param2,param1);
               _loc4_ = this.pointer.value;
               this.pointer.value = null;
            }
         }
         return !this._substituter?_loc4_:this._substituter.format(_loc4_);
      }
      
      private function hashKey(param1:String, param2:StringPointer, param3:Object, param4:Object) : String {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function substitute(param1:StringPointer, param2:Object, param3:String, param4:String) : void {
         var tokenStopIndex:int = 0;
         var replacement:String = null;
         var token:Object = null;
         var localized:String = null;
         var t:String = null;
         var chompIndex:int = 0;
         var antecedent:String = null;
         var useSpace:Boolean = false;
         var nextToLastSpace:int = 0;
         var pointer:StringPointer = param1;
         var replacements:Object = param2;
         var messageKey:String = param3;
         var messageBundleName:String = param4;
         var input:String = pointer.value;
         var startIndex:int = 0;
         var tokenIndex:int = input.indexOf(OPEN_BRACE);
         localized = EMPTY_STRING;
         var tokenOrder:int = -1;
         while(tokenIndex >= 0)
         {
            tokenOrder++;
            if(tokenIndex != startIndex)
            {
               localized = localized + input.substring(startIndex,tokenIndex);
            }
            tokenStopIndex = input.indexOf(CLOSE_BRACE,tokenIndex);
            replacement = input.substring(tokenIndex + 1,tokenStopIndex);
            replacement.replace(WHITESPACE,EMPTY_STRING);
            try
            {
               token = replacements[replacement];
               if(token != null)
               {
                  t = token is String?token as String:token is LocalizerToken?this.getString(token as LocalizerToken,tokenOrder,messageKey,replacement,messageBundleName):token.toString();
                  if((this._conjugator) && !(localized == EMPTY_STRING))
                  {
                     chompIndex = localized.lastIndexOf(SPACE);
                     antecedent = localized.substring(chompIndex + 1);
                     useSpace = false;
                     if(antecedent == EMPTY_STRING)
                     {
                        nextToLastSpace = localized.lastIndexOf(SPACE,chompIndex-1);
                        antecedent = localized.substring(nextToLastSpace + 1,chompIndex);
                        chompIndex = nextToLastSpace;
                        useSpace = true;
                     }
                     localized = localized.substring(0,chompIndex + 1);
                     t = this._conjugator.format(antecedent,t,useSpace);
                  }
                  if(tokenIndex == 0)
                  {
                     t = t.charAt(0).toUpperCase() + t.substring(1);
                  }
                  localized = localized + t;
               }
               else
               {
                  localized = localized + (OPEN_BRACE + replacement + CLOSE_BRACE);
               }
            }
            catch(e:*)
            {
               localized = localized + (OPEN_BRACE + replacement + CLOSE_BRACE);
            }
            startIndex = tokenStopIndex + 1;
            tokenIndex = input.indexOf(OPEN_BRACE,startIndex);
            if(tokenIndex < 0)
            {
               if(startIndex < input.length)
               {
                  localized = localized + input.substring(startIndex);
               }
               pointer.value = localized;
            }
         }
      }
      
      public function getOriginalString(param1:String, param2:String) : String {
         var _loc3_:* = "";
         if(this.exists(param1,param2))
         {
            _loc3_ = this.stringPackage.get(param1).strings[param2];
         }
         return _loc3_;
      }
      
      public function getStringAttributes(param1:String, param2:String) : Object {
         var _loc3_:Object = null;
         if(this.exists(param1,param2))
         {
            _loc3_ = this.stringPackage.get(param1).defaultAttributes[param2];
         }
         return _loc3_;
      }
      
      public function isObject(param1:String, param2:String) : Boolean {
         var _loc3_:StringBundle = this.stringPackage.get(param1);
         if((_loc3_) && (_loc3_.defaultAttributes.hasOwnProperty(param2)) && (_loc3_.defaultAttributes[param2].hasOwnProperty("object")))
         {
            return true;
         }
         return false;
      }
      
      public function t(param1:String, param2:String, param3:Object=null) : String {
         return this.translate(param1,param2,param3);
      }
      
      public function tk(param1:String, param2:String, param3:String=null, param4:int=-1) : LocalizerToken {
         return this.createToken(param1,param2,param3,param4);
      }
      
      public function tn(param1:String, param2:String=null) : LocalizerToken {
         return this.createName(param1,param2);
      }
      
      public function ts(param1:String) : LocalizerToken {
         return this.createSilent(param1);
      }
   }
}
import Engine.Interfaces.ILocalizerContext;
import Engine.Interfaces.ILocalizer;

class LocalizerContext extends Object implements ILocalizerContext
{
   
   function LocalizerContext(param1:ILocalizer, param2:String) {
      super();
      this.localizer = param1;
      this.context = param2;
   }
   
   private var localizer:ILocalizer;
   
   private var context:String;
   
   private var _suffix:String;
   
   private var _separator:String = "_";
   
   private var _prefix:String;
   
   public function get(param1:String, param2:Object=null) : String {
      var param1:String = this._prefix?this._prefix + this._separator + param1:param1;
      param1 = this._suffix?param1 + this._separator + this._suffix:param1;
      return this.localizer.translate(this.context,param1,param2);
   }
   
   public function get separator() : String {
      return this._separator;
   }
   
   public function set separator(param1:String) : void {
      this._separator = param1;
   }
   
   public function get suffix() : String {
      return this._suffix;
   }
   
   public function set suffix(param1:String) : void {
      this._suffix = param1;
   }
   
   public function get prefix() : String {
      return this._prefix;
   }
   
   public function set prefix(param1:String) : void {
      this._prefix = param1;
   }
   
   public function pluralize(param1:String, param2:int) : Object {
      return this.localizer.createToken(this.context,param1,"",param2);
   }
   
   public function token(param1:String, param2:String="", param3:int=-1) : Object {
      return this.localizer.createToken(this.context,param1,param2,param3);
   }
   
   public function name(param1:String, param2:String="masc") : Object {
      return this.localizer.createName(param1,param2);
   }
   
   public function reset() : void {
      this._suffix = this._prefix = null;
      this._separator = "_";
   }
}
class StringPointer extends Object
{
   
   function StringPointer() {
      super();
   }
   
   public var value:String;
}
