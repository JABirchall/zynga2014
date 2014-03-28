package com.zynga.display.Dialog
{
   import flash.text.TextField;
   import flash.display.BitmapData;
   import com.zynga.rad.buttons.ZButton;
   import flash.geom.Point;
   
   public class DialogSkin extends Object
   {
      
      public function DialogSkin() {
         this.closeOffset = new Point(15,15);
         super();
      }
      
      public static const TILE:Number = 1;
      
      public static const STRETCH:Number = 0;
      
      public var TopLeftCorner:DialogSkinItem;
      
      public var TopRightCorner:DialogSkinItem;
      
      public var BottomLeftCorner:DialogSkinItem;
      
      public var BottomRightCorner:DialogSkinItem;
      
      public var LeftBand:DialogSkinItem;
      
      public var RightBand:DialogSkinItem;
      
      public var TopBand:DialogSkinItem;
      
      public var BottomBand:DialogSkinItem;
      
      public var titleItem:TextField;
      
      public var bgColor:Number = 16777215;
      
      public var bgOpacity:Number = 1;
      
      public var bgBitmap:BitmapData;
      
      public var filterlist:Array;
      
      public var contentFilterList:Array;
      
      public var defaultPadding:Number = 10;
      
      public var buttonPadding:Number = 8;
      
      public var bodyItem:TextField;
      
      public var closeButton:ZButton;
      
      public var closeOffset:Point;
      
      public var defaultwidth:Number = 300;
      
      public var showEffect:Function;
      
      public var hideEffect:Function;
   }
}
