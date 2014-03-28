package ZLocalization.conjugator
{
   import Engine.Interfaces.ILocale;
   
   public class ConjugatorFactory extends Object
   {
      
      public function ConjugatorFactory() {
         super();
      }
      
      private static const plugins:Object;
      
      public function hasConjugator(param1:ILocale) : Boolean {
         return plugins.hasOwnProperty(param1.language);
      }
      
      public function newConjugator(param1:ILocale) : IConjugator {
         var _loc2_:Conjugator = null;
         var _loc3_:Class = null;
         if(this.hasConjugator(param1))
         {
            _loc3_ = plugins[param1.language] as Class;
            _loc2_ = new Conjugator();
            _loc2_.plugin = new _loc3_() as IConjugatorPlugin;
         }
         return _loc2_;
      }
   }
}
