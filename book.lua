 local wx = require("wx")
 require("COMPORT")


function panelBOOK()
    
	panelBook = wx.wxPanel(notebook, wx.wxID_ANY)
    sizerBC = wx.wxBoxSizer(wx.wxVERTICAL)

    ID_PN_BOOK			= 6000
    ID_BUTTON_book1		= 6031
	ID_SPIN				= 6032
    ID_BUTTON_BkRd		= 6033
    ID_BUTTON_BkWr		= 6034
    ID_BUTTON_BkFn		= 6035
	
	local btnSize = wx.wxSize( 80, 30)
	
	pnBook  = wx.wxStaticBox(panelBook, ID_PN_BOOK, "book", wx.wxPoint( 00, 20), wx.wxSize( 300, 200) )
	
    btnBook1 = wx.wxButton( pnBook, ID_BUTTON_book1, "info",
                          wx.wxPoint( 10, 15), btnSize )
    frame:Connect( ID_BUTTON_book1, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnBook1)	

    valueFont            = { wxfont = nil, size = 8, width = 0, height = 0 }
    spnBookPos = wx.wxSpinCtrl( pnBook, ID_SPIN, "1", wx.wxPoint( 10, 50), wx.wxSize( 60, 30) )
--	spnBookPos:SetFont(valueFont.wxfont)

    btnBookRead = wx.wxButton( pnBook, ID_BUTTON_BkRd, "read", wx.wxPoint( 100, 50), btnSize )
    frame:Connect( ID_BUTTON_BkRd, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnBookRead)	

    btnBookWrite = wx.wxButton( pnBook, ID_BUTTON_BkWr, "write",  wx.wxPoint( 200, 100), btnSize )
    frame:Connect( ID_BUTTON_BkWr, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnBookWrite)	

    btnBookFind = wx.wxButton( pnBook, ID_BUTTON_BkFn, "find",  wx.wxPoint( 10, 130), btnSize )
    frame:Connect( ID_BUTTON_BkFn, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnBookFind)	
	
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

    local pos = spnBookPos:GetValue()
	print ("--  book pos N"..pos)
	local phone = "+79037593592"
	local code = '129'
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


