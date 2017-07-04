 local wx = require("wx")
 require("COMPORT")


function panelSMS()

    panelSMS = wx.wxPanel(notebook, wx.wxID_ANY)
    sizerBC = wx.wxBoxSizer(wx.wxVERTICAL)

    ID_BUTTON_NoBrCast	= 2054

    ID_BUTTON_FText		= 2034

	ID_PN_NUM			= 2100
    ID_BUTTON_NUM		= 2101
    ID_CBOX_NUMBER		= 2102

	ID_PN_MSG			= 2200
    ID_BUTTON_SMS		= 2202
    ID_TBOX_MSG			= 2203


	cZ					= string.char( 0x1A)

	

    btnNoBrCast = wx.wxButton( panelSMS, ID_BUTTON_NoBrCast, "no broadcast",  wx.wxPoint( 10, 15), btnSize )
    frame:Connect( ID_BUTTON_NoBrCast, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnBrCast)	
	
-- -----
	pnNUM = wx.wxStaticBox(panelSMS, ID_PN_NUM, "number", wx.wxPoint( 10, 50), wx.wxSize( 220, 50) )	

	cbNUMBER = wx.wxComboBox( pnNUM, ID_CBOX_NUMBER, "chose phone", wx.wxPoint( 10, 15), wx.wxSize( 130, 20), {})--, wx.wxTE_PROCESS_ENTER )

    btnNUM = wx.wxButton( pnNUM, ID_BUTTON_NUM, "set number",  wx.wxPoint( 150, 10), btnSize )
    frame:Connect( ID_BUTTON_NUM, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnNumber)	
	

	cbNUMBER:Append("+79037593592")
	cbNUMBER:Append("+79266607632")

	cbNUMBER:SetSelection( 0 )	

--    frame:Connect( ID_CBOX_NUMBER, wx.wxEVT_COMMAND_COMBOBOX_SELECTED, OnNumberChoose)	
--	btnNUM:Disable( true)

-- ----
    btnFText = wx.wxButton( panelSMS, ID_BUTTON_FText, "text mode",  wx.wxPoint( 15, 110), btnSize )
    frame:Connect( ID_BUTTON_FText, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnFText)	

-- ---
	pnMSG = wx.wxStaticBox(panelSMS, ID_PN_MSG, "message", wx.wxPoint( 10, 180), wx.wxSize( 320, 50) )	

	tbMSG = wx.wxTextCtrl( pnMSG, ID_TBOX_MSG, "enter mesage", wx.wxPoint(10, 15), wx.wxSize(200, 20), wx.wxTE_PROCESS_ENTER )

	btnSMS = wx.wxButton( pnMSG, ID_BUTTON_SMS, "SMS", wx.wxPoint( 240, 15), btnSize )


	
	frame:Connect( ID_BUTTON_SMS, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnSMS)	
	
	
    notebook:AddPage(panelSMS, "Send SMS")

end -- panelSMSsend

-- Handle the button event

function OnNumberChoose(event
)
	btnNUM:Disable( false)
end -- OnNumberChoose

function OnBrCast(event)
	print ("broadcast")
	openCOM_HOST()
	sendCOM_HOST( "AT+CSCB=1\r") -- not accepted.
	local rpl = getRply()
	print ("?"..rpl)
	local rpl = getRply()
	print ("?"..rpl)
	closeCOM_HOST()
end -- OnBrCast(event)


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
