package ZLocalization.conjugator
{
   public class ConjugateFr extends Object implements IConjugatorPlugin
   {
      
      public function ConjugateFr() {
         super();
      }
      
      private static const VOWEL:String = "vowel";
      
      private static const CONSONANT:String = "consonant";
      
      private static const VOWELS:Object;
      
      private static const CONJUGATIONS:Object;
      
      private static const FIRST_LETTER:RegExp;
      
      public function get conjugations() : Object {
         return CONJUGATIONS;
      }
      
      public function conjugate(param1:Object, param2:String) : String {
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc3_:String = param1 as String;
         if(!_loc3_)
         {
            _loc4_ = param2.match(FIRST_LETTER);
            if(_loc4_)
            {
               _loc5_ = _loc4_.firstLetter;
               _loc3_ = VOWELS.hasOwnProperty(_loc5_)?param1[VOWEL]:param1[CONSONANT];
            }
            else
            {
               _loc3_ = param1[CONSONANT];
            }
         }
         return _loc3_;
      }
   }
}
