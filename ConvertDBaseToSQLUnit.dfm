object fmConvertDBaseToSQL: TfmConvertDBaseToSQL
  Left = 843
  Top = 121
  Width = 960
  Height = 931
  Caption = 'Convert DBase To SQL'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object gbx_DatabaseSettings: TxpGroupBox
    Left = 0
    Top = 30
    Width = 944
    Height = 213
    Align = alTop
    Caption = ' Settings: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    XPStyle.BorderColor = clSilver
    XPStyle.RoundedCorners = [rcTopLeft, rcTopRight, rcBottomLeft, rcBottomRight]
    XPStyle.BGStyle = bgsNone
    XPStyle.GradientStartColor = clWhite
    XPStyle.GradientEndColor = clSilver
    XPStyle.GradientFillDir = fdTopToBottom
    object Label1: TLabel
      Left = 12
      Top = 58
      Width = 58
      Height = 13
      Caption = 'SQL Server:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 12
      Top = 91
      Width = 73
      Height = 13
      Caption = 'SQL Database:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 12
      Top = 124
      Width = 84
      Height = 13
      Caption = 'DBase Database:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 12
      Top = 25
      Width = 72
      Height = 13
      Caption = 'UDL File Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 12
      Top = 157
      Width = 68
      Height = 13
      Caption = 'Extract Folder:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 12
      Top = 191
      Width = 66
      Height = 13
      Caption = 'Server Folder:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 411
      Top = 186
      Width = 54
      Height = 13
      Caption = 'Client ID:'
      Color = clBtnHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object cbxSQLDatabase: TxpComboBox
      Left = 99
      Top = 88
      Width = 250
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      Sorted = True
      TabOrder = 3
      XPStyle.ButtonWidth = 20
      XPStyle.ButtonStyle = cbsXP
      XPStyle.ActiveBorderColor = 12937777
      XPStyle.InActiveBorderColor = clBtnFace
      XPStyle.ActiveButtonColor = 15651521
      XPStyle.InActiveButtonColor = clBtnFace
      XPStyle.BGStartColor = clWhite
      XPStyle.BGEndColor = 15786689
      XPStyle.BGGradientFillDir = fdLeftToRight
      XPStyle.SelStartColor = 16755319
      XPStyle.SelEndColor = 15651521
      XPStyle.SelGradientFillDir = fdVerticalFromCenter
    end
    object gbx_LoginParameters: TxpGroupBox
      Left = 371
      Top = 17
      Width = 288
      Height = 92
      Caption = ' SQL Login Parameters:  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      XPStyle.BorderColor = clSilver
      XPStyle.RoundedCorners = [rcTopLeft, rcTopRight, rcBottomLeft, rcBottomRight]
      XPStyle.BGStyle = bgsNone
      XPStyle.GradientStartColor = clWhite
      XPStyle.GradientEndColor = clSilver
      XPStyle.GradientFillDir = fdTopToBottom
      object lb_SQLUser: TLabel
        Left = 29
        Top = 46
        Width = 25
        Height = 13
        Caption = 'User:'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lb_SQLPassword: TLabel
        Left = 29
        Top = 70
        Width = 49
        Height = 13
        Caption = 'Password:'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object cbUseSQLLogin: TxpCheckBox
        Left = 12
        Top = 19
        Width = 87
        Height = 17
        Caption = 'Use a Login:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        TabOrder = 0
        TabStop = True
        ShadowText = False
        Color = clBtnFace
        CheckColor = clBlue
        Alignment = cbaLeft
      end
      object edSQLUser: TxpEdit
        Left = 85
        Top = 42
        Width = 190
        Height = 21
        Alignment = taLeftJustify
        Rounded = True
        RoundRadius = 4
        ActiveFrameColor = clNavy
        InActiveFrameColor = clBtnShadow
        MarginLeft = 2
        MarginRight = 2
        Style = esXP
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object edSQLPassword: TxpEdit
        Left = 85
        Top = 66
        Width = 190
        Height = 21
        Alignment = taLeftJustify
        Rounded = True
        RoundRadius = 4
        ActiveFrameColor = clNavy
        InActiveFrameColor = clBtnShadow
        MarginLeft = 2
        MarginRight = 2
        Style = esXP
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 2
      end
    end
    object edSQLServer: TxpEdit
      Left = 99
      Top = 55
      Width = 250
      Height = 21
      Alignment = taLeftJustify
      Rounded = True
      RoundRadius = 4
      ActiveFrameColor = clNavy
      InActiveFrameColor = clBtnShadow
      MarginLeft = 2
      MarginRight = 2
      Style = esFlat
      TabOrder = 2
    end
    object cbxDBaseDatabase: TxpComboBox
      Left = 99
      Top = 121
      Width = 250
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      Sorted = True
      TabOrder = 4
      OnCloseUp = cbxDBaseDatabaseCloseUp
      XPStyle.ButtonWidth = 20
      XPStyle.ButtonStyle = cbsXP
      XPStyle.ActiveBorderColor = 12937777
      XPStyle.InActiveBorderColor = clBtnFace
      XPStyle.ActiveButtonColor = 15651521
      XPStyle.InActiveButtonColor = clBtnFace
      XPStyle.BGStartColor = clWhite
      XPStyle.BGEndColor = 15786689
      XPStyle.BGGradientFillDir = fdLeftToRight
      XPStyle.SelStartColor = 16755319
      XPStyle.SelEndColor = 15651521
      XPStyle.SelGradientFillDir = fdVerticalFromCenter
    end
    object cbCreateTableStructure: TxpCheckBox
      Left = 371
      Top = 115
      Width = 173
      Height = 17
      Caption = 'Drop \ Create Table Structure:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TabOrder = 6
      TabStop = True
      ShadowText = False
      Color = clBtnFace
      CheckColor = clBlue
      Checked = True
      Alignment = cbaLeft
    end
    object edUDLFileName: TxpEdit
      Left = 99
      Top = 23
      Width = 223
      Height = 21
      Alignment = taLeftJustify
      Rounded = True
      RoundRadius = 4
      ActiveFrameColor = clNavy
      InActiveFrameColor = clBtnShadow
      MarginLeft = 2
      MarginRight = 2
      Style = esFlat
      TabOrder = 0
    end
    object btnLocateUDL: TxpButton
      Left = 322
      Top = 21
      Width = 28
      Height = 25
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Gradient = True
      TabOrder = 1
      OnClick = btnLocateUDLClick
    end
    object cbCombineToNY: TxpCheckBox
      Left = 371
      Top = 137
      Width = 173
      Height = 17
      Caption = 'Combine to NY'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TabOrder = 7
      TabStop = True
      ShadowText = False
      Color = clBtnFace
      CheckColor = clBlue
      Checked = True
      Alignment = cbaLeft
    end
    object edExtractFolder: TxpEdit
      Left = 99
      Top = 154
      Width = 223
      Height = 21
      Alignment = taLeftJustify
      Rounded = True
      RoundRadius = 4
      ActiveFrameColor = clNavy
      InActiveFrameColor = clBtnShadow
      MarginLeft = 2
      MarginRight = 2
      Style = esFlat
      TabOrder = 8
    end
    object btnLocateExtractFolder: TxpButton
      Left = 322
      Top = 152
      Width = 28
      Height = 25
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Gradient = True
      TabOrder = 9
      OnClick = btnLocateExtractFolderClick
    end
    object edServerFolder: TxpEdit
      Left = 99
      Top = 187
      Width = 223
      Height = 21
      Alignment = taLeftJustify
      Rounded = True
      RoundRadius = 4
      ActiveFrameColor = clNavy
      InActiveFrameColor = clBtnShadow
      MarginLeft = 2
      MarginRight = 2
      Style = esFlat
      TabOrder = 10
    end
    object btnLocateServerFolder: TxpButton
      Left = 322
      Top = 185
      Width = 28
      Height = 25
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Gradient = True
      TabOrder = 11
      OnClick = btnLocateServerFolderClick
    end
    object cbUseRemoteLogging: TxpCheckBox
      Left = 371
      Top = 161
      Width = 173
      Height = 17
      Caption = 'Use Remote Logging'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TabOrder = 12
      TabStop = True
      ShadowText = False
      Color = clBtnFace
      CheckColor = clBlue
      Checked = True
      Alignment = cbaLeft
    end
    object edClientId: TxpEdit
      Left = 464
      Top = 183
      Width = 81
      Height = 21
      Alignment = taLeftJustify
      Rounded = True
      RoundRadius = 4
      ActiveFrameColor = clNavy
      InActiveFrameColor = clBtnShadow
      MarginLeft = 2
      MarginRight = 2
      Style = esFlat
      TabOrder = 13
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 871
    Width = 944
    Height = 22
    Align = alBottom
    Color = clWhite
    TabOrder = 1
    object ProgressBar: TProgressBar
      Left = 600
      Top = 1
      Width = 343
      Height = 20
      Align = alRight
      Smooth = True
      Step = 1
      TabOrder = 0
    end
    object pnlStatus: TPanel
      Left = 1
      Top = 1
      Width = 599
      Height = 20
      Align = alClient
      Color = clWhite
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 243
    Width = 600
    Height = 628
    Align = alClient
    Color = clWhite
    TabOrder = 2
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 598
      Height = 24
      Align = alTop
      Alignment = taLeftJustify
      Caption = 'Select Tables:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object cbxSelectTableFilter: TxpComboBox
        Left = 102
        Top = 1
        Width = 217
        Height = 22
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 16
        ParentFont = False
        Sorted = True
        TabOrder = 0
        Items.Strings = (
          'All Tables'
          'Billing Tables'
          'None'
          'Parcel Tables (All Years)')
        XPStyle.ButtonWidth = 20
        XPStyle.ButtonStyle = cbsXP
        XPStyle.ActiveBorderColor = 12937777
        XPStyle.InActiveBorderColor = clBtnFace
        XPStyle.ActiveButtonColor = 15651521
        XPStyle.InActiveButtonColor = clBtnFace
        XPStyle.BGStartColor = clWhite
        XPStyle.BGEndColor = 15786689
        XPStyle.BGGradientFillDir = fdLeftToRight
        XPStyle.SelStartColor = 16755319
        XPStyle.SelEndColor = 15651521
        XPStyle.SelGradientFillDir = fdVerticalFromCenter
      end
    end
    object lbxTables: TListBox
      Left = 1
      Top = 25
      Width = 598
      Height = 602
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      ItemHeight = 13
      MultiSelect = True
      Sorted = True
      TabOrder = 1
    end
  end
  object Panel3: TPanel
    Left = 600
    Top = 243
    Width = 344
    Height = 628
    Align = alRight
    BorderWidth = 1
    Color = clWhite
    TabOrder = 3
    object Panel5: TPanel
      Left = 2
      Top = 2
      Width = 340
      Height = 24
      Align = alTop
      Alignment = taLeftJustify
      Caption = 'Results:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object lbResults: TListBox
      Left = -23
      Top = 29
      Width = 340
      Height = 702
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      ItemHeight = 13
      TabOrder = 1
    end
  end
  object Panel6: TPanel
    Left = 0
    Top = 0
    Width = 944
    Height = 30
    Align = alTop
    Color = clWhite
    TabOrder = 4
    object btnLoad: TSpeedButton
      Left = 1
      Top = 1
      Width = 31
      Height = 28
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555555555555555555555555555555555555555555555555555555555555555
        555555555555555555555555555555555555555FFFFFFFFFF555550000000000
        55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
        B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
        000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
        555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
        55555575FFF75555555555700007555555555557777555555555555555555555
        5555555555555555555555555555555555555555555555555555}
      NumGlyphs = 2
      OnClick = btnLoadClick
    end
    object btnSave: TSpeedButton
      Left = 32
      Top = 1
      Width = 31
      Height = 28
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
        00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
        00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
        00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
        0003737FFFFFFFFF7F7330099999999900333777777777777733}
      NumGlyphs = 2
      OnClick = btnSaveClick
    end
    object btnTest: TSpeedButton
      Left = 63
      Top = 1
      Width = 31
      Height = 28
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333FF3FF3333333333CC30003333333333773777333333333C33
        3000333FF33337F33777339933333C3333333377F33337F3333F339933333C33
        33003377333337F33377333333333C333300333F333337F33377339333333C33
        3333337FF3333733333F33993333C33333003377FF33733333773339933C3333
        330033377FF73F33337733339933C33333333FF377F373F3333F993399333C33
        330077F377F337F33377993399333C33330077FF773337F33377399993333C33
        33333777733337F333FF333333333C33300033333333373FF7773333333333CC
        3000333333333377377733333333333333333333333333333333}
      NumGlyphs = 2
    end
    object btnRun: TSpeedButton
      Left = 94
      Top = 1
      Width = 31
      Height = 28
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337FF3333333333330003333333333333777F333333333333080333
        3333333F33777FF33F3333B33B000B33B3333373F777773F7333333BBB0B0BBB
        33333337737F7F77F333333BBB0F0BBB33333337337373F73F3333BBB0F7F0BB
        B333337F3737F73F7F3333BB0FB7BF0BB3333F737F37F37F73FFBBBB0BF7FB0B
        BBB3773F7F37337F377333BB0FBFBF0BB333337F73F333737F3333BBB0FBF0BB
        B3333373F73FF7337333333BBB000BBB33333337FF777337F333333BBBBBBBBB
        3333333773FF3F773F3333B33BBBBB33B33333733773773373333333333B3333
        333333333337F33333333333333B333333333333333733333333}
      NumGlyphs = 2
      OnClick = btnRunClick
    end
    object btnCancel: TSpeedButton
      Left = 126
      Top = 1
      Width = 31
      Height = 28
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
        3333333777333777FF3333993333339993333377FF3333377FF3399993333339
        993337777FF3333377F3393999333333993337F777FF333337FF993399933333
        399377F3777FF333377F993339993333399377F33777FF33377F993333999333
        399377F333777FF3377F993333399933399377F3333777FF377F993333339993
        399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
        99333773FF3333777733339993333339933333773FFFFFF77333333999999999
        3333333777333777333333333999993333333333377777333333}
      NumGlyphs = 2
    end
  end
  object dlgUDLFileLocate: TOpenDialog
    Filter = 'UDL|*.udl|All Files|*.*'
    Left = 473
    Top = 281
  end
  object dlgSaveIniFile: TSaveDialog
    DefaultExt = 'ini'
    Filter = '*.ini'
    InitialDir = 'C:\SCA\ConvertDBaseToSQL'
    Left = 216
    Top = 315
  end
  object dlgLoadIniFile: TOpenDialog
    DefaultExt = 'ini'
    Filter = '*.ini'
    InitialDir = 'C:\SCA\ConvertDBaseToSQL'
    Left = 336
    Top = 411
  end
end
