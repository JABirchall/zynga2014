package fl.controls.dataGridClasses
{
   import fl.controls.TextInput;
   import fl.controls.listClasses.ICellRenderer;
   import fl.controls.listClasses.ListData;
   
   public class DataGridCellEditor extends TextInput implements ICellRenderer
   {
      
      public function DataGridCellEditor() {
         super();
      }
      
      private static var defaultStyles:Object;
      
      public static function getStyleDefinition() : Object {
         return defaultStyles;
      }
      
      public function get selected() : Boolean {
         return false;
      }
      
      protected var _listData:ListData;
      
      public function get listData() : ListData {
         return _listData;
      }
      
      protected var _data:Object;
      
      public function get data() : Object {
         return _data;
      }
      
      public function set data(param1:Object) : void {
         _data = param1;
      }
      
      public function setMouseState(param1:String) : void {
      }
      
      public function set selected(param1:Boolean) : void {
      }
      
      public function set listData(param1:ListData) : void {
         _listData = param1;
         text = _listData.label;
      }
   }
}
