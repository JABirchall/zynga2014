package com.zynga.poker.popups
{
   import com.zynga.display.Dialog.DialogButton;
   import com.zynga.display.Dialog.DialogBox;
   import flash.events.MouseEvent;
   import com.zynga.display.Dialog.DialogEvent;
   import com.zynga.poker.popups.events.PPVEvent;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class PopupDialogButton extends DialogButton
   {
      
      public function PopupDialogButton(param1:DisplayObject, param2:Point=null, param3:Number=4) {
         super();
         button = param1;
         action = param3;
         offset = param2;
      }
      
      public function addEvent(param1:String, param2:String, param3:DialogBox) : void {
         var classref:String = param1;
         var idref:String = param2;
         var popref:DialogBox = param3;
         var DEFunc:Function = function(param1:MouseEvent):void
         {
            DialogEvent.quickThrow(DialogEvent[idref],owner);
         };
         var PVFunc:Function = function(param1:MouseEvent):void
         {
            popref.dispatchEvent(new PPVEvent(PPVEvent[idref]));
         };
         switch(String(classref))
         {
            case "DialogEvent":
               button.addEventListener(MouseEvent.CLICK,DEFunc);
               break;
            case "PPVEvent":
               button.addEventListener(MouseEvent.CLICK,PVFunc);
               break;
         }
         
      }
   }
}
