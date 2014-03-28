package com.zynga.display.Dialog
{
   import flash.display.MovieClip;
   
   public class DialogSkinItem extends Object
   {
      
      public function DialogSkinItem(param1:MovieClip, param2:Number=0) {
         super();
         this.resource = param1;
         this.skintype = param2;
      }
      
      public var skintype:Number;
      
      public var resource:MovieClip;
   }
}
