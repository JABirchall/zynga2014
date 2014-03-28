package ZLocalization.serializer
{
   public class SerializerFactory extends Object
   {
      
      public function SerializerFactory() {
         super();
      }
      
      private static var s_serializers:Object;
      
      public function hasSerializer(param1:String) : Boolean {
         var _loc2_:String = this.getFormat(param1);
         return (_loc2_) && (s_serializers.hasOwnProperty(_loc2_));
      }
      
      public function newSerializer(param1:String) : IStringPackageSerializer {
         var _loc2_:IStringPackageSerializer = null;
         var _loc3_:String = null;
         var _loc4_:Class = null;
         if(this.hasSerializer(param1))
         {
            _loc3_ = this.getFormat(param1);
            _loc4_ = s_serializers[_loc3_];
            _loc2_ = new _loc4_() as IStringPackageSerializer;
         }
         return _loc2_;
      }
      
      public function getFormat(param1:String) : String {
         var _loc3_:* = 0;
         var _loc2_:String = null;
         if(param1)
         {
            _loc3_ = param1.lastIndexOf(".");
            if(_loc3_ >= 0)
            {
               _loc2_ = param1.substring(_loc3_ + 1);
               _loc2_ = _loc2_.toLowerCase();
            }
         }
         return _loc2_;
      }
   }
}
