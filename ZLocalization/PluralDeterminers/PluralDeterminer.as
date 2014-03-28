package ZLocalization.PluralDeterminers
{
   public class PluralDeterminer extends Object
   {
      
      public function PluralDeterminer() {
         super();
      }
      
      public static function getPluralDeterminer() : PluralDeterminer {
         var _loc1_:String = null;
         if(ZLoc.instance !== null)
         {
            _loc1_ = ZLoc.instance.localeCode;
         }
         else
         {
            _loc1_ = "en_US";
         }
         switch(_loc1_)
         {
            case "pl_PL":
               return new PolishPluralDeterminer();
            case "ru_RU":
               return new RussianPluralDeterminer();
            case "fr_FR":
               return new FrenchPluralDeterminer();
            default:
               return new PluralDeterminer();
         }
         
      }
      
      public const SINGULAR:String = "singular";
      
      public const PLURAL:String = "plural";
      
      public const TWO:String = "two";
      
      public const FEW:String = "few";
      
      public const OTHER:String = "other";
      
      public const SOME:String = "some";
      
      public const ZERO:String = "zero";
      
      public function determinePluralType(param1:int) : String {
         if(param1 == 1 || param1 == -1)
         {
            return this.SINGULAR;
         }
         return this.PLURAL;
      }
   }
}
