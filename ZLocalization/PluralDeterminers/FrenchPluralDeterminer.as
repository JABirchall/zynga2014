package ZLocalization.PluralDeterminers
{
   public class FrenchPluralDeterminer extends PluralDeterminer
   {
      
      public function FrenchPluralDeterminer() {
         super();
      }
      
      override public function determinePluralType(param1:int) : String {
         var param1:int = Math.abs(param1);
         if(param1 == 1 || param1 == 0)
         {
            return SINGULAR;
         }
         return PLURAL;
      }
   }
}
