package com.zynga.poker.popups.modules.PreSelectPopUp
{
   import flash.display.MovieClip;
   import com.zynga.poker.SSLMigration;
   import com.zynga.display.ImageManager;
   import flash.events.Event;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import com.zynga.poker.popups.modules.events.PreSelectPopUpChicletEvent;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.poker.PokerClassProvider;
   
   public class PreSelectPopUpChiclet extends MovieClip
   {
      
      public function PreSelectPopUpChiclet(param1:Object=null) {
         var _loc2_:EmbeddedFontTextField = null;
         super();
         this.assets = PokerClassProvider.getObject("friends_chiclet") as MovieClip;
         this.assets.buttonMode = true;
         addChild(this.assets);
         this.playerName = param1.first_name + " " + param1.last_name.charAt(0) + ".";
         this.UID = param1.zid;
         _loc2_ = new EmbeddedFontTextField(this.playerName,"MainSemi",12);
         _loc2_.fontColor = 0;
         _loc2_.x = 60;
         _loc2_.y = 8;
         _loc2_.width = 103;
         _loc2_.height = 20;
         this.assets.addChild(_loc2_);
         this.picUrl = param1.pic_small;
         this.assets.addEventListener(MouseEvent.CLICK,this.onChicletClicked,false,0,true);
         this.selected = false;
      }
      
      public var assets:MovieClip;
      
      public var playerName:String;
      
      public var picUrl:String;
      
      public var UID:String;
      
      public var sn_id:int;
      
      private var _chicletSelected:Boolean;
      
      private var _isLoaded:Boolean = false;
      
      public function set selected(param1:Boolean) : void {
         this._chicletSelected = param1;
         this.assets.chiclet.chicletcheckbox.selected = param1;
         if(param1)
         {
            this.assets.chiclet.chicletcheckbox.alpha = 1;
            this.assets.chiclet.chicletcheckbox1.alpha = 0.0;
         }
         else
         {
            this.assets.chiclet.chicletcheckbox.alpha = 0.0;
            this.assets.chiclet.chicletcheckbox1.alpha = 1;
         }
      }
      
      public function get selected() : Boolean {
         return this._chicletSelected;
      }
      
      public function loadPicture(param1:String=null) : void {
         if(this._isLoaded)
         {
            return;
         }
         var _loc2_:RegExp = new RegExp("access_token=[a-zA-Z0-9]+(?:&|$)","g");
         var _loc3_:RegExp = new RegExp("https","g");
         var _loc4_:String = this.picUrl;
         if(!SSLMigration.isSSLEnabled && this.sn_id == 1)
         {
            _loc4_ = _loc4_.replace(_loc2_,"");
            _loc4_ = _loc4_.replace(_loc3_,"http");
            ImageManager.load(_loc4_,
               {
                  "container":this.assets,
                  "onComplete":this.onUserImageLoadComplete,
                  "visible":false
               },"",this.picUrl,param1);
         }
         else
         {
            ImageManager.load(_loc4_,
               {
                  "container":this.assets,
                  "onComplete":this.onUserImageLoadComplete,
                  "visible":false
               },"","",param1);
         }
      }
      
      private function onUserImageLoadComplete(param1:Event) : void {
         var _loc2_:DisplayObject = param1.currentTarget.content as DisplayObject;
         this._isLoaded = true;
         if(!(_loc2_.width == 25) || !(_loc2_.height == 25))
         {
            _loc2_.scaleX = 25 / _loc2_.width;
            _loc2_.scaleY = 25 / _loc2_.height;
         }
         _loc2_.x = 30;
         _loc2_.y = 4.5;
         _loc2_.visible = true;
      }
      
      private function onChicletClicked(param1:MouseEvent) : void {
         this.dispatchEvent(new PreSelectPopUpChicletEvent(PreSelectPopUpChicletEvent.TYPE_CLICKED));
      }
      
      public function dispose() : void {
         this.assets.removeEventListener(MouseEvent.CLICK,this.onChicletClicked);
         removeChild(this.assets);
         this.assets = null;
      }
   }
}
