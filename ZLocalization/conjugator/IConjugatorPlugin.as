package ZLocalization.conjugator
{
   public interface IConjugatorPlugin
   {
      
      function get conjugations() : Object;
      
      function conjugate(param1:Object, param2:String) : String;
   }
}
