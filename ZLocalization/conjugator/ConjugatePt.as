package ZLocalization.conjugator
{
   public class ConjugatePt extends Object implements IConjugatorPlugin
   {
      
      public function ConjugatePt() {
         super();
      }
      
      private static const CONJUGATIONS:Object;
      
      public function get conjugations() : Object {
         return CONJUGATIONS;
      }
      
      public function conjugate(param1:Object, param2:String) : String {
         return param1 as String;
      }
   }
}
