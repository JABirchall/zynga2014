package com.zynga.poker.popups.modules.PreSelectPopUp
{
   public class PreSelectPopUpViewWithoutLotto extends PreSelectPopUpView
   {
      
      public function PreSelectPopUpViewWithoutLotto() {
         super();
      }
      
      override protected function setup() : void {
         super.setup();
         if(preSelectPopUpContainer.goldBadge)
         {
            preSelectPopUpContainer.goldBadge.visible = false;
         }
         if(preSelectPopUpContainer.blueBadge)
         {
            preSelectPopUpContainer.blueBadge.visible = false;
         }
         if(preSelectPopUpContainer.lottoBadge)
         {
            preSelectPopUpContainer.lottoBadge.visible = false;
         }
         if(preSelectPopUpContainer.lottoButton)
         {
            preSelectPopUpContainer.lottoButton.visible = false;
         }
         progressTF.y = progressTF.y - 100;
         if(playerTextTF != null)
         {
            playerTextTF.y = playerTextTF.y - 100;
         }
         if(playerSubTextTF != null)
         {
            playerSubTextTF.y = playerSubTextTF.y - 100;
         }
         chicletContainer.y = chicletContainer.y - 100;
         chicletContainerMask.y = chicletContainerMask.y - 100;
         selectAll.y = selectAll.y - 100;
         if(sendRequest)
         {
            sendRequest.y = sendRequest.y - 100;
         }
         sendTF.y = sendTF.y - 100;
         preSelectPopUpContainer.whiteBG.y = preSelectPopUpContainer.whiteBG.y - 100;
         preSelectPopUpContainer.progressMeter.y = preSelectPopUpContainer.progressMeter.y - 100;
         preSelectPopUpContainer.blackBG.height = preSelectPopUpContainer.blackBG.height - 100;
         if(_sendMainButton)
         {
            _sendMainButton.y = _sendMainButton.y - 100;
         }
         if(preSelectPopUpContainer.featherBadge)
         {
            preSelectPopUpContainer.featherBadge.y = preSelectPopUpContainer.featherBadge.y - 100;
         }
         adjustPopUpWindowPosition(-100);
      }
   }
}
