package fl.data
{
   public dynamic class SimpleCollectionItem extends Object
   {
      
      public function SimpleCollectionItem() {
         super();
      }
      
      public var data:String;
      
      public var label:String;
      
      public function toString() : String {
         return "[SimpleCollectionItem: " + label + "," + data + "]";
      }
   }
}
