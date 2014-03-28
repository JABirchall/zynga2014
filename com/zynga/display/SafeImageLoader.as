package com.zynga.display
{
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.events.TimerEvent;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.display.Bitmap;
   import flash.geom.Point;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   
   public class SafeImageLoader extends SafeAssetLoader
   {
      
      public function SafeImageLoader(param1:String="", param2:String="", param3:Number=0, param4:Boolean=false) {
         super(param1,param2,param3);
         supportedContent.splice(supportedContent.indexOf("application/x-shockwave-flash"),1);
         this._cropToSquare = param4;
         shouldLoadDefaultContent = true;
      }
      
      private static const STAT_IMAGE_LOAD_ATTEMPTED:String = "ImageLoadAttempted";
      
      private static const STAT_IMAGE_LOAD_FAILED_IO:String = "ImageLoadFailedIO";
      
      private static const STAT_IMAGE_LOAD_FAILED_SECURITY:String = "ImageLoadFailedSecurity";
      
      private static const STAT_IMAGE_LOAD_FAILED_TIMEOUT:String = "ImageLoadFailedTimeout";
      
      private static const STAT_IMAGE_LOAD_SUCCEEDED:String = "ImageLoadSucceeded";
      
      private var _cropToSquare:Boolean;
      
      override public function load(param1:URLRequest, param2:LoaderContext=null) : void {
         super.load(param1,param2);
         this.doHitForStat(currentStage,STAT_IMAGE_LOAD_ATTEMPTED);
      }
      
      override protected function onTimeout(param1:TimerEvent) : void {
         super.onTimeout(param1);
         this.doHitForStat(currentStage,STAT_IMAGE_LOAD_FAILED_TIMEOUT);
      }
      
      override public function addEventListeners() : void {
         super.addEventListeners();
         if(this.contentLoaderInfo)
         {
            this.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
            this.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         }
      }
      
      override public function removeEventListeners() : void {
         super.removeEventListeners();
         if(this.contentLoaderInfo)
         {
            this.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
            this.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         }
      }
      
      public function cropBitmapDataToFace(param1:Number=100) : BitmapData {
         var bitmapData:BitmapData = null;
         var tempBMD:BitmapData = null;
         var scale:Number = NaN;
         var matrix:Matrix = null;
         var smallBMD:BitmapData = null;
         var cropSize:Number = param1;
         try
         {
            bitmapData = BitmapData(Bitmap(this.content).bitmapData);
         }
         catch(e:Error)
         {
            return new BitmapData(cropSize,cropSize,false,16711680);
         }
         var yOffset:int = 7;
         if(bitmapData.height > 280)
         {
            scale = 0.5;
            matrix = new Matrix();
            matrix.scale(scale,scale);
            smallBMD = new BitmapData(bitmapData.width * scale,bitmapData.height * scale,true,0);
            smallBMD.draw(bitmapData,matrix,null,null,null,true);
            tempBMD = smallBMD;
            yOffset = yOffset + 15;
         }
         else
         {
            if(bitmapData.height > 170)
            {
               scale = 0.7;
               matrix = new Matrix();
               matrix.scale(scale,scale);
               smallBMD = new BitmapData(bitmapData.width * scale,bitmapData.height * scale,true,0);
               smallBMD.draw(bitmapData,matrix,null,null,null,true);
               tempBMD = smallBMD;
               yOffset = yOffset + 10;
            }
            else
            {
               tempBMD = bitmapData;
            }
         }
         var cropRect:Rectangle = new Rectangle(tempBMD.width / 2 - cropSize / 2,tempBMD.height / 2 - cropSize / 2 - yOffset,cropSize,cropSize);
         if(cropRect.y < 0)
         {
            cropRect.y = 6;
         }
         bitmapData = new BitmapData(cropSize,cropSize);
         bitmapData.copyPixels(tempBMD,cropRect,new Point(0,0));
         return bitmapData;
      }
      
      private function onIOError(param1:IOErrorEvent) : void {
         this.doHitForStat(currentStage,STAT_IMAGE_LOAD_FAILED_IO);
         performFallbackRoutine();
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void {
         this.doHitForStat(currentStage,STAT_IMAGE_LOAD_FAILED_SECURITY);
         performFallbackRoutine();
      }
      
      override public function unloadContent() : void {
         unload();
         request = null;
         context = null;
      }
      
      protected function doHitForStat(param1:String, param2:String) : void {
         var _loc3_:String = param1 + param2;
         if((FIRE_AUDITING_STATS) && !(trackString == null) && !(trackString == ""))
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,trackString.replace("%ACTION%",_loc3_),"",1,"",PokerStatHit.HITTYPE_NORMAL,PokerStatHit.HITLOC_AGNOSTIC,STAT_SAMPLING_INTERVAL));
         }
      }
   }
}
