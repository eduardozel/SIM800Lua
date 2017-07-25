 local wx = require("wx")
 require("COMPORT")


function panelSMS()

    panelSMS = wx.wxPanel(notebook, wx.wxID_ANY)
    sizerBC = wx.wxBoxSizer(wx.wxVERTICAL)

    ID_PN_SMSSend		= 2001
    ID_PN_SMSReceive	= 2002

    ID_BUTTON_FText		= 2034

	ID_PN_NUM			= 2100
    ID_BUTTON_NUM		= 2101
    ID_CBOX_NUMBER		= 2102

	ID_PN_MSG			= 2200
    ID_BUTTON_SMS		= 2202
    ID_TBOX_MSG			= 2203

	
    ID_BUTTON_NoBrCast	= 2054
	ID_BUTTON_TxtMode	= 2055
	ID_BUTTON_SMSList	= 2056
	ID_BUTTON_SMSRead	= 2057
	ID_SPIN_SMS			= 2058

	cZ					= string.char( 0x1A)

-- -----
	
-- -----
	pnSMSSend  = wx.wxStaticBox(panelSMS, ID_PN_SMSSend, "send", wx.wxPoint( 15, 15), wx.wxSize( 350, 180) )	

	pnNUM = wx.wxStaticBox(pnSMSSend, ID_PN_NUM, "number", wx.wxPoint( 10, 15), wx.wxSize( 250, 50) )	

    local fontNUMBER = wx.wxFont(12, wx.wxFONTFAMILY_MODERN, wx.wxFONTSTYLE_ITALIC, wx.wxFONTWEIGHT_NORMAL, false, "Andale Mono") -- wxFONTWEIGHT_NORMAL
	cbNUMBER = wx.wxComboBox( pnNUM, ID_CBOX_NUMBER, "chose phone", wx.wxPoint( 10, 15), wx.wxSize( 150, 20), {})--, wx.wxTE_PROCESS_ENTER )
	cbNUMBER:SetFont(fontNUMBER)

    btnNUM = wx.wxButton( pnNUM, ID_BUTTON_NUM, "set number",  wx.wxPoint( 170, 15), btnSize )
    frame:Connect( ID_BUTTON_NUM, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnNumber)	
	

	cbNUMBER:Append("+79037593592")
	cbNUMBER:Append("+79266607632")

	cbNUMBER:SetSelection( 0 )	

--    frame:Connect( ID_CBOX_NUMBER, wx.wxEVT_COMMAND_COMBOBOX_SELECTED, OnNumberChoose)	
--	btnNUM:Disable( true)

-- ----
    btnFText = wx.wxButton( pnSMSSend, ID_BUTTON_FText, "text mode",  wx.wxPoint( 15, 75), btnSize )
    frame:Connect( ID_BUTTON_FText, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnFText)	

-- ---
	pnMSG = wx.wxStaticBox(pnSMSSend, ID_PN_MSG, "message", wx.wxPoint( 15, 115), wx.wxSize( 320, 50) )	

	tbMSG = wx.wxTextCtrl( pnMSG, ID_TBOX_MSG, "enter mesage", wx.wxPoint(10, 15), wx.wxSize(200, 20), wx.wxTE_PROCESS_ENTER )

	btnSMS = wx.wxButton( pnMSG, ID_BUTTON_SMS, "SMS", wx.wxPoint( 240, 15), btnSize )
	frame:Connect( ID_BUTTON_SMS, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnSMS)	
-- -----
	pnSMSReceive  = wx.wxStaticBox(panelSMS, ID_PN_SMSReceive, "receive", wx.wxPoint( 15, 200), wx.wxSize( 350, 180) )	

    btnNoBrCast = wx.wxButton( pnSMSReceive, ID_BUTTON_NoBrCast, "no broadcast",  wx.wxPoint( 15, 15), wx.wxSize( 150, 30) )
    frame:Connect( ID_BUTTON_NoBrCast, wx.wxEVT_COMMAND_BUTTON_CLICKED, SMSRead)	
	
    btnTextMode = wx.wxButton( pnSMSReceive, ID_BUTTON_TxtMode, "TextFormat",  wx.wxPoint( 170, 15), wx.wxSize( 80, 30) )
    frame:Connect( ID_BUTTON_TxtMode, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnTextMode)	

    SMSchoices = {"unread", "read", "unsent", "sent", "all"}
    checkListBoxSMS = wx.wxCheckListBox(pnSMSReceive, wx.wxID_ANY, wx.wxPoint( 15, 45), wx.wxSize( 100, 80), SMSchoices, wx.wxLB_MULTIPLE)


    btnSMSList = wx.wxButton( pnSMSReceive, ID_BUTTON_SMSList, "list",  wx.wxPoint( 120, 45), wx.wxSize( 80, 30) )
    frame:Connect( ID_BUTTON_SMSList, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnSMSList)	
	

    spnSMSPos = wx.wxSpinCtrl( pnSMSReceive, ID_SPIN_SMS, "1", wx.wxPoint( 120, 80), wx.wxSize( 60, 30) )
    spnSMSPos:SetToolTip("location number")

    btnSMSRead = wx.wxButton( pnSMSReceive, ID_BUTTON_SMSRead, "get",  wx.wxPoint( 200, 80), wx.wxSize( 80, 30) )
    frame:Connect( ID_BUTTON_SMSRead, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnSMSRead)	

    notebook:AddPage(panelSMS, "SMS")

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
-- -----------------
function SMSRead(event)
	print ("broadcast")
	openCOM_HOST()
	sendCOM_HOST( "AT+CSCB=1\r") -- not accepted.
	local rpl = getRply()
	print ("?"..rpl)
	local rpl = getRply()
	print ("?"..rpl)
	closeCOM_HOST()
end -- SMSRead(event)

function OnTextMode(event)
-- Max Response Time = -
	print ("Text mode")
	openCOM_HOST()
	sendCOM_HOST( "AT+CMGF=1\r") -- 
	local rpl = getRply()
	print ("?"..rpl)
	local rpl = getRply()
	print ("?"..rpl)
	closeCOM_HOST()
end -- OnTextMode(event)


function getSMSList( stat )
-- Max Response Time = -
	print ("OnSMSList = "..stat)
	openCOM_HOST()
	sendCOM_HOST( 'AT+CMGL="'..stat..'"\r') -- 
	local rpl = getRply()
	print ("?"..rpl)
	local rpl = getRply()
	print ("?"..rpl)
	local rpl = getRply()
	print ("?"..rpl)
	closeCOM_HOST()
end -- getSMSList

function OnSMSList(event)
	if ( checkListBoxSMS:IsChecked(0) ) then
		getSMSList('REC UNREAD')
	end
	if ( checkListBoxSMS:IsChecked(1) ) then
		getSMSList('REC READ')
	end
end -- OnSMSList(event)

function OnSMSRead(event)
-- Max Response Time = -
    local pos = spnSMSPos:GetValue()
	print ("SMS get "..pos)

	openCOM_HOST()
	sendCOM_HOST( 'AT+CMGR='..pos..'\r') -- 
	local rpl = getRply()
	print ("?"..rpl)
	local rpl = getRply()
	print ("+"..rpl) -- OK
	if ( rpl == "OK" ) then
	print ("No such SMS")
	else
		local rpl = getRply()
		print ("!"..rpl)
	end
	closeCOM_HOST()
end -- OnSMSRead(event)


