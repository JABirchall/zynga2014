package com.zynga.display.Dialog
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class DialogButton extends Object
   {
      
      public function DialogButton() {
         super();
         this.eventStack = new Object();
      }
      
      public static const CLOSE:Number = 2;
      
      public static const DISABLE:Number = 3;
      
      public static const STANDARD:Number = 4;
      
      public var button:DisplayObject;
      
      public var offset:Point;
      
      public var action:Number;
      
      public var owner:DialogBox;
      
      public var eventStack:Object;
   }
}
