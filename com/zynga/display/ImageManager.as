package com.zynga.display
{
   import flash.utils.Dictionary;
   import com.zynga.poker.SSLMigration;
   import com.greensock.loading.LoaderMax;
   import flash.display.BitmapData;
   import flash.display.Bitmap;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.geom.Point;
   
   public class ImageManager extends Object
   {
      
      public function ImageManager() {
         super();
      }
      
      private static const DEFAULT_PROFILE_IMAGE_URL:String = "http://statics.poker.static.zynga.com/poker/img/zSilhouette100.png";
      
      private static const DEFAULT_IMAGE_TIMEOUT:int = 5000;
      
      private static const URL_PATTERN:RegExp;
      
      private static const MAX_CONNECTIONS_PER_SUBDOMAIN:int = 2;
      
      private static var subdomainConnectionsMap:Dictionary;
      
      public static function load(param1:String, param2:Object=null, param3:String="", param4:String="", param5:String="", param6:Boolean=true, param7:Number=5000) : void {
         if(param2 == null)
         {
            param2 = {};
         }
         var param4:String = (param4) && (checkValidUrl(param4))?param4:"";
         var _loc8_:String = (param3) && (checkValidUrl(param3))?param3:DEFAULT_PROFILE_IMAGE_URL;
         _loc8_ = SSLMigration.getSecureURL(_loc8_);
         var _loc9_:String = SafeAssetLoader.EXTERNAL_SANDBOX_IMAGES.indexOf(param1) > -1?_loc8_:param1;
         loadRequest(_loc9_,param2,_loc8_,param4,param5,param6,param7);
      }
      
      private static function loadRequest(param1:String, param2:Object, param3:String, param4:String, param5:String, param6:Boolean, param7:Number) : void {
         var _loc9_:String = null;
         var _loc10_:GreensockSafeImageLoader = null;
         var _loc8_:Object = URL_PATTERN.exec(param1);
         if(_loc8_ != null)
         {
            _loc9_ = _loc8_[1];
            if(subdomainConnectionsMap[_loc9_] == null)
            {
               subdomainConnectionsMap[_loc9_] = {};
            }
            if(subdomainConnectionsMap[_loc9_].loader == null)
            {
               subdomainConnectionsMap[_loc9_].loader = new LoaderMax(
                  {
                     "auditSize":false,
                     "maxConnections":MAX_CONNECTIONS_PER_SUBDOMAIN
                  });
            }
            param2.alternateURL = param3;
            param2.fallbackURL = param4;
            param2.trackString = param5;
            param2.autoDispose = param6;
            param2.timeout = param7;
            _loc10_ = new GreensockSafeImageLoader(param1,param2);
            subdomainConnectionsMap[_loc9_].loader.append(_loc10_);
            subdomainConnectionsMap[_loc9_].loader.load();
         }
      }
      
      public static function cropBitmapDataToFace(param1:Bitmap, param2:Number=100) : BitmapData {
         var bitmapData:BitmapData = null;
         var tempBMD:BitmapData = null;
         var scale:Number = NaN;
         var matrix:Matrix = null;
         var smallBMD:BitmapData = null;
         var content:Bitmap = param1;
         var cropSize:Number = param2;
         if(content == null)
         {
            return new BitmapData(cropSize,cropSize,false,16711680);
         }
         try
         {
            bitmapData = BitmapData(content.bitmapData);
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
      
      public static function checkValidUrl(param1:String) : Boolean {
         var _loc3_:String = null;
         var _loc4_:* = false;
         var _loc5_:* = false;
         var _loc6_:Object = null;
         var _loc2_:Object = URL_PATTERN.exec(param1);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_[1];
            _loc4_ = Boolean(_loc2_[3]);
            _loc5_ = false;
            for each (_loc6_ in SafeAssetLoader.DOMAIN_WHITELIST)
            {
               if(_loc6_.domain is RegExp && _loc3_.search(_loc6_.domain) >= 0 || !(_loc6_.domain is RegExp) && _loc3_.substring(_loc3_.length - _loc6_.domain.length) == _loc6_.domain)
               {
                  _loc5_ = !_loc4_ || (_loc4_) && (_loc6_.allowQuerystring)?true:false;
               }
            }
            return _loc5_?true:false;
         }
         return false;
      }
      
      public static function getNonSSLFBProfileImageURL(param1:String) : String {
         var _loc2_:RegExp = new RegExp("access_token=[a-zA-Z0-9]+(?:&|$)","g");
         var _loc3_:RegExp = new RegExp("https","g");
         var _loc4_:String = param1;
         _loc4_ = _loc4_.replace(_loc2_,"");
         _loc4_ = _loc4_.replace(_loc3_,"http");
         return _loc4_;
      }
   }
}
