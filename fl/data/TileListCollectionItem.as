package fl.data
{
   public dynamic class TileListCollectionItem extends Object
   {
      
      public function TileListCollectionItem() {
         super();
      }
      
      public function toString() : String {
         return "[TileListCollectionItem: " + label + "," + source + "]";
      }
      
      public var source:String;
      
      public var label:String;
   }
}
