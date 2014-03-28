package ZLocalization.serializer
{
   import ZLocalization.StringPackage;
   import ZLocalization.StringBundle;
   
   public class StringObjectSerializer extends Object implements IStringPackageSerializer
   {
      
      public function StringObjectSerializer() {
         super();
      }
      
      public function serialize(param1:StringPackage) : Object {
         var _loc3_:StringBundle = null;
         var _loc2_:Object = {};
         for each (_loc3_ in param1.bundles)
         {
            _loc2_[_loc3_.name] = 
               {
                  "strings":_loc3_.strings,
                  "variations":_loc3_.variations,
                  "attributes":_loc3_.defaultAttributes,
                  "cases":_loc3_.cases
               };
         }
         return 
            {
               "locale":param1.locale.code,
               "bundles":_loc2_
            };
      }
      
      public function deserialize(param1:Object) : StringPackage {
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc6_:StringBundle = null;
         var _loc2_:StringPackage = new StringPackage();
         _loc2_.locale.code = param1.locale;
         var _loc3_:Object = param1.bundles;
         for (_loc4_ in _loc3_)
         {
            _loc5_ = _loc3_[_loc4_];
            _loc6_ = new StringBundle(_loc4_,_loc5_.strings,_loc5_.variations,_loc5_.attributes,_loc5_.cases);
            _loc2_.bundles.push(_loc6_);
         }
         return _loc2_;
      }
   }
}
