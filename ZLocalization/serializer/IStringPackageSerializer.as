package ZLocalization.serializer
{
   import ZLocalization.StringPackage;
   
   public interface IStringPackageSerializer
   {
      
      function serialize(param1:StringPackage) : Object;
      
      function deserialize(param1:Object) : StringPackage;
   }
}
