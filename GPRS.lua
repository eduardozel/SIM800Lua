 local wx = require("wx")
 require("COMPORT")


function panelGPRS()
    
	panelGPRS = wx.wxPanel(notebook, wx.wxID_ANY)
    sizerBC = wx.wxBoxSizer(wx.wxVERTICAL)

    ID_BUTTON_GPRS1		= 3031
    ID_BUTTON_GPRS2		= 3032
    ID_BUTTON_GPRSlogin	= 3033

    ID_BUTTON_GPRSconnect = 3034

	
	local btnSize = wx.wxSize( 80, 30)
	
    btnGPRS1 = wx.wxButton( panelGPRS, ID_BUTTON_GPRS1, "GPRS",
                          wx.wxPoint( 00, 20), btnSize )
    frame:Connect( ID_BUTTON_GPRS1, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnGPRS1)	

    btnGPRSconnect = wx.wxButton( panelGPRS, ID_BUTTON_GPRSconnect, "connect",
                          wx.wxPoint( 00, 60), btnSize )
    frame:Connect( ID_BUTTON_GPRSconnect, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnGPRSconnect)	
	
-- ---
	
    notebook:AddPage(panelGPRS, "GPRS")

end -- panelGPRS

-- Handle the button event

function OnGPRS1(event)
	print ("--  gprs")
	protocol = ''
	protocol = protocol..'AT+SAPBR=3,1, "CONTYPE", "GPRS"'
	protocol = protocol..';+SAPBR=3,1, "APN", "internet.beeline.ru"'
	protocol = protocol..';+SAPBR=3,1, "USER", "beeline"'
	protocol = protocol..';+SAPBR=3,1, "PWD", "beeline"'
	protocol = protocol..'\r'
	openCOM_HOST()
	sendCOM_HOST( protocol )
	local rpl = getRply()
	print ("?"..rpl)
	local rpl = getRply()
	print ("?"..rpl)
	closeCOM_HOST()
end -- OnFText(event)

function OnGPRSconnect(event)
	print ("connect")
	openCOM_HOST()
	sendCOM_HOST( 'AT+SAPBR=1,1\r') -- text
	local rpl = getRply()
	print (">"..rpl)
	local rpl = getRply()
	print ("?"..rpl)
	closeCOM_HOST()
end -- OnGPRSconnect(event)

