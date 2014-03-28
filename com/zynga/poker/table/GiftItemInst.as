package com.zynga.poker.table
{
   import flash.display.MovieClip;
   import flash.display.Bitmap;
   import com.zynga.poker.PokerClassProvider;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class GiftItemInst extends MovieClip
   {
      
      public function GiftItemInst(param1:GiftItem) {
         this.mnUniqueID = Math.ceil(Math.random() * 16777215);
         super();
         this.moGift = param1;
         this.AddSpinner();
      }
      
      public var moGift:GiftItem = null;
      
      private var mChildSwf:GiftItemInstSwf = null;
      
      private var mChildImage:Bitmap = null;
      
      private var mChildSpinner:MovieClip = null;
      
      public var mnUniqueID:Number;
      
      public function Release() : void {
         var _loc1_:GiftItemInstSwf = null;
         if(this.mChildSwf != null)
         {
            _loc1_ = this.mChildSwf as GiftItemInstSwf;
            if(_loc1_)
            {
               _loc1_.Release();
            }
         }
         this.mChildSwf = null;
         this.mChildImage = null;
      }
      
      public function Sleep() : void {
         var _loc1_:GiftItemInstSwf = null;
         if(this.mChildSwf != null)
         {
            _loc1_ = this.mChildSwf as GiftItemInstSwf;
            if(_loc1_)
            {
               _loc1_.Sleep();
            }
         }
      }
      
      public function Wake() : void {
         var _loc1_:GiftItemInstSwf = null;
         x = 0;
         y = 0;
         if(this.mChildSwf != null)
         {
            _loc1_ = this.mChildSwf as GiftItemInstSwf;
            if(_loc1_)
            {
               _loc1_.Wake();
            }
         }
      }
      
      private function AddSpinner() : void {
         this.mChildSpinner = PokerClassProvider.getObject("GiftItemInstSpinner");
         this.mChildSpinner.scaleX = 0.5;
         this.mChildSpinner.scaleY = 0.5;
         this.mChildSpinner.y = this.mChildSpinner.y - 20;
         this.addChild(this.mChildSpinner);
      }
      
      private function RemoveSpinner() : void {
         if((this.mChildSpinner) && (this.contains(this.mChildSpinner)))
         {
            this.removeChild(this.mChildSpinner);
            this.mChildSpinner = null;
         }
      }
      
      public function addGiftDisplayObject(param1:DisplayObject) : void {
         var _loc2_:Rectangle = null;
         if(param1 is Bitmap && !this.mChildImage)
         {
            this.mChildImage = param1 as Bitmap;
            _loc2_ = this.mChildImage.getBounds(stage);
            this.mChildImage.x = _loc2_.width * -0.5;
            this.mChildImage.y = _loc2_.height * -0.85;
            addChild(this.mChildImage);
         }
         if(param1 is MovieClip && !this.mChildSwf)
         {
            this.mChildSwf = new GiftItemInstSwf(param1 as MovieClip,false);
            addChild(this.mChildSwf);
         }
         this.RemoveSpinner();
      }
      
      public function animateGift(param1:String) : void {
         var _loc2_:GiftItemInstSwf = null;
         if(this.mChildSwf != null)
         {
            _loc2_ = this.mChildSwf as GiftItemInstSwf;
            if(_loc2_)
            {
               _loc2_.animateGift(param1);
            }
         }
      }
   }
}
