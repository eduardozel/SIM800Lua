 local wx = require("wx")
 require("COMPORT")


function panelBOOK()
    
	panelBook = wx.wxPanel(notebook, wx.wxID_ANY)
    sizerBC = wx.wxBoxSizer(wx.wxVERTICAL)

    ID_PN_BOOK			= 6000
    ID_BUTTON_BkInfo	= 6031
    ID_BUTTON_BkStorage	= 6032

	ID_SPIN				= 6035
    ID_BUTTON_BkRd		= 6036
    ID_BUTTON_BkWr		= 6037
    ID_BUTTON_BkClr		= 6038
    ID_BUTTON_BkFnd		= 6039
	
	local btnSize = wx.wxSize( 80, 30)
	
	pnBook  = wx.wxStaticBox(panelBook, ID_PN_BOOK, "book", wx.wxPoint( 00, 20), wx.wxSize( 300, 200) )
	
    btnBook1 = wx.wxButton( pnBook, ID_BUTTON_BkInfo, "info",  wx.wxPoint( 10, 15), btnSize )
    frame:Connect( ID_BUTTON_BkInfo, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnBook1)	

    btnBookStorage = wx.wxButton( pnBook, ID_BUTTON_BkStorage, "storage > SIM",  wx.wxPoint( 100, 15), btnSize )
    frame:Connect( ID_BUTTON_BkStorage, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnBookStorage)	
	
    fontItalic = wx.wxFont(14, wx.wxFONTFAMILY_MODERN, wx.wxFONTSTYLE_ITALIC, wx.wxFONTWEIGHT_BOLD, false, "Andale Mono") -- wxFONTWEIGHT_NORMAL

    spnBookPos = wx.wxSpinCtrl( pnBook, ID_SPIN, "1", wx.wxPoint( 10, 50), wx.wxSize( 60, 30) )
    spnBookPos:SetToolTip("location number")

	spnBookPos:SetFont(fontItalic)
--	spnBookPos:SetAlignmant(wx.wxALIGN_RIGHT)
	
    btnBookRead = wx.wxButton( pnBook, ID_BUTTON_BkRd, "read", wx.wxPoint( 100, 50), btnSize )
    frame:Connect( ID_BUTTON_BkRd, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnBookRead)	

    btnBookWrite = wx.wxButton( pnBook, ID_BUTTON_BkWr, "write",  wx.wxPoint( 200, 100), btnSize )
    frame:Connect( ID_BUTTON_BkWr, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnBookWrite)	


    btnBookClear = wx.wxButton( pnBook, ID_BUTTON_BkClr, "clear",  wx.wxPoint( 10, 130), btnSize )
    frame:Connect( ID_BUTTON_BkClr, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnBookClr)	


    btnBookFind = wx.wxButton( pnBook, ID_BUTTON_BkFnd, "find",  wx.wxPoint( 10, 160), btnSize )
    frame:Connect( ID_BUTTON_BkFnd, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnBookFind)	
	
-- ---
	
    notebook:AddPage(panelBook, "phone book")

end -- panelBOOK

-- Handle the button event

function OnBook1(event)

	print ("--  book info")
	bl = 'AT+CPBS?'..'\r'
	openCOM_HOST()
	sendCOM_HOST( bl )
	local rpl = getRply()
	print ("?"..rpl)
	local rpl = getRply()
	print ("?"..rpl)

--	spnBookPos:SetMax( 30 )
	closeCOM_HOST()
end -- OnBook1(event)

function OnBookStorage(event)
	print ("--  book storage")
	local storage = "SM"
	bl = 'AT+CPBS="'..storage..'"\r'
	openCOM_HOST()
	sendCOM_HOST( bl )
	local rpl = getRply()
	print ("?"..rpl)
	local rpl = getRply()
	print ("?"..rpl)

	closeCOM_HOST()
end -- OnBookStorage(event)



function OnBookRead(event)

    local pos = spnBookPos:GetValue()
	print ("--  book pos N"..pos)
	bl = 'AT+CPBR='..pos..'\r'
	openCOM_HOST()
	sendCOM_HOST( bl )
	local rpl = getRply()
	print ("?"..rpl)
	local rpl = getRply()
	print ("?"..rpl)
	closeCOM_HOST()
end -- OnBookRead(event)


function OnBookWrite(event)
-- Max Response = 3 seconds
    local pos = spnBookPos:GetValue()
	print ("--  write book pos N"..pos)
	local phone = "+79037593592"
	local code = '129' -- national number type
	local pname = 'eduardo'
	bl = 'AT+CPBW='..pos..',"'..phone..'",'..code..',"'..pname..'"\r'
	openCOM_HOST()
	sendCOM_HOST( bl )
	local rpl = getRply()
	print ("?"..rpl)
	local rpl = getRply()
	print ("?"..rpl)
	closeCOM_HOST()
end -- OnBookWrite(event)

function OnBookClr(event)
    local pos = spnBookPos:GetValue()
	print ("--  remove book pos N"..pos)
	bl = 'AT+CPBW='..pos..'\r'
	openCOM_HOST()
	sendCOM_HOST( bl )
	local rpl = getRply()
	print ("?"..rpl)
	local rpl = getRply()
	print ("?"..rpl)
	closeCOM_HOST()
end -- OnBookClr(event)



function OnBookFind(event)

    local pos = spnBookPos:GetValue()
	print ("--  book pos N"..pos)
	local pname = 'eduardo'
	bl = 'AT+CPBF="'..pname..'"\r'
	openCOM_HOST()
	sendCOM_HOST( bl )
	local rpl = getRply()
	print ("?"..rpl)
	local rpl = getRply()
	print ("?"..rpl)
	closeCOM_HOST()
end -- OnBookFind(event)


