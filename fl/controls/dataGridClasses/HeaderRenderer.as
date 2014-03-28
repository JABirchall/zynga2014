package fl.controls.dataGridClasses
{
   import fl.controls.LabelButton;
   
   public class HeaderRenderer extends LabelButton
   {
      
      public function HeaderRenderer() {
         super();
         focusEnabled = false;
      }
      
      private static var defaultStyles:Object;
      
      public static function getStyleDefinition() : Object {
         return defaultStyles;
      }
      
      override protected function drawLayout() : void {
         var _loc1_:Number = Number(getStyleValue("textPadding"));
         textField.height = textField.textHeight + 4;
         textField.visible = label.length > 0;
         var _loc2_:Number = textField.textWidth + 4;
         var _loc3_:Number = textField.textHeight + 4;
         var _loc4_:Number = icon == null?0:icon.width + 4;
         var _loc5_:Number = Math.max(0,Math.min(_loc2_,width - 2 * _loc1_ - _loc4_));
         if(icon != null)
         {
            icon.x = width - _loc1_ - icon.width - 2;
            icon.y = Math.round((height - icon.height) / 2);
         }
         textField.width = _loc5_;
         textField.x = _loc1_;
         textField.y = Math.round((height - textField.height) / 2);
         background.width = width;
         background.height = height;
      }
      
      public function set column(param1:uint) : void {
         _column = param1;
      }
      
      public var _column:uint;
      
      public function get column() : uint {
         return _column;
      }
   }
}
