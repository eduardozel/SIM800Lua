 local wx = require("wx")
 require("COMPORT")


function panelPHONE()

    panelPHON = wx.wxPanel(notebook, wx.wxID_ANY)
    sizerBC = wx.wxBoxSizer(wx.wxVERTICAL)

    ID_PN_BUSY			= 4001
    ID_BUTTON_BUSY		= 4034

-- ----
	pnBUSY = wx.wxStaticBox(panelPHON, ID_PN_BUSY, "busy", wx.wxPoint( 10, 10), wx.wxSize( 320, 50) )	

    btnBUSY = wx.wxButton( pnBUSY, ID_BUTTON_BUSY, "busy",  wx.wxPoint( 15, 10), btnSize )
    frame:Connect( ID_BUTTON_BUSY, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnBUSY)	
	
    notebook:AddPage(panelPHON, "phone")

end -- panelPHONE

-- Handle the button event

function OnBUSY(event)
	print ("busy")
	openCOM_HOST()
	sendCOM_HOST( "AT+GSMBUSY=1\r") -- Forbid all incoming calls
	local rpl = getRply()
	print ("?"..rpl)
	local rpl = getRply()
	print ("?"..rpl)
	closeCOM_HOST()
end -- OnBUSY(event)
