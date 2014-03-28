package ZLocalization
{
   import Engine.Interfaces.ILocale;
   
   public class StringPackage extends Object
   {
      
      public function StringPackage() {
         super();
         this.bundles = [];
         this.bundleMap = {};
         this.locale = new StringLocale();
      }
      
      public var locale:ILocale;
      
      public var bundles:Array;
      
      private var bundleMap:Object;
      
      public function get(param1:String) : StringBundle {
         var _loc2_:StringBundle = null;
         var _loc3_:StringBundle = null;
         if(this.bundleMap.hasOwnProperty(param1))
         {
            _loc2_ = this.bundleMap[param1];
         }
         else
         {
            for each (_loc3_ in this.bundles)
            {
               if(_loc3_.name == param1)
               {
                  _loc2_ = this.bundleMap[param1] = _loc3_;
                  break;
               }
            }
         }
         return _loc2_;
      }
   }
}
import Engine.Interfaces.ILocale;

class StringLocale extends Object implements ILocale
{
   
   function StringLocale() {
      super();
   }
   
   private var languageCode:String;
   
   private var countryCode:String;
   
   private var _value:String;
   
   public function get language() : String {
      return this.languageCode;
   }
   
   public function get country() : String {
      return this.countryCode;
   }
   
   public function get code() : String {
      return this._value;
   }
   
   public function set code(param1:String) : void {
      var _loc2_:* = 0;
      this._value = param1;
      if(this._value)
      {
         _loc2_ = this._value.length;
         if(_loc2_ >= 2)
         {
            this.languageCode = this._value.substr(0,2);
         }
         if(_loc2_ >= 5)
         {
            this.countryCode = this._value.substr(3,2);
         }
      }
      else
      {
         this.languageCode = null;
         this.countryCode = null;
      }
   }
}
