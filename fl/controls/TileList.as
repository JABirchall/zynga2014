package fl.controls
{
   import fl.managers.IFocusManagerComponent;
   import fl.controls.listClasses.ImageCell;
   import fl.core.InvalidationType;
   import flash.events.Event;
   import fl.controls.listClasses.ICellRenderer;
   import flash.utils.Dictionary;
   import flash.display.Sprite;
   import fl.core.UIComponent;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import fl.controls.listClasses.TileListData;
   import fl.controls.listClasses.ListData;
   import flash.ui.Keyboard;
   import fl.data.DataProvider;
   import fl.data.TileListCollectionItem;
   import flash.events.KeyboardEvent;
   
   public class TileList extends SelectableList implements IFocusManagerComponent
   {
      
      public function TileList() {
         super();
      }
      
      private static var defaultStyles:Object;
      
      public static var createAccessibilityImplementation:Function;
      
      public static function getStyleDefinition() : Object {
         return mergeStyles(defaultStyles,SelectableList.getStyleDefinition(),ScrollBar.getStyleDefinition());
      }
      
      public function get iconField() : String {
         return _iconField;
      }
      
      protected var _iconField:String = "icon";
      
      protected var _labelField:String = "label";
      
      public function set iconField(param1:String) : void {
         if(param1 == _iconField)
         {
            return;
         }
         _iconField = param1;
         invalidate(InvalidationType.DATA);
      }
      
      override public function set verticalScrollPolicy(param1:String) : void {
      }
      
      override protected function drawLayout() : void {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _horizontalScrollPolicy = _scrollDirection == ScrollBarDirection.HORIZONTAL?_scrollPolicy:ScrollPolicy.OFF;
         _verticalScrollPolicy = _scrollDirection != ScrollBarDirection.HORIZONTAL?_scrollPolicy:ScrollPolicy.OFF;
         if(_scrollDirection == ScrollBarDirection.HORIZONTAL)
         {
            _loc1_ = rowCount;
            contentHeight = _loc1_ * _rowHeight;
            contentWidth = _columnWidth * Math.ceil(length / _loc1_);
         }
         else
         {
            _loc2_ = columnCount;
            contentWidth = _loc2_ * _columnWidth;
            contentHeight = _rowHeight * Math.ceil(length / _loc2_);
         }
         super.drawLayout();
      }
      
      public function get columnWidth() : Number {
         return _columnWidth;
      }
      
      override public function scrollToIndex(param1:int) : void {
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         drawNow();
         var _loc2_:uint = Math.max(1,contentWidth / _columnWidth << 0);
         if(_scrollDirection == ScrollBarDirection.VERTICAL)
         {
            if(rowHeight > availableHeight)
            {
               return;
            }
            _loc3_ = (param1 / _loc2_ >> 0) * rowHeight;
            if(_loc3_ < verticalScrollPosition)
            {
               verticalScrollPosition = _loc3_;
            }
            else
            {
               if(_loc3_ > verticalScrollPosition + availableHeight - rowHeight)
               {
                  verticalScrollPosition = _loc3_ + rowHeight - availableHeight;
               }
            }
         }
         else
         {
            if(columnWidth > availableWidth)
            {
               return;
            }
            _loc4_ = param1 % _loc2_ * columnWidth;
            if(_loc4_ < horizontalScrollPosition)
            {
               horizontalScrollPosition = _loc4_;
            }
            else
            {
               if(_loc4_ > horizontalScrollPosition + availableWidth - columnWidth)
               {
                  horizontalScrollPosition = _loc4_ + columnWidth - availableWidth;
               }
            }
         }
      }
      
      public function get sourceFunction() : Function {
         return _sourceFunction;
      }
      
      public function get innerWidth() : Number {
         drawNow();
         var _loc1_:Number = getStyleValue("contentPadding") as Number;
         return width - _loc1_ * 2 - (_verticalScrollBar.visible?_verticalScrollBar.width:0);
      }
      
      protected function doKeySelection(param1:uint, param2:Boolean, param3:Boolean) : void {
         var _loc6_:uint = 0;
         var _loc7_:* = 0;
         var _loc4_:Array = selectedIndices;
         var _loc5_:* = false;
         if(!(param1 < 0 || param1 > length-1))
         {
            if((param2) && _loc4_.length > 0 && !(param1 == _loc4_[0]))
            {
               _loc6_ = _loc4_[0];
               _loc4_ = [];
               if(param1 < _loc6_)
               {
                  _loc7_ = _loc6_;
                  while(_loc7_ >= param1)
                  {
                     _loc4_.push(_loc7_);
                     _loc7_--;
                  }
               }
               else
               {
                  _loc7_ = _loc6_;
                  while(_loc7_ <= param1)
                  {
                     _loc4_.push(_loc7_);
                     _loc7_++;
                  }
               }
               _loc5_ = true;
            }
            else
            {
               _loc4_ = [param1];
               caretIndex = param1;
               _loc5_ = true;
            }
         }
         selectedIndices = _loc4_;
         if(_loc5_)
         {
            dispatchEvent(new Event(Event.CHANGE));
         }
         invalidate(InvalidationType.DATA);
      }
      
      protected function calculateAvailableHeight() : Number {
         var _loc1_:Number = Number(getStyleValue("contentPadding"));
         return height - _loc1_ * 2 - (_horizontalScrollPolicy == ScrollPolicy.ON || _horizontalScrollPolicy == ScrollPolicy.AUTO && _maxHorizontalScrollPosition > 0?15:0);
      }
      
      override protected function drawList() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      override protected function moveSelectionHorizontally(param1:uint, param2:Boolean, param3:Boolean) : void {
         var _loc4_:uint = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = undefined;
         _loc4_ = Math.ceil(Math.max(rowCount * columnCount,length) / rowCount);
         switch(param1)
         {
            case Keyboard.LEFT:
               _loc5_ = Math.max(0,selectedIndex-1);
               break;
            case Keyboard.RIGHT:
               _loc5_ = Math.min(length-1,selectedIndex + 1);
               break;
            case Keyboard.HOME:
               _loc5_ = 0;
               break;
            case Keyboard.END:
               _loc5_ = length-1;
               break;
            case Keyboard.PAGE_UP:
               _loc6_ = selectedIndex - selectedIndex % _loc4_;
               _loc5_ = Math.max(0,Math.max(_loc6_,selectedIndex - columnCount));
               break;
            case Keyboard.PAGE_DOWN:
               _loc7_ = selectedIndex - selectedIndex % _loc4_ + _loc4_-1;
               _loc5_ = Math.min(length-1,Math.min(_loc7_,selectedIndex + _loc4_));
               break;
         }
         
         doKeySelection(_loc5_,param2,param3);
         scrollToSelected();
      }
      
      public function get innerHeight() : Number {
         drawNow();
         var _loc1_:Number = getStyleValue("contentPadding") as Number;
         return height - _loc1_ * 2 - (_horizontalScrollBar.visible?_horizontalScrollBar.height:0);
      }
      
      override protected function moveSelectionVertically(param1:uint, param2:Boolean, param3:Boolean) : void {
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc4_:uint = Math.max(1,Math.max(contentHeight,availableHeight) / _rowHeight << 0);
         var _loc5_:uint = Math.ceil(Math.max(columnCount * rowCount,length) / _loc4_);
         var _loc6_:uint = Math.ceil(length / _loc5_);
         switch(param1)
         {
            case Keyboard.UP:
               _loc7_ = selectedIndex - _loc5_;
               break;
            case Keyboard.DOWN:
               _loc7_ = selectedIndex + _loc5_;
               break;
            case Keyboard.HOME:
               _loc7_ = 0;
               break;
            case Keyboard.END:
               _loc7_ = length-1;
               break;
            case Keyboard.PAGE_DOWN:
               _loc8_ = selectedIndex + _loc5_ * (_loc6_-1);
               if(_loc8_ >= length)
               {
                  _loc8_ = _loc8_ - _loc5_;
               }
               _loc7_ = Math.min(length-1,_loc8_);
               break;
            case Keyboard.PAGE_UP:
               _loc8_ = selectedIndex - _loc5_ * (_loc6_-1);
               if(_loc8_ < 0)
               {
                  _loc8_ = _loc8_ + _loc5_;
               }
               _loc7_ = Math.max(0,_loc8_);
               break;
         }
         
         doKeySelection(_loc7_,param2,param3);
         scrollToSelected();
      }
      
      public function get sourceField() : String {
         return _sourceField;
      }
      
      public function get rowHeight() : Number {
         return _rowHeight;
      }
      
      protected var _rowHeight:Number = 50;
      
      override public function get horizontalScrollPolicy() : String {
         return null;
      }
      
      protected var _cellRenderer:Object;
      
      override protected function initializeAccessibility() : void {
         if(TileList.createAccessibilityImplementation != null)
         {
            TileList.createAccessibilityImplementation(this);
         }
      }
      
      public function set sourceFunction(param1:Function) : void {
         _sourceFunction = param1;
         invalidate(InvalidationType.DATA);
      }
      
      public function set columnWidth(param1:Number) : void {
         if(_columnWidth == param1)
         {
            return;
         }
         _columnWidth = param1;
         invalidate(InvalidationType.SIZE);
      }
      
      public function set rowCount(param1:uint) : void {
         if(param1 == 0)
         {
            return;
         }
         if(componentInspectorSetting)
         {
            __rowCount = param1;
            return;
         }
         __rowCount = 0;
         var _loc2_:Number = Number(getStyleValue("contentPadding"));
         var _loc3_:* = (Math.ceil(length / param1) > width / columnWidth >> 0) && (_scrollPolicy == ScrollPolicy.AUTO) || (_scrollPolicy == ScrollPolicy.ON);
         height = rowHeight * param1 + 2 * _loc2_ + (_scrollDirection == ScrollBarDirection.HORIZONTAL && (_loc3_)?ScrollBar.WIDTH:0);
      }
      
      override public function itemToLabel(param1:Object) : String {
         if(_labelFunction != null)
         {
            return String(_labelFunction(param1));
         }
         if(param1[_labelField] == null)
         {
            return "";
         }
         return String(param1[_labelField]);
      }
      
      override protected function setVerticalScrollPosition(param1:Number, param2:Boolean=false) : void {
         invalidate(InvalidationType.SCROLL);
         super.setVerticalScrollPosition(param1,true);
      }
      
      public function set columnCount(param1:uint) : void {
         if(param1 == 0)
         {
            return;
         }
         if(componentInspectorSetting)
         {
            __columnCount = param1;
            return;
         }
         __columnCount = 0;
         var _loc2_:Number = Number(getStyleValue("contentPadding"));
         var _loc3_:Boolean = Math.ceil(length / param1) > height / rowHeight >> 0 && _scrollPolicy == ScrollPolicy.AUTO || _scrollPolicy == ScrollPolicy.ON;
         width = columnWidth * param1 + 2 * _loc2_ + (_scrollDirection == ScrollBarDirection.VERTICAL && (_loc3_)?15:0);
      }
      
      protected var __rowCount:uint = 0;
      
      protected var _sourceFunction:Function;
      
      override public function get dataProvider() : DataProvider {
         return super.dataProvider;
      }
      
      override public function set maxHorizontalScrollPosition(param1:Number) : void {
      }
      
      public function set sourceField(param1:String) : void {
         _sourceField = param1;
         invalidate(InvalidationType.DATA);
      }
      
      public function set rowHeight(param1:Number) : void {
         if(_rowHeight == param1)
         {
            return;
         }
         _rowHeight = param1;
         invalidate(InvalidationType.SIZE);
      }
      
      protected var _scrollPolicy:String = "auto";
      
      override public function set horizontalScrollPolicy(param1:String) : void {
      }
      
      override protected function draw() : void {
         if(direction == ScrollBarDirection.VERTICAL)
         {
            if(__rowCount > 0)
            {
               rowCount = __rowCount;
            }
            if(__columnCount > 0)
            {
               columnCount = __columnCount;
            }
         }
         else
         {
            if(__columnCount > 0)
            {
               columnCount = __columnCount;
            }
            if(__rowCount > 0)
            {
               rowCount = __rowCount;
            }
         }
         var _loc1_:* = !(oldLength == length);
         oldLength = length;
         if(isInvalid(InvalidationType.STYLES))
         {
            setStyles();
            drawBackground();
            if(contentPadding != getStyleValue("contentPadding"))
            {
               invalidate(InvalidationType.SIZE,false);
            }
            if(_cellRenderer != getStyleValue("cellRenderer"))
            {
               _invalidateList();
               _cellRenderer = getStyleValue("cellRenderer");
            }
         }
         if((isInvalid(InvalidationType.SIZE,InvalidationType.STATE)) || (_loc1_))
         {
            drawLayout();
         }
         if(isInvalid(InvalidationType.RENDERER_STYLES))
         {
            updateRendererStyles();
         }
         if(isInvalid(InvalidationType.STYLES,InvalidationType.SIZE,InvalidationType.DATA,InvalidationType.SCROLL,InvalidationType.SELECTED))
         {
            drawList();
            _maxHorizontalScrollPosition = Math.max(0,contentWidth - availableWidth);
         }
         updateChildren();
         validate();
      }
      
      public function set labelField(param1:String) : void {
         if(param1 == _labelField)
         {
            return;
         }
         _labelField = param1;
         invalidate(InvalidationType.DATA);
      }
      
      public function set scrollPolicy(param1:String) : void {
         if(!componentInspectorSetting && _scrollPolicy == param1)
         {
            return;
         }
         _scrollPolicy = param1;
         if(direction == ScrollBarDirection.HORIZONTAL)
         {
            _horizontalScrollPolicy = param1;
            _verticalScrollPolicy = ScrollPolicy.OFF;
         }
         else
         {
            _verticalScrollPolicy = param1;
            _horizontalScrollPolicy = ScrollPolicy.OFF;
         }
         invalidate(InvalidationType.SIZE);
      }
      
      protected var _iconFunction:Function;
      
      protected var _columnWidth:Number = 50;
      
      override public function get rowCount() : uint {
         var _loc1_:Number = Number(getStyleValue("contentPadding"));
         var _loc2_:uint = Math.max(1,(_width - 2 * _loc1_) / _columnWidth << 0);
         var _loc3_:uint = Math.max(1,(_height - 2 * _loc1_) / _rowHeight << 0);
         if(_scrollDirection == ScrollBarDirection.HORIZONTAL)
         {
            if(_scrollPolicy == ScrollPolicy.ON || _scrollPolicy == ScrollPolicy.AUTO && length > _loc2_ * _loc3_)
            {
               _loc3_ = Math.max(1,(_height - 2 * _loc1_ - 15) / _rowHeight << 0);
            }
         }
         else
         {
            _loc3_ = Math.max(1,Math.ceil((_height - 2 * _loc1_) / _rowHeight));
         }
         return _loc3_;
      }
      
      private var collectionItemImport:TileListCollectionItem;
      
      public function set labelFunction(param1:Function) : void {
         if(_labelFunction == param1)
         {
            return;
         }
         _labelFunction = param1;
         invalidate(InvalidationType.DATA);
      }
      
      public function get columnCount() : uint {
         var _loc1_:Number = Number(getStyleValue("contentPadding"));
         var _loc2_:uint = Math.max(1,(_width - 2 * _loc1_) / _columnWidth << 0);
         var _loc3_:uint = Math.max(1,(_height - 2 * _loc1_) / _rowHeight << 0);
         if(_scrollDirection != ScrollBarDirection.HORIZONTAL)
         {
            if(_scrollPolicy == ScrollPolicy.ON || _scrollPolicy == ScrollPolicy.AUTO && length > _loc2_ * _loc3_)
            {
               _loc2_ = Math.max(1,(_width - 2 * _loc1_ - 15) / _columnWidth << 0);
            }
         }
         else
         {
            _loc2_ = Math.max(1,Math.ceil((_width - 2 * _loc1_) / _columnWidth));
         }
         return _loc2_;
      }
      
      override protected function setHorizontalScrollPosition(param1:Number, param2:Boolean=false) : void {
         invalidate(InvalidationType.SCROLL);
         super.setHorizontalScrollPosition(param1,true);
      }
      
      override protected function configUI() : void {
         super.configUI();
         _horizontalScrollPolicy = scrollPolicy;
         _verticalScrollPolicy = ScrollPolicy.OFF;
      }
      
      override public function get maxHorizontalScrollPosition() : Number {
         drawNow();
         return _maxHorizontalScrollPosition;
      }
      
      public function get scrollPolicy() : String {
         return _scrollPolicy;
      }
      
      protected var _sourceField:String = "source";
      
      public function set iconFunction(param1:Function) : void {
         if(_iconFunction == param1)
         {
            return;
         }
         _iconFunction = param1;
         invalidate(InvalidationType.DATA);
      }
      
      public function get labelField() : String {
         return _labelField;
      }
      
      override protected function keyDownHandler(param1:KeyboardEvent) : void {
         var _loc2_:* = 0;
         param1.stopPropagation();
         if(!selectable)
         {
            return;
         }
         switch(param1.keyCode)
         {
            case Keyboard.UP:
            case Keyboard.DOWN:
               moveSelectionVertically(param1.keyCode,(param1.shiftKey) && (_allowMultipleSelection),(param1.ctrlKey) && (_allowMultipleSelection));
               break;
            case Keyboard.PAGE_UP:
            case Keyboard.PAGE_DOWN:
            case Keyboard.END:
            case Keyboard.HOME:
               if(_scrollDirection == ScrollBarDirection.HORIZONTAL)
               {
                  moveSelectionHorizontally(param1.keyCode,(param1.shiftKey) && (_allowMultipleSelection),(param1.ctrlKey) && (_allowMultipleSelection));
               }
               else
               {
                  moveSelectionVertically(param1.keyCode,(param1.shiftKey) && (_allowMultipleSelection),(param1.ctrlKey) && (_allowMultipleSelection));
               }
               break;
            case Keyboard.LEFT:
            case Keyboard.RIGHT:
               moveSelectionHorizontally(param1.keyCode,(param1.shiftKey) && (_allowMultipleSelection),(param1.ctrlKey) && (_allowMultipleSelection));
               break;
            default:
               _loc2_ = getNextIndexAtLetter(String.fromCharCode(param1.keyCode),selectedIndex);
               if(_loc2_ > -1)
               {
                  selectedIndex = _loc2_;
                  scrollToSelected();
               }
         }
         
      }
      
      public function get labelFunction() : Function {
         return _labelFunction;
      }
      
      public function get iconFunction() : Function {
         return _iconFunction;
      }
      
      protected var _scrollDirection:String = "horizontal";
      
      protected var oldLength:uint = 0;
      
      override public function get verticalScrollPolicy() : String {
         return null;
      }
      
      override public function set dataProvider(param1:DataProvider) : void {
         super.dataProvider = param1;
      }
      
      protected var __columnCount:uint = 0;
      
      protected var _labelFunction:Function;
      
      public function set direction(param1:String) : void {
         if(_scrollDirection == param1)
         {
            return;
         }
         _scrollDirection = param1;
         invalidate(InvalidationType.SIZE);
      }
      
      public function get direction() : String {
         return _scrollDirection;
      }
   }
}
