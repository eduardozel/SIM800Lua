 require("gpGSM")
 require("SMS")
 require("GPRS")
 require("phone")


 local wx = require("wx")


    frame = wx.wxFrame( wx.NULL, wx.wxID_ANY, "Test gsm modem"
                                 , wx.wxDefaultPosition, wx.wxSize( 500, 470)
                                 , wx.wxDEFAULT_FRAME_STYLE)

    frame:Show(true)
    frame:CreateStatusBar(1)
    notebook = wx.wxNotebook(frame, wx.wxID_ANY,
                                   wx.wxDefaultPosition, wx.wxDefaultSize)
                                   --wx.wxNB_BOTTOM)

    panelGpGSM()
    panelSMS()
    panelGPRS()
    panelPHONE()


wx.wxGetApp():MainLoop()
