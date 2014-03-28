package ZLocalization.substituter
{
   import Engine.Interfaces.ILocale;
   
   public class SubstituterFactory extends Object
   {
      
      public function SubstituterFactory() {
         super();
      }
      
      private static const substitutors:Object;
      
      public function hasSubstitutor(param1:ILocale) : Boolean {
         return substitutors.hasOwnProperty(param1.code);
      }
      
      public function newSubstitutor(param1:ILocale) : ISubstituter {
         var _loc2_:ISubstituter = null;
         var _loc3_:Class = null;
         if(this.hasSubstitutor(param1))
         {
            _loc3_ = substitutors[param1.code];
            _loc2_ = new _loc3_() as ISubstituter;
         }
         return _loc2_;
      }
   }
}
