package ZLocalization.PluralDeterminers
{
   public class PolishPluralDeterminer extends PluralDeterminer
   {
      
      public function PolishPluralDeterminer() {
         super();
      }
      
      override public function determinePluralType(param1:int) : String {
         var param1:int = Math.abs(param1);
         if(param1 == 1)
         {
            return SINGULAR;
         }
         if(param1 % 10 >= 2 && param1 % 10 <= 4 && !(param1 % 100 >= 12 && param1 % 100 <= 14))
         {
            return FEW;
         }
         return PLURAL;
      }
   }
}
