package com.zynga.poker.table.betting
{
   import com.zynga.poker.table.asset.PokerButton;
   import com.zynga.draw.Box;
   import flash.events.MouseEvent;
   
   public class BetButton extends PokerButton
   {
      
      public function BetButton(param1:*, param2:String, param3:String, param4:Object=null, param5:Number=-1, param6:Number=0, param7:Number=-1, param8:Number=0, param9:Boolean=false) {
         this.gradObjShadow = new Object();
         this.gradObjMouseOver = new Object();
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9);
         this.gradObjShadow.colors = [14277081,14277081,7566195];
         this.gradObjShadow.alphas = [1,1,1];
         this.gradObjShadow.ratios = [0,127,225];
         this.gradObjMouseOver.colors = [16711422,7566195];
         this.gradObjMouseOver.alphas = [1,1];
         this.gradObjMouseOver.ratios = [100,225];
         this.bgDropShadow = new Box(bg.width,bg.height,this.gradObjShadow,false,true,corners[sizeID]);
         this.bgMouseOver = new Box(bg.width,bg.height,this.gradObjMouseOver,false,true,corners[sizeID]);
         this.bgDropShadow.visible = false;
         this.bgMouseOver.visible = false;
         cont.addChildAt(this.bgDropShadow,0);
         cont.addChildAt(this.bgMouseOver,0);
         cont.swapChildren(bg,this.bgMouseOver);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      }
      
      private var bgDropShadow:Box;
      
      private var gradObjShadow:Object;
      
      private var bgMouseOver:Box;
      
      private var gradObjMouseOver:Object;
      
      public function onMouseOver(param1:MouseEvent) : void {
         this.bgMouseOver.visible = true;
      }
      
      public function onMouseOut(param1:MouseEvent) : void {
         this.bgMouseOver.visible = false;
         this.onMouseUp(new MouseEvent(MouseEvent.MOUSE_UP));
      }
      
      public function onMouseDown(param1:MouseEvent) : void {
         this.bgMouseOver.visible = false;
         this.bgDropShadow.visible = true;
         this.cont.y = 1;
      }
      
      public function onMouseUp(param1:MouseEvent) : void {
         this.bgDropShadow.visible = false;
         this.cont.y = 0;
      }
   }
}
