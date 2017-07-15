 local wx = require("wx")
 require("COMPORT")


function panelGPRS()
    
	panelGPRS = wx.wxPanel(notebook, wx.wxID_ANY)
    sizerBC = wx.wxBoxSizer(wx.wxVERTICAL)

    ID_PN_GPRS			= 3000
    ID_BUTTON_GPRS1		= 3031

    ID_BUTTON_GPRSconn	= 3034
    ID_BUTTON_GPRSdisc	= 3035

	
	local btnSize = wx.wxSize( 80, 30)
	
	pnGPRS  = wx.wxStaticBox(panelGPRS, ID_PN_GPRS, "GPRS", wx.wxPoint( 00, 20), wx.wxSize( 300, 60) )
	
    btnGPRS1 = wx.wxButton( pnGPRS, ID_BUTTON_GPRS1, "login",
                          wx.wxPoint( 10, 15), btnSize )
    frame:Connect( ID_BUTTON_GPRS1, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnGPRS1)	

    btnGPRSconnect = wx.wxButton( pnGPRS, ID_BUTTON_GPRSconn, "connect",
                          wx.wxPoint( 100, 15), btnSize )
    frame:Connect( ID_BUTTON_GPRSconn, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnGPRSconnect)	

    btnGPRSdisc = wx.wxButton( pnGPRS, ID_BUTTON_GPRSdisc, "disconnect",
                          wx.wxPoint( 190, 15), btnSize )
    frame:Connect( ID_BUTTON_GPRSdisc, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnGPRSdisconnectconnect)	
	
-- ---
	
    notebook:AddPage(panelGPRS, "GPRS")

end -- panelGPRS

-- Handle the button event

function OnGPRS1(event)

	OPSOS = 'beeline'
	print ("--  gprs")
	protocol = ''
	protocol = protocol..'AT+SAPBR=3,1, "CONTYPE", "GPRS"'
	protocol = protocol..';+SAPBR=3,1, "APN", "internet.'..OPSOS..'.ru"' -- access point name
	protocol = protocol..';+SAPBR=3,1, "USER", "'..OPSOS..'"'
	protocol = protocol..';+SAPBR=3,1, "PWD", "'..OPSOS..'"'
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
	sendCOM_HOST( 'AT+SAPBR=1,1\r')
	local rpl = getRply()
	print (">"..rpl)
	local rpl = getRply()
	print ("?"..rpl)
	closeCOM_HOST()
end -- OnGPRSconnect(event)

function OnGPRSdisconnectconnect(event)
	print ("disconnect")
	openCOM_HOST()
	sendCOM_HOST( 'AT+SAPBR=0,1\r')
	local rpl = getRply()
	print (">"..rpl)
	local rpl = getRply()
	print ("?"..rpl)
	closeCOM_HOST()
end -- OnGPRSdisconnectconnect(event)
