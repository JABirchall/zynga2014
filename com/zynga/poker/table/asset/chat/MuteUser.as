package com.zynga.poker.table.asset.chat
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import com.zynga.text.EmbeddedFontTextField;
   import caurina.transitions.Tweener;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class MuteUser extends MovieClip
   {
      
      public function MuteUser(param1:String, param2:String, param3:Boolean) {
         var thisROv:Function = null;
         var thisROu:Function = null;
         var inName:String = param1;
         var inZid:String = param2;
         var inBlock:Boolean = param3;
         super();
         thisROv = function(param1:MouseEvent):void
         {
            Tweener.addTween(bg,
               {
                  "alpha":1,
                  "time":0.25,
                  "transition":"easeOutSine"
               });
         };
         thisROu = function(param1:MouseEvent):void
         {
            Tweener.addTween(bg,
               {
                  "alpha":0,
                  "time":0.2,
                  "transition":"easeOutSine"
               });
         };
         this.userName = inName;
         this.zid = inZid;
         this.blocked = inBlock;
         var bgColor:uint = 13369344;
         if(inBlock)
         {
            bgColor = 52224;
         }
         this.bg = new Sprite();
         this.bg.graphics.beginFill(4473924,1);
         this.bg.graphics.drawRect(0,0,120,20);
         this.bg.graphics.endFill();
         this.bg.alpha = 0;
         addChild(this.bg);
         this.cBubble = new ChatIcon();
         this.cBubble.x = 4;
         this.cBubble.y = 3;
         this.cBubble.alpha = 1;
         this.cBubble.ci.alpha = 1;
         this.cBubble.ciX.alpha = 0;
         addChild(this.cBubble);
         if(inBlock)
         {
            this.cBubble.ciX.alpha = 1;
         }
         if(this.userName.length > 14)
         {
            this.userName = this.userName.substr(0,11) + "...";
         }
         this.nameText = new EmbeddedFontTextField(this.userName,"Main",11,16777215);
         this.nameText.autoSize = TextFieldAutoSize.LEFT;
         this.nameText.x = 20;
         this.nameText.y = 1;
         addChild(this.nameText);
         this.addEventListener(MouseEvent.ROLL_OVER,thisROv);
         this.addEventListener(MouseEvent.ROLL_OUT,thisROu);
      }
      
      public var bg:Sprite;
      
      public var zid:String;
      
      public var userName:String;
      
      public var blocked:Boolean;
      
      public var nameText:EmbeddedFontTextField;
      
      public var cBubble:ChatIcon;
      
      public function swapCheck() : void {
         var _loc1_:* = NaN;
         if(this.blocked)
         {
            _loc1_ = 0;
         }
         if(!this.blocked)
         {
            _loc1_ = 1;
         }
         Tweener.addTween(this.cBubble.ciX,
            {
               "alpha":_loc1_,
               "time":0.15,
               "transition":"easeOutSine"
            });
         this.blocked = !this.blocked;
      }
   }
}
