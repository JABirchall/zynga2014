package fl.managers
{
   import flash.display.InteractiveObject;
   import fl.controls.Button;
   
   public interface IFocusManager
   {
      
      function getFocus() : InteractiveObject;
      
      function deactivate() : void;
      
      function set defaultButton(param1:Button) : void;
      
      function set showFocusIndicator(param1:Boolean) : void;
      
      function get defaultButtonEnabled() : Boolean;
      
      function findFocusManagerComponent(param1:InteractiveObject) : InteractiveObject;
      
      function get nextTabIndex() : int;
      
      function get defaultButton() : Button;
      
      function get showFocusIndicator() : Boolean;
      
      function hideFocus() : void;
      
      function activate() : void;
      
      function showFocus() : void;
      
      function set defaultButtonEnabled(param1:Boolean) : void;
      
      function setFocus(param1:InteractiveObject) : void;
      
      function getNextFocusManagerComponent(param1:Boolean=false) : InteractiveObject;
   }
}
