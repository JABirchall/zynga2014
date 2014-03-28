package com.zynga.poker.popups
{
   import flash.display.Sprite;
   import flash.utils.Timer;
   import flash.display.MovieClip;
   import com.zynga.ui.scroll.ScrollEvent;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.poker.table.asset.PokerButton;
   import flash.geom.Point;
   import com.zynga.display.Dialog.*;
   import com.zynga.locale.LocaleManager;
   import flash.display.DisplayObject;
   import caurina.transitions.Tweener;
   import flash.filters.DropShadowFilter;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.text.TextFieldAutoSize;
   import com.zynga.rad.buttons.ZButton;
   import flash.display.DisplayObjectContainer;
   import flash.events.TimerEvent;
   import com.zynga.rad.buttons.ZButtonEvent;
   import flash.geom.Vector3D;
   import flash.display.BitmapData;
   import flash.display.Bitmap;
   import flash.geom.Matrix3D;
   import flash.events.Event;
   
   public class PopupView extends Sprite
   {
      
      public function PopupView() {
         super();
         DialogEvent.disp.addEventListener(DialogEvent.OPEN,this.releaseOthers);
         this.initPopupView();
      }
      
      private var titleSkin:DialogSkin;
      
      private var basicSkin:DialogSkin;
      
      private var interSkin:DialogSkin;
      
      private var panelSkin:DialogSkin;
      
      private var layer:DialogLayer;
      
      private var layerIS:DialogLayer;
      
      private var layerPanel:DialogLayer;
      
      private var layerTransparent:DialogLayer;
      
      private var darkOverlay:Sprite;
      
      private var buttonCore:Array;
      
      public var dummyText:String;
      
      private var bIsInterstitial:Boolean = false;
      
      private var tutorialArrows:Array;
      
      private var tutorialArrowsTimer:Timer;
      
      private var playWithYourBuddiesPopup:MovieClip = null;
      
      private var playWithYourBuddiesTimer:Timer;
      
      private var inviteFriendsToPlayPopup:MovieClip = null;
      
      private var inviteFriendsToPlayTimer:Timer;
      
      public function releaseOthers(param1:DialogEvent) : void {
         ScrollEvent.quickThrow(ScrollEvent.DEFOCUS,this);
      }
      
      public function initPopupView() : void {
         var _loc1_:MovieClip = PokerClassProvider.getObject("PanelBG");
         var _loc2_:MovieClip = PokerClassProvider.getObject("PanelBGIS");
         this.layer = new DialogLayer(760,530,_loc1_,this.panelShow,this.panelHide);
         this.layerIS = new DialogLayer(760,530,_loc2_,this.panelShow,this.panelHide);
         this.layerPanel = new DialogLayer(760,530,_loc1_,this.panelShow,this.panelHide,true);
         this.layerTransparent = new DialogLayer(760,530,null,this.panelShow,this.panelHide,true);
         this.darkOverlay = new Sprite();
         this.darkOverlay.graphics.beginFill(0,0.8);
         this.darkOverlay.graphics.drawRect(0.0,0.0,760,570);
         this.darkOverlay.graphics.endFill();
         this.darkOverlay.visible = false;
         this.layerIS.alpha = 0.0;
         addChild(this.layer);
         addChild(this.darkOverlay);
         addChild(this.layerIS);
         addChild(this.layerPanel);
         addChild(this.layerTransparent);
         this.buttonCore = new Array();
         this.titleSkin = new DialogSkin();
         this.basicSkin = new DialogSkin();
         this.interSkin = new DialogSkin();
         this.panelSkin = new DialogSkin();
         this.defineSkins();
      }
      
      public function hydrate(param1:XML, param2:Object=null) : DialogBox {
         var _loc3_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:DialogLayer = null;
         var _loc11_:String = null;
         var _loc12_:PokerButton = null;
         var _loc13_:Point = null;
         var _loc14_:PopupDialogButton = null;
         var _loc15_:* = undefined;
         var _loc4_:* = false;
         var _loc5_:* = false;
         var _loc6_:* = false;
         var _loc7_:* = false;
         if(param1.@interstitial == "true")
         {
            _loc4_ = true;
         }
         if(param1.@panel == "true")
         {
            _loc5_ = true;
         }
         if(param1.@transparent == "true")
         {
            _loc6_ = true;
         }
         if(param1.content.title.toString() == "" && !_loc4_)
         {
            _loc3_ = this.basicSkin;
         }
         else
         {
            if(!_loc4_)
            {
               _loc3_ = this.titleSkin;
            }
            else
            {
               if(_loc4_)
               {
                  _loc3_ = this.interSkin;
               }
            }
         }
         if(_loc5_)
         {
            _loc3_ = this.panelSkin;
         }
         if((param2) && (param1.content.module) && param1.content.module.@showDarkOverlay == "true")
         {
            _loc7_ = true;
         }
         var _loc8_:DialogBox = new DialogBox(_loc3_,Number(param1.content.@width),Number(param1.content.@height),_loc5_,!_loc6_,_loc7_);
         _loc8_.titleText = param1.content.title.toString();
         if(param1.@cancelable == "true")
         {
            _loc8_.cancelable = true;
         }
         else
         {
            _loc8_.cancelable = false;
         }
         if(param1.@modal == "true")
         {
            _loc8_.modal = true;
         }
         else
         {
            _loc8_.modal = false;
         }
         if(param2)
         {
            try
            {
               param2.preflight();
            }
            catch(error:Error)
            {
            }
            try
            {
               param2.pipe = _loc8_;
            }
            catch(error:Error)
            {
            }
            _loc8_.module = param2;
         }
         else
         {
            _loc8_.bodyText = param1.content.text.toString();
         }
         for each (_loc9_ in param1.buttons.button)
         {
            _loc11_ = String(_loc9_.@localeKey)?LocaleManager.localize(String(_loc9_.@localeKey)):String(_loc9_.@label);
            _loc12_ = new PokerButton(null,"large",_loc11_,null,-1,4);
            _loc13_ = null;
            if(!(String(_loc9_.@offsetX) == "") && !(String(_loc9_.@offsetY) == ""))
            {
               _loc13_ = new Point(Number(_loc9_.@offsetX),Number(_loc9_.@offsetY));
            }
            _loc14_ = new PopupDialogButton(_loc12_,_loc13_);
            _loc8_.addButton(_loc14_);
            for each (_loc15_ in _loc9_.action)
            {
               _loc14_.addEvent(_loc15_["class"],_loc15_["event"],_loc8_);
            }
         }
         if(_loc4_)
         {
            _loc10_ = this.layerIS;
         }
         else
         {
            if(_loc6_)
            {
               _loc10_ = this.layerTransparent;
            }
            else
            {
               if(_loc5_)
               {
                  _loc10_ = this.layerPanel;
               }
               else
               {
                  _loc10_ = this.layer;
               }
            }
         }
         _loc10_.add(_loc8_);
         return _loc8_;
      }
      
      public function set isInterstitial(param1:Boolean) : void {
         this.bIsInterstitial = param1;
         if(this.bIsInterstitial)
         {
            this.layerIS.alpha = 1;
         }
      }
      
      public function createPopup(param1:XML) : DialogBox {
         return null;
      }
      
      private function popupShow(param1:DisplayObject) : void {
         param1.filters = new Array(this.makeGlow());
         param1.alpha = 0;
         Tweener.addTween(param1,
            {
               "alpha":1,
               "time":0.1
            });
      }
      
      private function popupHide(param1:DisplayObject) : void {
         param1.filters = null;
         param1.alpha = 0;
         param1.visible = false;
      }
      
      private function panelShow(param1:DisplayObject) : void {
         var _loc2_:* = NaN;
         if(this.bIsInterstitial)
         {
            _loc2_ = 1;
         }
         else
         {
            _loc2_ = 0.0;
         }
         Tweener.addTween(param1,
            {
               "alpha":_loc2_,
               "time":0.25
            });
         this.bIsInterstitial = false;
      }
      
      private function panelHide(param1:DisplayObject) : void {
         var item:DisplayObject = param1;
         Tweener.addTween(item,
            {
               "alpha":0,
               "time":0.5,
               "transition":"linear",
               "onComplete":function():void
               {
                  item.visible = false;
               }
            });
      }
      
      private function makeDrop(param1:Boolean=false) : DropShadowFilter {
         var _loc2_:Number = 0;
         var _loc3_:Number = 45;
         var _loc4_:Number = 0.35;
         var _loc5_:Number = 4;
         var _loc6_:Number = 4;
         var _loc7_:Number = 4;
         var _loc8_:Number = 1;
         var param1:Boolean = param1;
         var _loc9_:* = false;
         var _loc10_:Number = BitmapFilterQuality.LOW;
         return new DropShadowFilter(_loc7_,_loc3_,_loc2_,_loc4_,_loc5_,_loc6_,_loc8_,_loc10_,param1,_loc9_);
      }
      
      private function makeGlow() : GlowFilter {
         var _loc1_:Number = 16777215;
         var _loc2_:Number = 0.75;
         var _loc3_:Number = 7;
         var _loc4_:Number = 7;
         var _loc5_:Number = 2;
         var _loc6_:* = false;
         var _loc7_:* = false;
         var _loc8_:Number = BitmapFilterQuality.HIGH;
         return new GlowFilter(_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc8_,_loc6_,_loc7_);
      }
      
      private function defineSkins() : void {
         var _loc1_:MovieClip = PokerClassProvider.getObject("BandIS");
         var _loc2_:MovieClip = PokerClassProvider.getObject("botBand");
         var _loc3_:MovieClip = PokerClassProvider.getObject("botLeft");
         var _loc4_:MovieClip = PokerClassProvider.getObject("botLeftIS");
         var _loc5_:MovieClip = PokerClassProvider.getObject("botRight");
         var _loc6_:MovieClip = PokerClassProvider.getObject("botRightIS");
         var _loc7_:MovieClip = PokerClassProvider.getObject("sideBand");
         var _loc8_:MovieClip = PokerClassProvider.getObject("sideBandNT");
         var _loc9_:MovieClip = PokerClassProvider.getObject("topBand");
         var _loc10_:MovieClip = PokerClassProvider.getObject("topBandNT");
         var _loc11_:MovieClip = PokerClassProvider.getObject("topLeft");
         var _loc12_:MovieClip = PokerClassProvider.getObject("topRight");
         var _loc13_:MovieClip = PokerClassProvider.getObject("topRightIS");
         var _loc14_:MovieClip = PokerClassProvider.getObject("topRightNT");
         var _loc15_:MovieClip = PokerClassProvider.getObject("topLeftIS");
         var _loc16_:MovieClip = PokerClassProvider.getObject("topLeftNT");
         this.titleSkin.TopLeftCorner = new DialogSkinItem(_loc11_);
         this.titleSkin.TopRightCorner = new DialogSkinItem(_loc12_);
         this.titleSkin.BottomLeftCorner = new DialogSkinItem(_loc3_);
         this.titleSkin.BottomRightCorner = new DialogSkinItem(_loc5_);
         this.titleSkin.LeftBand = new DialogSkinItem(_loc7_);
         this.titleSkin.RightBand = new DialogSkinItem(_loc7_);
         this.titleSkin.TopBand = new DialogSkinItem(_loc9_);
         this.titleSkin.BottomBand = new DialogSkinItem(_loc2_);
         this.titleSkin.titleItem = new EmbeddedFontTextField("","Main",14,16777215);
         this.titleSkin.titleItem.autoSize = TextFieldAutoSize.LEFT;
         this.titleSkin.bodyItem = new EmbeddedFontTextField("","Main",13);
         var _loc17_:ZButton = PokerClassProvider.getUntypedObject("standardCloseButton") as ZButton;
         this.titleSkin.closeButton = _loc17_;
         this.titleSkin.closeOffset = new Point(9,15);
         this.titleSkin.showEffect = this.popupShow;
         this.titleSkin.hideEffect = this.popupHide;
         this.basicSkin.TopLeftCorner = new DialogSkinItem(_loc16_);
         this.basicSkin.TopRightCorner = new DialogSkinItem(_loc14_);
         this.basicSkin.BottomLeftCorner = new DialogSkinItem(_loc3_);
         this.basicSkin.BottomRightCorner = new DialogSkinItem(_loc5_);
         this.basicSkin.LeftBand = new DialogSkinItem(_loc8_);
         this.basicSkin.RightBand = new DialogSkinItem(_loc8_);
         this.basicSkin.TopBand = new DialogSkinItem(_loc10_);
         this.basicSkin.BottomBand = new DialogSkinItem(_loc2_);
         this.basicSkin.titleItem = new EmbeddedFontTextField("","Main",14,16777215);
         this.basicSkin.titleItem.autoSize = TextFieldAutoSize.LEFT;
         this.basicSkin.bodyItem = new EmbeddedFontTextField("","Main",13);
         this.basicSkin.closeButton = _loc17_;
         this.basicSkin.closeOffset = new Point(13,-13);
         this.panelSkin.TopLeftCorner = new DialogSkinItem(_loc16_);
         this.panelSkin.TopRightCorner = new DialogSkinItem(_loc14_);
         this.panelSkin.BottomLeftCorner = new DialogSkinItem(_loc3_);
         this.panelSkin.BottomRightCorner = new DialogSkinItem(_loc5_);
         this.panelSkin.LeftBand = new DialogSkinItem(_loc8_);
         this.panelSkin.RightBand = new DialogSkinItem(_loc8_);
         this.panelSkin.TopBand = new DialogSkinItem(_loc10_);
         this.panelSkin.BottomBand = new DialogSkinItem(_loc2_);
         this.panelSkin.contentFilterList = new Array(this.makeDrop());
         this.panelSkin.titleItem = new EmbeddedFontTextField("","Main",14,16777215);
         this.panelSkin.titleItem.autoSize = TextFieldAutoSize.LEFT;
         this.panelSkin.bodyItem = new EmbeddedFontTextField("","Main",13);
         this.panelSkin.closeButton = _loc17_;
         this.panelSkin.closeOffset = new Point(13,-13);
         this.interSkin.TopLeftCorner = new DialogSkinItem(_loc15_);
         this.interSkin.TopRightCorner = new DialogSkinItem(_loc13_);
         this.interSkin.BottomLeftCorner = new DialogSkinItem(_loc4_);
         this.interSkin.BottomRightCorner = new DialogSkinItem(_loc6_);
         this.interSkin.LeftBand = new DialogSkinItem(_loc1_);
         this.interSkin.RightBand = new DialogSkinItem(_loc1_);
         this.interSkin.TopBand = new DialogSkinItem(_loc1_);
         this.interSkin.BottomBand = new DialogSkinItem(_loc1_);
         this.interSkin.titleItem = new EmbeddedFontTextField("","Main",24,16777215,"center");
         this.interSkin.titleItem.autoSize = TextFieldAutoSize.CENTER;
         this.interSkin.bodyItem = new EmbeddedFontTextField("","Main",14,16777215);
         this.interSkin.closeButton = _loc17_;
         this.interSkin.closeOffset = new Point(-7,10);
         this.interSkin.bgColor = 3355443;
         this.interSkin.bgOpacity = 0.6;
      }
      
      public function showTutorialArrow(param1:DisplayObjectContainer, param2:Number, param3:Number, param4:Number, param5:Number=5) : void {
         this.showTutorialArrows(param1,[
            {
               "x":param2,
               "y":param3,
               "rotation":param4
            }],param5);
      }
      
      public function showTutorialArrows(param1:DisplayObjectContainer, param2:Array, param3:Number=5) : void {
         var _loc4_:Object = null;
         var _loc5_:MovieClip = null;
         this.hideTutorialArrowsOnly();
         if(param2 != null)
         {
            this.tutorialArrows = new Array();
            for each (_loc4_ in param2)
            {
               _loc5_ = PokerClassProvider.getObject("TutorialArrow");
               _loc5_.x = _loc4_.x;
               _loc5_.y = _loc4_.y;
               _loc5_.rotation = _loc4_.rotation;
               this.tutorialArrows.push(_loc5_);
               param1.addChild(_loc5_ as DisplayObject);
            }
            if(param3 > 0)
            {
               if(this.tutorialArrowsTimer == null)
               {
                  this.tutorialArrowsTimer = new Timer(param3 * 1000,1);
                  this.tutorialArrowsTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTutorialArrowsTimerComplete);
                  this.tutorialArrowsTimer.start();
               }
            }
         }
      }
      
      public function hideTutorialArrowsOnly() : void {
         var _loc1_:MovieClip = null;
         if(this.tutorialArrows != null)
         {
            for each (_loc1_ in this.tutorialArrows)
            {
               (_loc1_ as DisplayObject).parent.removeChild(_loc1_ as DisplayObject);
            }
            this.tutorialArrows = null;
            if(this.tutorialArrowsTimer != null)
            {
               this.tutorialArrowsTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTutorialArrowsTimerComplete);
               this.tutorialArrowsTimer.stop();
               this.tutorialArrowsTimer = null;
            }
         }
      }
      
      public function setTutorialArrowsVisible(param1:Boolean) : void {
         var _loc2_:MovieClip = null;
         if(this.tutorialArrows != null)
         {
            for each (_loc2_ in this.tutorialArrows)
            {
               (_loc2_ as DisplayObject).visible = param1;
            }
         }
         if(this.playWithYourBuddiesPopup)
         {
            (this.playWithYourBuddiesPopup as DisplayObject).visible = param1;
         }
         if(this.inviteFriendsToPlayPopup)
         {
            (this.inviteFriendsToPlayPopup as DisplayObject).visible = param1;
         }
      }
      
      public function hideTutorialArrows() : void {
         this.hideTutorialArrowsOnly();
         this.hidePlayWithYourPokerBuddies();
         this.hideInviteFriendsToPlay();
      }
      
      public function showPlayWithYourPokerBuddies(param1:DisplayObjectContainer, param2:Number, param3:Number, param4:Number=5) : void {
         var _loc5_:EmbeddedFontTextField = null;
         var _loc6_:ZButton = null;
         this.hideTutorialArrowsOnly();
         if(!this.playWithYourBuddiesPopup)
         {
            this.playWithYourBuddiesPopup = PokerClassProvider.getObject("PlayWithYourPokerBuddiesPopup");
            _loc5_ = new EmbeddedFontTextField(LocaleManager.localize("flash.friendSelector.popups.playWithYourPokerBuddies"),"Main",16,16777215);
            _loc5_.autoSize = TextFieldAutoSize.LEFT;
            _loc5_.fitInWidth(230);
            _loc5_.x = _loc5_.x - _loc5_.textWidth * _loc5_.scaleX / 2;
            _loc5_.y = _loc5_.y - (this.playWithYourBuddiesPopup.height / 2 - 5);
            this.playWithYourBuddiesPopup.addChild(_loc5_);
            _loc6_ = PokerClassProvider.getObject("standardCloseButton") as ZButton;
            _loc6_.width = 15;
            _loc6_.height = 15;
            _loc6_.x = 117;
            _loc6_.y = -59;
            _loc6_.addEventListener(ZButtonEvent.RELEASE,this.onPlayWithYourBuddiesPopupCloseButtonClicked,false,0,true);
            this.playWithYourBuddiesPopup.addChild(_loc6_);
         }
         this.playWithYourBuddiesPopup.x = param2;
         this.playWithYourBuddiesPopup.y = param3;
         param1.addChild(this.playWithYourBuddiesPopup as DisplayObject);
         if(param4 > 0)
         {
            if(this.playWithYourBuddiesTimer == null)
            {
               this.playWithYourBuddiesTimer = new Timer(param4 * 1000,1);
               this.playWithYourBuddiesTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onPlayWithYourBuddiesTimerComplete);
               this.playWithYourBuddiesTimer.start();
            }
         }
      }
      
      public function hidePlayWithYourPokerBuddies() : void {
         if(this.playWithYourBuddiesPopup)
         {
            (this.playWithYourBuddiesPopup as DisplayObject).parent.removeChild(this.playWithYourBuddiesPopup as DisplayObject);
            this.playWithYourBuddiesPopup = null;
            if(this.playWithYourBuddiesTimer != null)
            {
               this.playWithYourBuddiesTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onPlayWithYourBuddiesTimerComplete);
               this.playWithYourBuddiesTimer.stop();
               this.playWithYourBuddiesTimer = null;
            }
         }
      }
      
      public function showInviteFriendsToPlay(param1:DisplayObjectContainer, param2:Number, param3:Number, param4:Number=5) : void {
         var _loc5_:EmbeddedFontTextField = null;
         this.hideTutorialArrows();
         if(!this.inviteFriendsToPlayPopup)
         {
            this.inviteFriendsToPlayPopup = PokerClassProvider.getObject("inviteFriendsToPlayPopup");
            _loc5_ = new EmbeddedFontTextField(LocaleManager.localize("flash.friendSelector.popups.inviteFriendsToPlay"),"Main",16,16777215);
            _loc5_.autoSize = TextFieldAutoSize.LEFT;
            _loc5_.fitInWidth(240);
            _loc5_.x = _loc5_.x - _loc5_.textWidth * _loc5_.scaleX / 2;
            _loc5_.y = _loc5_.y - (this.inviteFriendsToPlayPopup.height / 2 - 5);
            this.inviteFriendsToPlayPopup.addChild(_loc5_);
         }
         this.inviteFriendsToPlayPopup.x = param2;
         this.inviteFriendsToPlayPopup.y = param3;
         param1.addChild(this.inviteFriendsToPlayPopup as DisplayObject);
         if(param4 > 0)
         {
            if(this.inviteFriendsToPlayTimer == null)
            {
               this.inviteFriendsToPlayTimer = new Timer(param4 * 1000,1);
               this.inviteFriendsToPlayTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onInviteFriendsToPlayTimerComplete);
               this.inviteFriendsToPlayTimer.start();
            }
         }
      }
      
      public function hideInviteFriendsToPlay() : void {
         if(this.inviteFriendsToPlayPopup)
         {
            (this.inviteFriendsToPlayPopup as DisplayObject).parent.removeChild(this.inviteFriendsToPlayPopup as DisplayObject);
            this.inviteFriendsToPlayPopup = null;
            if(this.inviteFriendsToPlayTimer != null)
            {
               this.inviteFriendsToPlayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onInviteFriendsToPlayTimerComplete);
               this.inviteFriendsToPlayTimer.stop();
               this.inviteFriendsToPlayTimer = null;
            }
         }
      }
      
      public function showDarkOverlay() : void {
         this.darkOverlay.alpha = int(this.darkOverlay.visible);
         this.darkOverlay.visible = true;
         Tweener.addTween(this.darkOverlay,
            {
               "alpha":1,
               "time":0.75,
               "transition":"easeOutSine"
            });
      }
      
      public function hideDarkOverlay() : void {
         if(!this.darkOverlay.visible)
         {
            return;
         }
         this.darkOverlay.alpha = 1;
         Tweener.addTween(this.darkOverlay,
            {
               "alpha":0.0,
               "time":0.75,
               "transition":"easeOutSine",
               "onComplete":function():void
               {
                  darkOverlay.visible = false;
               }
            });
      }
      
      public function performFlipOnDisplayObject(param1:DisplayObject) : void {
         var inDisplayObjectOrigin:Vector3D = null;
         var _parent:DisplayObjectContainer = null;
         var container:Sprite = null;
         var cachedView:Bitmap = null;
         var containerOrigin:Vector3D = null;
         var cachedTransformObj:Object = null;
         var finalTransformObj:Object = null;
         var inDisplayObject:DisplayObject = param1;
         if(!inDisplayObject.parent)
         {
            return;
         }
         inDisplayObjectOrigin = new Vector3D(inDisplayObject.x,inDisplayObject.y,inDisplayObject.z);
         _parent = inDisplayObject.parent;
         container = new Sprite();
         var bitmapData:BitmapData = null;
         cachedView = null;
         try
         {
            bitmapData = new BitmapData(inDisplayObject.width,inDisplayObject.height,true,0);
            bitmapData.draw(inDisplayObject,null,null,null,null,false);
            cachedView = new Bitmap(bitmapData,"auto",true);
         }
         catch(e:Error)
         {
         }
         if(!bitmapData || !cachedView)
         {
            return;
         }
         container.transform.matrix3D = new Matrix3D();
         containerOrigin = new Vector3D(inDisplayObjectOrigin.x + inDisplayObject.width / 2,inDisplayObjectOrigin.y + inDisplayObject.height / 2,inDisplayObjectOrigin.z);
         container.transform.matrix3D.position = containerOrigin;
         _parent.removeChild(inDisplayObject);
         container.addChild(inDisplayObject);
         container.addChild(cachedView);
         inDisplayObject.x = -(inDisplayObject.width / 2);
         inDisplayObject.y = -(inDisplayObject.height / 2);
         cachedView.x = inDisplayObject.x;
         cachedView.y = inDisplayObject.y;
         addChild(container);
         container.mouseChildren = false;
         cachedTransformObj = new Object();
         cachedTransformObj.rotationValue = new Number(0.0);
         cachedTransformObj.time = new Number(0.5);
         cachedTransformObj.lastRotationValue = new Number(0.0);
         cachedTransformObj.finalRotationValue = new Number(90);
         Tweener.addTween(cachedTransformObj,
            {
               "rotationValue":cachedTransformObj.finalRotationValue,
               "time":cachedTransformObj.time,
               "transition":"easeInSine",
               "onUpdate":function():void
               {
                  container.transform.matrix3D.appendRotation(cachedTransformObj.rotationValue - cachedTransformObj.lastRotationValue,Vector3D.Y_AXIS);
                  cachedTransformObj.lastRotationValue = cachedTransformObj.rotationValue;
                  container.transform.matrix3D.position = containerOrigin;
               },
               "onComplete":function():void
               {
                  container.visible = false;
                  container.removeChild(cachedView);
                  container.transform.matrix3D.identity();
                  container.transform.matrix3D.appendRotation(-90,Vector3D.Y_AXIS);
                  container.transform.matrix3D.position = containerOrigin;
               }
            });
         finalTransformObj = new Object();
         finalTransformObj.rotationValue = new Number(-90);
         finalTransformObj.time = new Number(0.5);
         finalTransformObj.lastRotationValue = new Number(-90);
         finalTransformObj.finalRotationValue = new Number(0.0);
         Tweener.addTween(finalTransformObj,
            {
               "rotationValue":finalTransformObj.finalRotationValue,
               "time":finalTransformObj.time,
               "delay":cachedTransformObj.time,
               "transition":"easeOutSine",
               "onStart":function():void
               {
                  container.visible = true;
               },
               "onUpdate":function():void
               {
                  container.transform.matrix3D.appendRotation(finalTransformObj.rotationValue - finalTransformObj.lastRotationValue,Vector3D.Y_AXIS);
                  finalTransformObj.lastRotationValue = finalTransformObj.rotationValue;
                  container.transform.matrix3D.position = containerOrigin;
               },
               "onComplete":function():void
               {
                  container.transform.matrix3D.identity();
                  container.transform.matrix3D = null;
                  container.removeChild(inDisplayObject);
                  removeChild(container);
                  container = null;
                  inDisplayObject.x = inDisplayObjectOrigin.x;
                  inDisplayObject.y = inDisplayObjectOrigin.y;
                  _parent.addChild(inDisplayObject);
               }
            });
      }
      
      private function onTutorialArrowsTimerComplete(param1:TimerEvent) : void {
         this.hideTutorialArrowsOnly();
      }
      
      private function onPlayWithYourBuddiesTimerComplete(param1:TimerEvent) : void {
         this.hidePlayWithYourPokerBuddies();
      }
      
      private function onInviteFriendsToPlayTimerComplete(param1:TimerEvent) : void {
         this.hideInviteFriendsToPlay();
      }
      
      private function onPlayWithYourBuddiesPopupCloseButtonClicked(param1:Event) : void {
         this.hidePlayWithYourPokerBuddies();
      }
   }
}
