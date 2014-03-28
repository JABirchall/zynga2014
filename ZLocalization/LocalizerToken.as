package ZLocalization
{
   import ZLocalization.PluralDeterminers.*;
   
   public class LocalizerToken extends Object
   {
      
      public function LocalizerToken() {
         super();
      }
      
      private static const NO_COUNT:int = -2.147483648E9;
      
      private static const GENDERS:Array;
      
      private static const GENDER_MASK:uint = 240;
      
      private static const COUNTS:Array;
      
      private static const ARTICLES:Array;
      
      private static const ARTICLE_MASK:uint = 15;
      
      private static const CASES:Array;
      
      private static const CHAR_OFFSET:int = 48;
      
      public var context:String;
      
      public var key:String;
      
      public var value:Object;
      
      public var gender:String = "";
      
      public var count:int = -2.147483648E9;
      
      public var article:String = "";
      
      public var index:int = -1;
      
      public var cases:String = "";
      
      public var plural:String = "";
      
      public function decode(param1:String) : void {
         var _loc2_:Number = param1.charCodeAt(0) - CHAR_OFFSET;
         var _loc3_:* = (_loc2_ & GENDER_MASK) >> 4;
         var _loc4_:* = _loc2_ & ARTICLE_MASK;
         var _loc5_:int = param1.charCodeAt(1) - CHAR_OFFSET;
         var _loc6_:int = param1.charCodeAt(3) - CHAR_OFFSET;
         this.gender = GENDERS[_loc3_];
         this.article = ARTICLES[_loc4_];
         this.plural = COUNTS[_loc6_];
         this.cases = CASES[_loc5_];
         this.index = param1.charCodeAt(2) - CHAR_OFFSET;
      }
      
      public function encode() : String {
         var _loc6_:* = NaN;
         if(this.count != NO_COUNT)
         {
            this.plural = PluralDeterminer.getPluralDeterminer().determinePluralType(this.count);
         }
         var _loc1_:int = this.gender?GENDERS.indexOf(this.gender):0;
         var _loc2_:int = this.article?ARTICLES.indexOf(this.article):0;
         var _loc3_:int = COUNTS.indexOf(this.plural);
         var _loc4_:int = CASES.indexOf(this.cases);
         var _loc5_:* = "";
         if(_loc1_ >= 0 || _loc3_ >= 0 || _loc2_ >= 0 || _loc4_ >= 0)
         {
            _loc6_ = (_loc1_ << 4) + _loc2_ + CHAR_OFFSET;
            _loc5_ = String.fromCharCode(_loc6_,_loc4_ + CHAR_OFFSET,this.index + CHAR_OFFSET,_loc3_ + CHAR_OFFSET);
         }
         return _loc5_;
      }
      
      public function get attributes() : String {
         var _loc1_:Array = [];
         if((this.gender) && !(this.gender == ""))
         {
            _loc1_.push(this.gender);
         }
         if((this.article) && !(this.article == ""))
         {
            _loc1_.push(this.article);
         }
         if(this.count != NO_COUNT)
         {
            _loc1_.push(this.plural);
         }
         if(this.cases != "")
         {
            _loc1_.push(this.cases);
         }
         return _loc1_.join(",");
      }
      
      public function toString() : String {
         return this.value is String?this.value as String:this.value?this.value.toString():null;
      }
      
      public function getString() : String {
         return this.toString();
      }
   }
}
