package ZLocalization.conjugator
{
   public class ConjugateIt extends Object implements IConjugatorPlugin
   {
      
      public function ConjugateIt() {
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
