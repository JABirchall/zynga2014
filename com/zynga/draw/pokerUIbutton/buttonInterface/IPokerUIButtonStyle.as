package com.zynga.draw.pokerUIbutton.buttonInterface
{
   import com.zynga.geom.Size;
   import flash.display.DisplayObject;
   
   public interface IPokerUIButtonStyle
   {
      
      function set buttonSize(param1:Size) : void;
      
      function get buttonSize() : Size;
      
      function set label(param1:String) : void;
      
      function get label() : String;
      
      function set image(param1:DisplayObject) : void;
      
      function get image() : DisplayObject;
      
      function set colorSet(param1:int) : void;
      
      function get colorSet() : int;
      
      function set imageShouldShareLabelContainer(param1:Boolean) : void;
      
      function get imageShouldShareLabelContainer() : Boolean;
      
      function drawNormalState() : void;
      
      function drawOverState() : void;
      
      function drawDownState() : void;
      
      function drawUpState() : void;
   }
}
