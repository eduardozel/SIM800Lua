 local wx = require("wx")
 require("COMPORT")


function panelSMSsend()
    panelSMSsend = wx.wxPanel(notebook, wx.wxID_ANY)
    sizerBC = wx.wxBoxSizer(wx.wxVERTICAL)

    ID_BUTTON_FText		= 1034
    ID_BUTTON_NUM		= 1035
    ID_BUTTON_SMS		= 1036
	

    ID_CBOX_NUMBER		= 1051
    ID_TBOX_MSG			= 1052


	cZ					= string.char( 0x1A)

	
    btnFText = wx.wxButton( panelSMSsend, ID_BUTTON_FText, "set text",
                          wx.wxPoint( 00, 80), wx.wxSize(80,40) )
    frame:Connect( ID_BUTTON_FText, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnFText)	

-- -----
    btnNUM = wx.wxButton( panelSMSsend, ID_BUTTON_NUM, "set number",
                          wx.wxPoint( 340, 80), wx.wxSize(80,40) )
    frame:Connect( ID_BUTTON_NUM, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnNumber)	
	
	cbNUMBER = wx.wxComboBox( panelSMSsend, ID_CBOX_NUMBER, "chose phone", wx.wxPoint(100, 80), wx.wxSize(200, 20), {})--, wx.wxTE_PROCESS_ENTER )
	
	cbNUMBER:Append("+79037593592")
	cbNUMBER:Append("+79266607632")

	cbNUMBER:SetSelection( 0 )	

--    frame:Connect( ID_CBOX_NUMBER, wx.wxEVT_COMMAND_COMBOBOX_SELECTED, OnNumberChoose)	
--	btnNUM:Disable( true)

-- ---

    btnSMS = wx.wxButton( panelSMSsend, ID_BUTTON_SMS, "SMS", wx.wxPoint( 340, 120), wx.wxSize(80,40) )

	tbMSG = wx.wxTextCtrl( panelSMSsend, ID_TBOX_MSG, "enter mesage", wx.wxPoint(100, 120), wx.wxSize(200, 20), wx.wxTE_PROCESS_ENTER )

	
	frame:Connect( ID_BUTTON_SMS, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnSMS)	
	
	
    notebook:AddPage(panelSMSsend, "Send SMS")

end -- panelSMSsend

-- Handle the button event

function OnNumberChoose(event
)
	btnNUM:Disable( false)
end -- OnNumberChoose

function OnFText(event)

	print ("set text mode")
	openCOM_HOST()
	sendCOM_HOST( "AT+CMGF=1\r") -- text
	local rpl = getRply()
	print ("?"..rpl)
	closeCOM_HOST()
end -- OnFText(event)

function OnNumber(event)

	print ("set number")
    local pnumber = cbNUMBER:GetStringSelection()

	openCOM_HOST()
	strToHost("AT+CMGS=\"")
	strToHost( pnumber)
	strToHost( "\"\r" )
	
	local rpl = getRply()
	print ("?"..rpl)
	closeCOM_HOST()
end -- OnNumber(event)

function OnSMS(event)

	print ("send SMS")

    local msg = tbMSG:GetLineText(1)
	
	openCOM_HOST()
	sendCOM_HOST( msg )
	sendCOM_HOST(  cZ )

	local rpl = getRply()
	print ("?>"..rpl)
	closeCOM_HOST()
end -- OnSMS(event)
