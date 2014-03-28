package ZLocalization.conjugator
{
   public class ConjugateEs extends Object implements IConjugatorPlugin
   {
      
      public function ConjugateEs() {
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
