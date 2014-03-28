package ZLocalization.PluralDeterminers
{
   public class RussianPluralDeterminer extends PluralDeterminer
   {
      
      public function RussianPluralDeterminer() {
         super();
      }
      
      override public function determinePluralType(param1:int) : String {
         var param1:int = Math.abs(param1);
         if(param1 % 10 == 1 && !(param1 % 100 == 11))
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
