package com.zynga.poker.lobby.asset
{
   import flash.display.Sprite;
   import com.zynga.draw.Box;
   import flash.display.MovieClip;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.filters.DropShadowFilter;
   import com.zynga.poker.PokerClassProvider;
   import flash.text.TextFieldAutoSize;
   
   public class DrawFrame extends Sprite
   {
      
      public function DrawFrame(param1:int, param2:int, param3:Boolean=true, param4:Boolean=true) {
         super();
         this._width = param1;
         this._height = param2;
         this._drawInner = param3;
         this._drawClose = param4;
         this.setup();
      }
      
      public var cont:Box;
      
      public var bgCont:Sprite;
      
      public var closer:MovieClip;
      
      public var titleTextField:EmbeddedFontTextField;
      
      private var round:int = 9;
      
      private var _width:int;
      
      private var _height:int;
      
      private var _drawInner:Boolean;
      
      private var _drawClose:Boolean;
      
      private function setup() : void {
         var _loc2_:Box = null;
         this.bgCont = new Sprite();
         var _loc1_:Object = new Object();
         _loc1_.colors = [6908265,0];
         _loc1_.alphas = [1,1];
         _loc1_.ratios = [0,200];
         _loc2_ = new Box(this._width + 12,20,_loc1_,false,true,this.round);
         _loc2_.x = -6;
         _loc2_.y = -20;
         this.bgCont.addChild(_loc2_);
         var _loc3_:Box = new Box(this._width + 12,this._height + 16,0,false,true,this.round);
         _loc3_.x = -6;
         _loc3_.y = -10;
         this.bgCont.addChildAt(_loc3_,0);
         addChildAt(this.bgCont,0);
         var _loc4_:Array = [new DropShadowFilter(0,0,0,1,1.1,1.1,10,3)];
         this.bgCont.filters = _loc4_;
         if(this._drawInner)
         {
            this.cont = new Box(this._width,this._height,16777215,false);
            addChildAt(this.cont,1);
         }
         if(this._drawClose)
         {
            this.closer = PokerClassProvider.getObject("GenericCloseButton");
            this.closer.x = this._width - 11;
            this.closer.y = -18;
            this.closer.buttonMode = true;
            this.closer.useHandCursor = true;
            addChildAt(this.closer,2);
         }
      }
      
      public function setSize(param1:Number, param2:Number, param3:Boolean=true, param4:Boolean=true) : void {
         this._width = param1;
         this._height = param2;
         this._drawInner = param3;
         this._drawClose = param4;
         if((this.closer) && (contains(this.closer)))
         {
            removeChild(this.closer);
            this.closer = null;
         }
         if((this.cont) && (contains(this.cont)))
         {
            removeChild(this.cont);
            this.cont = null;
         }
         if((this.bgCont) && (contains(this.bgCont)))
         {
            while(this.bgCont.numChildren)
            {
               this.bgCont.removeChildAt(0);
            }
            removeChild(this.bgCont);
            this.bgCont.filters = null;
            this.bgCont = null;
         }
         this.setup();
      }
      
      public function renderZLiveTitle(param1:String) : void {
         if(!this.titleTextField)
         {
            this.titleTextField = new EmbeddedFontTextField(param1,"MainSemi",12,16777215,"left");
            this.titleTextField.autoSize = TextFieldAutoSize.LEFT;
            this.titleTextField.x = 16;
            this.titleTextField.y = -20;
            addChild(this.titleTextField);
         }
         else
         {
            this.titleTextField.text = param1;
         }
      }
      
      public function renderTitle(param1:String) : void {
         this.titleTextField = new EmbeddedFontTextField(param1,"Main",12,16777215);
         this.titleTextField.autoSize = TextFieldAutoSize.LEFT;
         this.titleTextField.x = 0;
         this.titleTextField.y = -19;
         addChild(this.titleTextField);
      }
   }
}
