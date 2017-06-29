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

    btnGPRS2 = wx.wxButton( panelGPRS, ID_BUTTON_GPRS2, "mts",
                          wx.wxPoint( 00, 60), btnSize )
    frame:Connect( ID_BUTTON_GPRS2, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnGPRS2)	

    btnGPRSlogin = wx.wxButton( panelGPRS, ID_BUTTON_GPRSlogin, "login",
                          wx.wxPoint( 00, 100), btnSize )
    frame:Connect( ID_BUTTON_GPRSlogin, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnGPRSlogin)	

    btnGPRSconnect = wx.wxButton( panelGPRS, ID_BUTTON_GPRSconnect, "connect",
                          wx.wxPoint( 00, 170), btnSize )
    frame:Connect( ID_BUTTON_GPRSconnect, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnGPRSconnect)	
	
-- ---
	
    notebook:AddPage(panelGPRS, "GPRS")

end -- panelGPRS

-- Handle the button event


function OnGPRS1(event)
	print ("--  gprs1")
	openCOM_HOST()
	sendCOM_HOST( 'AT+SAPBR=3,1, "CONTYPE", "GPRS"\r') -- text
	local rpl = getRply()
	print ("?"..rpl)
	local rpl = getRply()
	print ("?"..rpl)
	closeCOM_HOST()
end -- OnFText(event)

function OnGPRS2(event)
	print ("--  gprs1")
	openCOM_HOST()
	sendCOM_HOST( 'AT+SAPBR=3,1, "APN", "internet.mts.ru"\r') -- text
	local rpl = getRply()
	print (">"..rpl)
	local rpl = getRply()
	print ("?"..rpl)
	closeCOM_HOST()
end -- OnGPRS2

function OnGPRSlogin(event)
	print ("--  login")
	openCOM_HOST()
	sendCOM_HOST( 'AT+SAPBR=3,1, "USER", "mts"\r') -- text
	local rpl = getRply()
	print (">"..rpl)
	local rpl = getRply()
	print ("?"..rpl)
	sendCOM_HOST( 'AT+SAPBR=3,1, "PWD", "mts"\r') -- text
	local rpl = getRply()
	print (">"..rpl)
	local rpl = getRply()
	print ("?"..rpl)
	closeCOM_HOST()
end -- OnGPRSlogin

function OnGPRSconnect(event)
	print ("--  connect")
	openCOM_HOST()
	sendCOM_HOST( 'AT+SAPBR=1,1r') -- text
	local rpl = getRply()
	print (">"..rpl)
	local rpl = getRply()
	print ("?"..rpl)
	closeCOM_HOST()
end -- OnGPRSconnect(event)

