package ZLocalization
{
   public class StringBundle extends Object
   {
      
      public function StringBundle(param1:String, param2:Object=null, param3:Object=null, param4:Object=null, param5:Object=null) {
         super();
         this.name = param1;
         this.strings = param2?param2:{};
         this.variations = param3?param3:{};
         this.defaultAttributes = param4?param4:{};
         this.cases = param5?param5:{};
      }
      
      public var name:String;
      
      public var strings:Object;
      
      public var variations:Object;
      
      public var defaultAttributes:Object;
      
      public var cases:Object;
   }
}
