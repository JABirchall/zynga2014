package com.zynga.draw.pokerUIbutton
{
   import com.zynga.draw.CasinoSprite;
   import com.zynga.draw.pokerUIbutton.buttonStyle.PokerUIButtonStyle;
   import flash.display.DisplayObject;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.text.TextFormat;
   import com.zynga.geom.Size;
   import com.zynga.draw.pokerUIbutton.styles.PokerUIButtonLiveJoinCloseStyle;
   import com.zynga.draw.pokerUIbutton.styles.PokerUIButtonShinyStyle;
   import com.zynga.draw.pokerUIbutton.styles.PokerUIButtonLobbyStyle;
   import com.zynga.draw.pokerUIbutton.styles.PokerUIButtonSmallRectangleStyle;
   import com.zynga.draw.pokerUIbutton.styles.PokerUIButtonWrapperChicletStyle;
   import com.zynga.draw.pokerUIbutton.styles.PokerUIButtonRequest2MFSActionStyle;
   import com.zynga.draw.pokerUIbutton.styles.PokerUIButtonFriendSelectorStyle;
   import com.zynga.draw.pokerUIbutton.styles.PokerUIButtonGenericCloseStyle;
   import com.zynga.draw.pokerUIbutton.styles.PokerUIButtonLuckyBonusStyle;
   import com.zynga.draw.pokerUIbutton.styles.PokerUIButtonPokerGeniusStyle;
   import com.zynga.draw.pokerUIbutton.styles.PokerUIButtonDefaultStyle;
   import flash.events.MouseEvent;
   
   public class PokerUIButton extends CasinoSprite
   {
      
      public function PokerUIButton() {
         super();
         this.style = BUTTONSTYLE_DEFAULT;
         this._enabled = true;
         buttonMode = true;
      }
      
      public static const BUTTONSTYLE_DEFAULT:int = 0;
      
      public static const BUTTONSTYLE_LIVEJOINCLOSE:int = 1;
      
      public static const BUTTONSTYLE_SHINY:int = 2;
      
      public static const BUTTONSTYLE_LOBBY:int = 3;
      
      public static const BUTTONSTYLE_SMALLRECTANGLE:int = 4;
      
      public static const BUTTONSTYLE_WRAPPERCHICLET:int = 5;
      
      public static const BUTTONSTYLE_REQUEST_TWO_MFS_ACTION:int = 6;
      
      public static const BUTTONSTYLE_FRIENDSELECTOR:int = 7;
      
      public static const BUTTONSTYLE_GENERICCLOSE:int = 8;
      
      public static const BUTTONSTYLE_LUCKYBONUS:int = 9;
      
      public static const BUTTONSTYLE_POKERGENIUS:int = 10;
      
      private var _style:int = -1;
      
      private var _instance:PokerUIButtonStyle;
      
      private var _tag:String;
      
      private var _enabled:Boolean;
      
      private var _backing:DisplayObject;
      
      public function set style(param1:int) : void {
         if(this._style == param1)
         {
            return;
         }
         if(this._instance)
         {
            this.removeListeners();
            if(contains(this._instance))
            {
               removeChild(this._instance);
            }
            this._instance = null;
         }
         this._style = param1;
         this._instance = this.createButtonStyle(this._style);
         this._instance.drawNormalState();
         if(this._backing)
         {
            this._instance.backing = this._backing;
         }
         this.setupListeners();
         if(!contains(this._instance))
         {
            addChild(this._instance);
         }
      }
      
      public function get style() : int {
         return this._style;
      }
      
      public function set grayOut(param1:Boolean) : void {
         this._instance.grayOut = param1;
      }
      
      public function set label(param1:String) : void {
         if(this._instance)
         {
            this._instance.label = param1;
         }
      }
      
      public function get label() : String {
         if(this._instance)
         {
            return this._instance.label;
         }
         return null;
      }
      
      public function get labelTextField() : EmbeddedFontTextField {
         if(this._instance)
         {
            return this._instance.labelTextField;
         }
         return null;
      }
      
      public function set labelTextFormat(param1:TextFormat) : void {
         if(this._instance)
         {
            this._instance.labelTextFormat = param1;
         }
      }
      
      public function get labelTextFormat() : TextFormat {
         if(this._instance)
         {
            return this._instance.labelTextFormat;
         }
         return null;
      }
      
      public function set labelShouldSizeToFit(param1:Boolean) : void {
         if(this._instance)
         {
            this._instance.labelShouldSizeToFit = param1;
         }
      }
      
      public function get labelShouldSizeToFit() : Boolean {
         if(this._instance)
         {
            return this._instance.labelShouldSizeToFit;
         }
         return false;
      }
      
      public function set image(param1:DisplayObject) : void {
         if((this._instance) && (param1))
         {
            this._instance.image = param1;
         }
      }
      
      public function get image() : DisplayObject {
         if(this._instance)
         {
            return this._instance.image;
         }
         return null;
      }
      
      public function set imageShouldShareLabelContainer(param1:Boolean) : void {
         if(this._instance)
         {
            this._instance.imageShouldShareLabelContainer = param1;
         }
      }
      
      public function get imageShouldShareLabelContainer() : Boolean {
         if(this._instance)
         {
            return this._instance.imageShouldShareLabelContainer;
         }
         return false;
      }
      
      public function set colorSet(param1:int) : void {
         if((this._instance) && (param1))
         {
            this._instance.colorSet = param1;
         }
      }
      
      public function get colorSet() : int {
         if(this._instance)
         {
            return this._instance.colorSet;
         }
         return -1;
      }
      
      public function set buttonSize(param1:Size) : void {
         if(this._instance)
         {
            this._instance.buttonSize = param1;
         }
      }
      
      public function get buttonSize() : Size {
         if(this._instance)
         {
            return this._instance.buttonSize;
         }
         return null;
      }
      
      public function set enabled(param1:Boolean) : void {
         if(this._enabled != param1)
         {
            this._enabled = param1;
            if(this._enabled)
            {
               alpha = 1;
               this.setupListeners();
            }
            else
            {
               alpha = 0.5;
               this.removeListeners();
            }
         }
      }
      
      public function get enabled() : Boolean {
         return this._enabled;
      }
      
      public function set tag(param1:String) : void {
         this._tag = param1;
      }
      
      public function get tag() : String {
         return this._tag;
      }
      
      public function reset() : void {
         this.onMouseOut(null);
      }
      
      public function addBacking(param1:DisplayObject) : void {
         this._backing = param1;
         this.addChildAt(this._backing,0);
         if(this._instance)
         {
            this._instance.backing = this._backing;
         }
      }
      
      public function set textSize(param1:Size) : void {
         if(this._instance)
         {
            this._instance.textSize = param1;
         }
      }
      
      private function createButtonStyle(param1:int) : PokerUIButtonStyle {
         switch(param1)
         {
            case BUTTONSTYLE_LIVEJOINCLOSE:
               return new PokerUIButtonLiveJoinCloseStyle();
            case BUTTONSTYLE_SHINY:
               return new PokerUIButtonShinyStyle();
            case BUTTONSTYLE_LOBBY:
               return new PokerUIButtonLobbyStyle();
            case BUTTONSTYLE_SMALLRECTANGLE:
               return new PokerUIButtonSmallRectangleStyle();
            case BUTTONSTYLE_WRAPPERCHICLET:
               return new PokerUIButtonWrapperChicletStyle();
            case BUTTONSTYLE_REQUEST_TWO_MFS_ACTION:
               return new PokerUIButtonRequest2MFSActionStyle();
            case BUTTONSTYLE_FRIENDSELECTOR:
               return new PokerUIButtonFriendSelectorStyle();
            case BUTTONSTYLE_GENERICCLOSE:
               return new PokerUIButtonGenericCloseStyle();
            case BUTTONSTYLE_LUCKYBONUS:
               return new PokerUIButtonLuckyBonusStyle();
            case BUTTONSTYLE_POKERGENIUS:
               return new PokerUIButtonPokerGeniusStyle();
            default:
               return new PokerUIButtonDefaultStyle();
         }
         
      }
      
      private function setupListeners() : void {
         if(!hasEventListener(MouseEvent.MOUSE_OVER))
         {
            addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver,false,0,true);
         }
         if(!hasEventListener(MouseEvent.MOUSE_OUT))
         {
            addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut,false,0,true);
         }
         if(!hasEventListener(MouseEvent.MOUSE_DOWN))
         {
            addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown,false,0,true);
         }
         if(!hasEventListener(MouseEvent.MOUSE_UP))
         {
            addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp,false,0,true);
         }
      }
      
      private function removeListeners() : void {
         if(hasEventListener(MouseEvent.MOUSE_OVER))
         {
            removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         }
         if(hasEventListener(MouseEvent.MOUSE_OUT))
         {
            removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         }
         if(hasEventListener(MouseEvent.MOUSE_DOWN))
         {
            removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         }
         if(hasEventListener(MouseEvent.MOUSE_UP))
         {
            removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         }
      }
      
      private function onMouseOver(param1:MouseEvent) : void {
         if(this._instance)
         {
            this._instance.drawOverState();
         }
      }
      
      private function onMouseOut(param1:MouseEvent) : void {
         if(this._instance)
         {
            this._instance.drawNormalState();
         }
      }
      
      private function onMouseDown(param1:MouseEvent) : void {
         if(this._instance)
         {
            this._instance.drawDownState();
         }
      }
      
      private function onMouseUp(param1:MouseEvent) : void {
         if(this._instance)
         {
            this._instance.drawUpState();
         }
      }
   }
}
