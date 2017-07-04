 local wx = require("wx")
 require("COMPORT")


function panelGpGSM()
    panelGP = wx.wxPanel(notebook, wx.wxID_ANY)
    sizerBC = wx.wxBoxSizer(wx.wxVERTICAL)

    ID_BUTTON_Test		= 1010
	ID_LBL_ATOK			= 1009
    ID_BUTTON_Status	= 1011
	ID_LBL_STOK			= 1012
	
	ID_PN_OPSOS			= 1100

	ID_BUTTON_OpSIM		= 1101
	ID_BUTTON_Operator	= 1112
    ID_BUTTON_Operators	= 1113
    

	ID_BUTTON_Signal	= 1015

    ID_BUTTON_Reg		= 1020
    ID_BUTTON_CVal		= 1021

    ID_BUTTON_TestPIN	= 1001
    ID_BUTTON_SetPIN	= 1002
	ID_TBOX_CONSOLE		= 1005

	ID_LBL_PINOK		= 1006

	ID_PN_FUNC			= 1201
    ID_BUTTON_FUNC		= 1202
	ID_RG_EMODE			= 1203

	ID_PN_OTHERS		= 1300
    ID_BUTTON_IMEI		= 1301
	
	btnSize = wx.wxSize( 60, 30)
	chSize	= wx.wxSize(  6, 10)
	
-- -----------
    btnTest = wx.wxButton( panelGP, ID_BUTTON_Test, "TEST MODEM",
                          wx.wxPoint( 00, 20), wx.wxSize( 80, 30) )
    frame:Connect( ID_BUTTON_Test, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnTest)
	lblATOK = wx.wxStaticText(panelGP, ID_LBL_ATOK, "?", wx.wxPoint( 85, 25), chSize)
-- ---------
    btnTestPIN = wx.wxButton( panelGP, ID_BUTTON_TestPIN, "test PIN",
                          wx.wxPoint( 00, 50), wx.wxSize( 80, 30) )
    frame:Connect( ID_BUTTON_TestPIN, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnTestPIN)	
	
	lblPINOK = wx.wxStaticText(panelGP, ID_LBL_PINOK, "?", wx.wxPoint( 85, 60), chSize)

    btnSetPIN = wx.wxButton( panelGP, ID_BUTTON_SetPIN, "set PIN",
                          wx.wxPoint( 100, 50), wx.wxSize( 80, 30) )
    frame:Connect( ID_BUTTON_SetPIN, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnSetPIN)	
--	btnSetPIN:Disable( true)
-- ------
    btnStatus = wx.wxButton( panelGP, ID_BUTTON_Status, "status", wx.wxPoint( 00, 80), btnSize )
	lblSTOK = wx.wxStaticText(panelGP, ID_LBL_STOK, "?", wx.wxPoint( 85, 85), chSize)
						  
    frame:Connect( ID_BUTTON_Status, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnStatus)

-- ---------
    btnReg = wx.wxButton( panelGP, ID_BUTTON_Reg, "Registration",
                          wx.wxPoint( 00, 110), wx.wxSize( 80, 30) )
    frame:Connect( ID_BUTTON_Reg, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnRegistration)	
	
-- ---------

	pnOPSOS  = wx.wxStaticBox(panelGP, ID_PN_OPSOS, "operator", wx.wxPoint( 00, 140), wx.wxSize( 210, 60) )

	btnOpSIM =  wx.wxButton( pnOPSOS, ID_BUTTON_OpSIM, "SIM",
                          wx.wxPoint( 10, 15), btnSize )
    frame:Connect( ID_BUTTON_OpSIM, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnOpSIM)

						  
	btnOperator = wx.wxButton( pnOPSOS, ID_BUTTON_Operator, "current",
                          wx.wxPoint( 70, 15), btnSize )
    frame:Connect( ID_BUTTON_Operator, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnOperator)	

    btnOperators = wx.wxButton( pnOPSOS, ID_BUTTON_Operators, "list",
                          wx.wxPoint( 140, 15), btnSize )
    frame:Connect( ID_BUTTON_Operators, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnOperators)	

	-- ------------	
    btnSignal = wx.wxButton( panelGP, ID_BUTTON_Signal, "Signal",
                          wx.wxPoint( 00, 200), btnSize )
    frame:Connect( ID_BUTTON_Signal, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnSignal)	
	
-- -----

	pnFUNC  = wx.wxStaticBox(panelGP, ID_PN_FUNC, "functionality", wx.wxPoint( 00, 230), wx.wxSize( 210, 100) )

	rgFUNC	= wx.wxRadioBox(pnFUNC, ID_RG_EMODE, "", wx.wxPoint( 10, 15), wx.wxSize(  180, 40),
                            {"minimal", "normal", "flight"}, 3, -- 0.796, 1.02, 0.892 mA
                            wx.wxSUNKEN_BORDER)
	rgFUNC:SetSelection(1)
							
    btnCurVal = wx.wxButton( pnFUNC, ID_BUTTON_CVal, "get", wx.wxPoint( 10, 60), btnSize )
    frame:Connect( ID_BUTTON_CVal, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnGetFunctionality)	

    btnFUNC = wx.wxButton( pnFUNC, ID_BUTTON_FUNC, "set", wx.wxPoint( 100, 60), btnSize )
    frame:Connect( ID_BUTTON_FUNC, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnSetFunctionality)	
	
-- -----
	pnOTHERS = wx.wxStaticBox(panelGP, ID_PN_OTHERS, "others", wx.wxPoint( 00, 330), wx.wxSize( 210, 50) )
    btnIMEI = wx.wxButton( pnOTHERS, ID_BUTTON_IMEI, "IMEI", wx.wxPoint( 10, 15), btnSize )
    frame:Connect( ID_BUTTON_IMEI, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnGetIMEI )	
--

	tbCONSOLE = wx.wxTextCtrl( panelGP, ID_TBOX_CONSOLE, "+", wx.wxPoint(220, 20), wx.wxSize(240, 280), wx.wxTE_MULTILINE ) -- +wx.wxNO_BORDER
-- ---------	
    notebook:AddPage(panelGP, "general commands")

end -- panelGpGSM


function strToHost( msg )      
	for i = 1, string.len(msg) do
		sendCOM_HOST( string.sub( msg, i, i) )
	end -- for i
end -- strToHost

function getRply(
)
	local CR = string.char( 0x0D)

	local rd_len = 1
	local timeout = 40000
    local rp = ""

	local err, rply,  size = pHOST:read( rd_len, timeout )
    while not ( ( rply == "\n" ) or ( size == 0 )  ) do -- ( rply == "\n" ) or
	if ( CR ~= rply ) then
		rp = rp..rply
	end
	err, rply,  size = pHOST:read( rd_len, timeout )
	end -- while
	return rp
end -- getRply

-- Handle the button event

function OnTest(event)
	openCOM_HOST()
	strToHost("AT\n")
	local rpl = getRply()
	tbCONSOLE:AppendText(rpl.."\n")
	local rpl = getRply()
	tbCONSOLE:AppendText(rpl.."\n")
	if ( 'OK' == rpl ) then
		lblATOK:SetLabel("ok")
		lblATOK:SetBackgroundColour(wx.wxColour(0, 255, 0))
	end
	closeCOM_HOST()
end -- OnTest(event)

function OnStatus(event)
--	print ("modem")
	openCOM_HOST()
	strToHost("AT+CPAS\n")
	local rpl = getRply()
	tbCONSOLE:AppendText(rpl.."\n")
	local rpl = getRply()
	tbCONSOLE:AppendText(rpl.."\n")
	if ( '+CPAS: 0' == rpl ) then -- ready
		lblSTOK:SetLabel("ok")
		lblSTOK:SetBackgroundColour(wx.wxColour(0, 255, 0))
	elseif ( 'CPAS: 2' == rpl ) then -- unknown
	elseif ( 'CPAS: 3' == rpl ) then -- incomin call
	elseif ( 'CPAS: 4' == rpl ) then -- voice connect
	end
	closeCOM_HOST()
end -- OnStatus(event)
-- --------------------------
function OnTestPIN(event)
	openCOM_HOST()
	sendCOM_HOST( "AT+CPIN?\r")
	tbCONSOLE:AppendText("test pin".."\n")

	local rpl1 = getRply()
	local rpl2 = getRply() -- if no SIM no reply
	tbCONSOLE:AppendText( rpl2.."\n" )

	if ( "+CPIN: SIM PIN" == rpl2) then
--		btnSetPIN:Disable( false )
		lblPINOK:SetLabel("->")
	elseif ( rpl2 == "+CPIN: READY" ) then
		lblPINOK:SetLabel("ok")
		lblPINOK:SetBackgroundColour(wx.wxColour(0, 255, 0))
	else
		lblPINOK:SetLabel("xx")
	end
	local rpl3 = getRply() -- if no SIM no reply

	closeCOM_HOST()
end -- OnTestPIN(event)

function OnSetPIN(event)
	openCOM_HOST()
	sendCOM_HOST( "AT+CPIN=3592\r")
	tbCONSOLE:AppendText("set pin".."\n")
	
	local rpl1 = getRply() -- AT+CPIN=3592
	local rpl2 = getRply() -- 

	if ( "OK" == rpl2) then
		local rpl3 = getRply() -- +CPIN: READY
		local rpl4 = getRply() -- +Call Ready
		local rpl5 = getRply() -- +SMS Ready
	elseif ( rpl2 == "ERROR" ) then
	end

	closeCOM_HOST()
end -- OnTestPIN(event)

-- ---------------------------

function OnOpSIM(event)
	tbCONSOLE:AppendText("SIM operator".."\n")
	openCOM_HOST()
	strToHost( "AT+CSPN?\r")
	local rpl = getRply()
	tbCONSOLE:AppendText(rpl.."\n")
	local rpl = getRply()
	tbCONSOLE:AppendText(rpl.."\n")
	closeCOM_HOST()
end -- OnOpSIM(event)


function OnOperator(event)
	tbCONSOLE:AppendText("ask operator\n")
	openCOM_HOST()
	strToHost( "AT+COPS?\r")
	local rpl = getRply()
	tbCONSOLE:AppendText(rpl.."\n")
	local rpl = getRply()
	tbCONSOLE:AppendText(rpl.."\n")
	closeCOM_HOST()
end -- OnOperator(event)

function OnOperators(event)
	tbCONSOLE:AppendText("list operators".."\n")
	openCOM_HOST()
	sendCOM_HOST( "AT+COPS=?\r")
	local rpl = getRply()
	tbCONSOLE:AppendText(rpl.."\n")
	local rpl = getRply()
	tbCONSOLE:AppendText(rpl.."\n")
	closeCOM_HOST()
end -- OnOperator(event)

function OnSignal(event)
	tbCONSOLE:AppendText("read signal properties\n")
	openCOM_HOST()
	sendCOM_HOST( "AT+CSQ\r")
	local rp1 = getRply( )
	print ("?"..rp1)
	local rp2 = getRply()
	tbCONSOLE:AppendText(rp2.."\n")
	closeCOM_HOST()
end -- OnSignal(event)

function OnRegistration(event)
	tbCONSOLE:AppendText("read registration\n")
	openCOM_HOST()
	sendCOM_HOST( "AT+CREG?\r")
	local rpl = getRply()
	print ("?"..rpl)
	local rpl = getRply()
	tbCONSOLE:AppendText(rpl.."\n")
	closeCOM_HOST()
end -- OnRegistration(event)

-- ----------------------
function OnGetFunctionality(event)
	print ("currently value")
	openCOM_HOST()
	sendCOM_HOST( "AT+CFUN?\r")
	local rpl = getRply()
	print ("?"..rpl)
	local rpl = getRply()
	print ("+"..rpl)
	closeCOM_HOST()
end -- OnGetFunctionality(event)

function OnSetFunctionality(event)
	print ("functionality")
	openCOM_HOST()
	local emode = '0' -- minimum
	local sl = rgEMode:GetSelection()
	if ( 1 == sl) then -- full
		emode = '1' -- after set normal need check status
	elseif ( 2 == sl) then -- flight mode
		emode = '4' -- after set normal need check status
	end
	sendCOM_HOST( "AT+CFUN="..emode.."\r")
	local rpl = getRply()
	print ("?"..rpl)
	local rpl = getRply()
	print ("+"..rpl)
	closeCOM_HOST()
end -- OnSetFunctionality(event)
-- --------

function OnGetIMEI(event) -- 
	tbCONSOLE:AppendText("GetIMEI\n")
	openCOM_HOST()
	sendCOM_HOST( "AT+GSN\r")
	local rpl = getRply()
	print ("?"..rpl)
	local rpl = getRply()
	tbCONSOLE:AppendText(rpl.."\n")
	local rpl = getRply()
	tbCONSOLE:AppendText(rpl.."\n")
	local rpl = getRply()
	tbCONSOLE:AppendText(rpl.."\n")
	closeCOM_HOST()
end -- OnRegistration(event)


--