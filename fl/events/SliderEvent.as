package fl.events
{
   import flash.events.Event;
   
   public class SliderEvent extends Event
   {
      
      public function SliderEvent(param1:String, param2:Number, param3:String, param4:String, param5:int=0) {
         _value = param2;
         _keyCode = param5;
         _triggerEvent = param4;
         _clickTarget = param3;
         super(param1);
      }
      
      public static const CHANGE:String = "change";
      
      public static const THUMB_PRESS:String = "thumbPress";
      
      public static const THUMB_DRAG:String = "thumbDrag";
      
      public static const THUMB_RELEASE:String = "thumbRelease";
      
      protected var _triggerEvent:String;
      
      protected var _clickTarget:String;
      
      public function get keyCode() : Number {
         return _keyCode;
      }
      
      protected var _keyCode:Number;
      
      public function get triggerEvent() : String {
         return _triggerEvent;
      }
      
      public function get value() : Number {
         return _value;
      }
      
      protected var _value:Number;
      
      public function get clickTarget() : String {
         return _clickTarget;
      }
      
      override public function toString() : String {
         return formatToString("SliderEvent","type","value","bubbles","cancelable","keyCode","triggerEvent","clickTarget");
      }
      
      override public function clone() : Event {
         return new SliderEvent(type,_value,_clickTarget,_triggerEvent,_keyCode);
      }
   }
}
