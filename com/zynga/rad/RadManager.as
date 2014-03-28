package com.zynga.rad
{
   import com.zynga.rad.containers.layouts.VLayout;
   import com.zynga.rad.containers.layouts.VLeftLayout;
   import com.zynga.rad.containers.layouts.BaseLayout;
   import com.zynga.rad.containers.layouts.HBaseLayout;
   import com.zynga.rad.containers.layouts.HCenterLayout;
   import com.zynga.rad.containers.layouts.HReversibleCenterLayout;
   import com.zynga.rad.containers.layouts.HReversibleLayout;
   import com.zynga.rad.containers.layouts.HLayout;
   import com.zynga.rad.containers.layouts.SpacingData;
   import com.zynga.rad.lists.GridSkipList;
   import com.zynga.rad.lists.HStackList;
   import com.zynga.rad.lists.VStackList;
   import com.zynga.rad.containers.anchors.VCenterAnchor;
   import com.zynga.rad.containers.anchors.TopAnchor;
   import com.zynga.rad.containers.anchors.RightAnchor;
   import com.zynga.rad.containers.anchors.LeftAnchor;
   import com.zynga.rad.containers.anchors.HCenterAnchor;
   import com.zynga.rad.containers.anchors.BottomAnchor;
   import com.zynga.rad.containers.anchors.BaseAnchor;
   import com.zynga.rad.containers.anchors.StartAnchor;
   import com.zynga.rad.containers.anchors.EndAnchor;
   import com.zynga.rad.containers.anchors.DoNotIgnoreAnchor;
   import com.zynga.rad.containers.EmptyContainer;
   import com.zynga.rad.containers.text.HCenterTextContainer;
   import com.zynga.rad.containers.text.HFlowCenterTextContainer;
   import com.zynga.rad.containers.text.HFlowTextContainer;
   import com.zynga.rad.containers.text.HTextContainer;
   import com.zynga.rad.containers.text.HVTextContainer;
   import com.zynga.rad.containers.text.VTextContainer;
   import com.zynga.rad.containers.UnboundedContainer;
   import com.zynga.rad.containers.ZContainer;
   import com.zynga.rad.lists.ZComboBox;
   import com.zynga.rad.buttons.ZSelectableButton;
   import com.zynga.rad.buttons.ZToggleButton;
   import com.zynga.rad.buttons.ZTabButton;
   import com.zynga.rad.buttons.ZContainerButton;
   import com.zynga.rad.buttons.ZContainerTabButton;
   import com.zynga.rad.controls.sliders.ZCustomStepSliderControl;
   import com.zynga.rad.controls.sliders.ZHSliderControl;
   import com.zynga.rad.controls.sliders.ZVSliderControl;
   import com.zynga.rad.scrollbars.HScrollBar;
   import flash.display.Stage;
   
   public class RadManager extends Object
   {
      
      public function RadManager() {
         super();
      }
      
      public static var classReferences:Array = new Array(VLayout,VLeftLayout,BaseLayout,HBaseLayout,HCenterLayout,HReversibleCenterLayout,HReversibleLayout,HLayout,SpacingData,GridSkipList,HStackList,VStackList,VCenterAnchor,TopAnchor,RightAnchor,LeftAnchor,HCenterAnchor,BottomAnchor,BaseAnchor,StartAnchor,EndAnchor,DoNotIgnoreAnchor,EmptyContainer,HCenterTextContainer,HFlowCenterTextContainer,HFlowTextContainer,HTextContainer,HVTextContainer,VTextContainer,UnboundedContainer,ZContainer,ZComboBox,ZSelectableButton,ZToggleButton,ZTabButton,ZContainerButton,ZContainerTabButton,ZCustomStepSliderControl,ZHSliderControl,ZVSliderControl,HScrollBar);
      
      private static var m_instance:RadManager = null;
      
      public static function get instance() : RadManager {
         if(m_instance == null)
         {
            m_instance = new RadManager();
         }
         return m_instance;
      }
      
      private var stage:Stage = null;
      
      private var m_config:RadConfig = null;
      
      public function setConfig(param1:RadConfig) : void {
         if(param1)
         {
            this.m_config = param1;
         }
      }
      
      public function get config() : RadConfig {
         return this.m_config;
      }
   }
}
