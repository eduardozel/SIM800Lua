 local wx = require("wx")
 require("COMPORT")


function panelBOOK()
    
	panelBook = wx.wxPanel(notebook, wx.wxID_ANY)
    sizerBC = wx.wxBoxSizer(wx.wxVERTICAL)

    ID_PN_BOOK			= 6000
    ID_BUTTON_book1		= 6031


	local btnSize = wx.wxSize( 80, 30)
	
	pnBook  = wx.wxStaticBox(panelBook, ID_PN_BOOK, "book", wx.wxPoint( 00, 20), wx.wxSize( 300, 60) )
	
    btnBook1 = wx.wxButton( pnBook, ID_BUTTON_book1, "book",
                          wx.wxPoint( 10, 15), btnSize )
    frame:Connect( ID_BUTTON_book1, wx.wxEVT_COMMAND_BUTTON_CLICKED, OnBook1)	


-- ---
	
    notebook:AddPage(panelBook, "phone book")

end -- panelBOOK

-- Handle the button event

function OnBook1(event)

	print ("--  gprs")
	bl = 'AT+CPBS?'..'\r'
	openCOM_HOST()
	sendCOM_HOST( bl )
	local rpl = getRply()
	print ("?"..rpl)
	local rpl = getRply()
	print ("?"..rpl)
	closeCOM_HOST()
end -- OnBook1(event)
