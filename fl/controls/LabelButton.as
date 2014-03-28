package fl.controls
{
   import fl.managers.IFocusManagerComponent;
   import fl.core.InvalidationType;
   import flash.text.TextField;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import flash.text.TextFieldType;
   import flash.display.DisplayObject;
   import fl.events.ComponentEvent;
   import fl.core.UIComponent;
   import flash.text.TextFormat;
   
   public class LabelButton extends BaseButton implements IFocusManagerComponent
   {
      
      public function LabelButton() {
         super();
      }
      
      private static var defaultStyles:Object;
      
      public static var createAccessibilityImplementation:Function;
      
      public static function getStyleDefinition() : Object {
         return mergeStyles(defaultStyles,BaseButton.getStyleDefinition());
      }
      
      protected var _toggle:Boolean = false;
      
      override protected function draw() : void {
         if(textField.text != _label)
         {
            label = _label;
         }
         if(isInvalid(InvalidationType.STYLES,InvalidationType.STATE))
         {
            drawBackground();
            drawIcon();
            drawTextFormat();
            invalidate(InvalidationType.SIZE,false);
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            drawLayout();
         }
         if(isInvalid(InvalidationType.SIZE,InvalidationType.STYLES))
         {
            if((isFocused) && (focusManager.showFocusIndicator))
            {
               drawFocus(true);
            }
         }
         validate();
      }
      
      override protected function drawLayout() : void {
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc1_:Number = Number(getStyleValue("textPadding"));
         var _loc2_:String = icon == null && mode == "center"?ButtonLabelPlacement.TOP:_labelPlacement;
         textField.height = textField.textHeight + 4;
         var _loc3_:Number = textField.textWidth + 4;
         var _loc4_:Number = textField.textHeight + 4;
         var _loc5_:Number = icon == null?0:icon.width + _loc1_;
         var _loc6_:Number = icon == null?0:icon.height + _loc1_;
         textField.visible = label.length > 0;
         if(icon != null)
         {
            icon.x = Math.round((width - icon.width) / 2);
            icon.y = Math.round((height - icon.height) / 2);
         }
         if(textField.visible == false)
         {
            textField.width = 0;
            textField.height = 0;
         }
         else
         {
            if(_loc2_ == ButtonLabelPlacement.BOTTOM || _loc2_ == ButtonLabelPlacement.TOP)
            {
               _loc7_ = Math.max(0,Math.min(_loc3_,width - 2 * _loc1_));
               if(height - 2 > _loc4_)
               {
                  _loc8_ = _loc4_;
               }
               else
               {
                  _loc8_ = height - 2;
               }
               textField.width = _loc3_ = _loc7_;
               textField.height = _loc4_ = _loc8_;
               textField.x = Math.round((width - _loc3_) / 2);
               textField.y = Math.round((height - textField.height - _loc6_) / 2 + (_loc2_ == ButtonLabelPlacement.BOTTOM?_loc6_:0));
               if(icon != null)
               {
                  icon.y = Math.round(_loc2_ == ButtonLabelPlacement.BOTTOM?textField.y - _loc6_:textField.y + textField.height + _loc1_);
               }
            }
            else
            {
               _loc7_ = Math.max(0,Math.min(_loc3_,width - _loc5_ - 2 * _loc1_));
               textField.width = _loc3_ = _loc7_;
               textField.x = Math.round((width - _loc3_ - _loc5_) / 2 + (_loc2_ != ButtonLabelPlacement.LEFT?_loc5_:0));
               textField.y = Math.round((height - textField.height) / 2);
               if(icon != null)
               {
                  icon.x = Math.round(_loc2_ != ButtonLabelPlacement.LEFT?textField.x - _loc5_:textField.x + _loc3_ + _loc1_);
               }
            }
         }
         super.drawLayout();
      }
      
      public var textField:TextField;
      
      protected function toggleSelected(param1:MouseEvent) : void {
         selected = !selected;
         dispatchEvent(new Event(Event.CHANGE,true));
      }
      
      override protected function keyUpHandler(param1:KeyboardEvent) : void {
         if(!enabled)
         {
            return;
         }
         if(param1.keyCode == Keyboard.SPACE)
         {
            setMouseState(oldMouseState);
            oldMouseState = null;
            endPress();
            dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      public function get labelPlacement() : String {
         return _labelPlacement;
      }
      
      public function get toggle() : Boolean {
         return _toggle;
      }
      
      protected function setEmbedFont() : * {
         var _loc1_:Object = getStyleValue("embedFonts");
         if(_loc1_ != null)
         {
            textField.embedFonts = _loc1_;
         }
      }
      
      override public function get selected() : Boolean {
         return _toggle?_selected:false;
      }
      
      override protected function configUI() : void {
         super.configUI();
         textField = new TextField();
         textField.type = TextFieldType.DYNAMIC;
         textField.selectable = false;
         addChild(textField);
      }
      
      override protected function initializeAccessibility() : void {
         if(LabelButton.createAccessibilityImplementation != null)
         {
            LabelButton.createAccessibilityImplementation(this);
         }
      }
      
      public function set labelPlacement(param1:String) : void {
         _labelPlacement = param1;
         invalidate(InvalidationType.SIZE);
      }
      
      protected var mode:String = "center";
      
      protected function drawIcon() : void {
         var _loc1_:DisplayObject = icon;
         var _loc2_:String = enabled?mouseState:"disabled";
         if(selected)
         {
            _loc2_ = "selected" + _loc2_.substr(0,1).toUpperCase() + _loc2_.substr(1);
         }
         _loc2_ = _loc2_ + "Icon";
         var _loc3_:Object = getStyleValue(_loc2_);
         if(_loc3_ == null)
         {
            _loc3_ = getStyleValue("icon");
         }
         if(_loc3_ != null)
         {
            icon = getDisplayObjectInstance(_loc3_);
         }
         if(icon != null)
         {
            addChildAt(icon,1);
         }
         if(!(_loc1_ == null) && !(_loc1_ == icon))
         {
            removeChild(_loc1_);
         }
      }
      
      public function set label(param1:String) : void {
         _label = param1;
         if(textField.text != _label)
         {
            textField.text = _label;
            dispatchEvent(new ComponentEvent(ComponentEvent.LABEL_CHANGE));
         }
         invalidate(InvalidationType.SIZE);
         invalidate(InvalidationType.STYLES);
      }
      
      override protected function keyDownHandler(param1:KeyboardEvent) : void {
         if(!enabled)
         {
            return;
         }
         if(param1.keyCode == Keyboard.SPACE)
         {
            if(oldMouseState == null)
            {
               oldMouseState = mouseState;
            }
            setMouseState("down");
            startPress();
         }
      }
      
      public function set toggle(param1:Boolean) : void {
         if(!param1 && (super.selected))
         {
            selected = false;
         }
         _toggle = param1;
         if(_toggle)
         {
            addEventListener(MouseEvent.CLICK,toggleSelected,false,0,true);
         }
         else
         {
            removeEventListener(MouseEvent.CLICK,toggleSelected);
         }
         invalidate(InvalidationType.STATE);
      }
      
      protected var _labelPlacement:String = "right";
      
      protected var oldMouseState:String;
      
      protected var _label:String = "Label";
      
      override public function set selected(param1:Boolean) : void {
         _selected = param1;
         if(_toggle)
         {
            invalidate(InvalidationType.STATE);
         }
      }
      
      protected function drawTextFormat() : void {
         var _loc1_:Object = UIComponent.getStyleDefinition();
         var _loc2_:TextFormat = enabled?_loc1_.defaultTextFormat as TextFormat:_loc1_.defaultDisabledTextFormat as TextFormat;
         textField.setTextFormat(_loc2_);
         var _loc3_:TextFormat = getStyleValue(enabled?"textFormat":"disabledTextFormat") as TextFormat;
         if(_loc3_ != null)
         {
            textField.setTextFormat(_loc3_);
         }
         else
         {
            _loc3_ = _loc2_;
         }
         textField.defaultTextFormat = _loc3_;
         setEmbedFont();
      }
      
      protected var icon:DisplayObject;
      
      public function get label() : String {
         return _label;
      }
   }
}
