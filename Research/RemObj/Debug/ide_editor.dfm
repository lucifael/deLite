object editor: Teditor
  Left = 234
  Top = 166
  Width = 696
  Height = 480
  Caption = 'Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClick = FormClick
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 346
    Width = 688
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object ed: TSynEdit
    Left = 0
    Top = 0
    Width = 688
    Height = 346
    Cursor = crIBeam
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 0
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Terminal'
    Gutter.Font.Style = []
    Highlighter = pashighlighter
    Keystrokes = <
      item
        Command = ecUp
        ShortCut = 38
      end
      item
        Command = ecSelUp
        ShortCut = 8230
      end
      item
        Command = ecScrollUp
        ShortCut = 16422
      end
      item
        Command = ecDown
        ShortCut = 40
      end
      item
        Command = ecSelDown
        ShortCut = 8232
      end
      item
        Command = ecScrollDown
        ShortCut = 16424
      end
      item
        Command = ecLeft
        ShortCut = 37
      end
      item
        Command = ecSelLeft
        ShortCut = 8229
      end
      item
        Command = ecWordLeft
        ShortCut = 16421
      end
      item
        Command = ecSelWordLeft
        ShortCut = 24613
      end
      item
        Command = ecRight
        ShortCut = 39
      end
      item
        Command = ecSelRight
        ShortCut = 8231
      end
      item
        Command = ecWordRight
        ShortCut = 16423
      end
      item
        Command = ecSelWordRight
        ShortCut = 24615
      end
      item
        Command = ecPageDown
        ShortCut = 34
      end
      item
        Command = ecSelPageDown
        ShortCut = 8226
      end
      item
        Command = ecPageBottom
        ShortCut = 16418
      end
      item
        Command = ecSelPageBottom
        ShortCut = 24610
      end
      item
        Command = ecPageUp
        ShortCut = 33
      end
      item
        Command = ecSelPageUp
        ShortCut = 8225
      end
      item
        Command = ecPageTop
        ShortCut = 16417
      end
      item
        Command = ecSelPageTop
        ShortCut = 24609
      end
      item
        Command = ecLineStart
        ShortCut = 36
      end
      item
        Command = ecSelLineStart
        ShortCut = 8228
      end
      item
        Command = ecEditorTop
        ShortCut = 16420
      end
      item
        Command = ecSelEditorTop
        ShortCut = 24612
      end
      item
        Command = ecLineEnd
        ShortCut = 35
      end
      item
        Command = ecSelLineEnd
        ShortCut = 8227
      end
      item
        Command = ecEditorBottom
        ShortCut = 16419
      end
      item
        Command = ecSelEditorBottom
        ShortCut = 24611
      end
      item
        Command = ecToggleMode
        ShortCut = 45
      end
      item
        Command = ecCopy
        ShortCut = 16429
      end
      item
        Command = ecCut
        ShortCut = 8238
      end
      item
        Command = ecPaste
        ShortCut = 8237
      end
      item
        Command = ecDeleteChar
        ShortCut = 46
      end
      item
        Command = ecDeleteLastChar
        ShortCut = 8
      end
      item
        Command = ecDeleteLastChar
        ShortCut = 8200
      end
      item
        Command = ecDeleteLastWord
        ShortCut = 16392
      end
      item
        Command = ecUndo
        ShortCut = 32776
      end
      item
        Command = ecRedo
        ShortCut = 40968
      end
      item
        Command = ecLineBreak
        ShortCut = 13
      end
      item
        Command = ecLineBreak
        ShortCut = 8205
      end
      item
        Command = ecTab
        ShortCut = 9
      end
      item
        Command = ecShiftTab
        ShortCut = 8201
      end
      item
        Command = ecContextHelp
        ShortCut = 16496
      end
      item
        Command = ecSelectAll
        ShortCut = 16449
      end
      item
        Command = ecCopy
        ShortCut = 16451
      end
      item
        Command = ecPaste
        ShortCut = 16470
      end
      item
        Command = ecCut
        ShortCut = 16472
      end
      item
        Command = ecBlockIndent
        ShortCut = 24649
      end
      item
        Command = ecBlockUnindent
        ShortCut = 24661
      end
      item
        Command = ecLineBreak
        ShortCut = 16461
      end
      item
        Command = ecInsertLine
        ShortCut = 16462
      end
      item
        Command = ecDeleteWord
        ShortCut = 16468
      end
      item
        Command = ecDeleteLine
        ShortCut = 16473
      end
      item
        Command = ecDeleteEOL
        ShortCut = 24665
      end
      item
        Command = ecUndo
        ShortCut = 16474
      end
      item
        Command = ecRedo
        ShortCut = 24666
      end
      item
        Command = ecGotoMarker0
        ShortCut = 16432
      end
      item
        Command = ecGotoMarker1
        ShortCut = 16433
      end
      item
        Command = ecGotoMarker2
        ShortCut = 16434
      end
      item
        Command = ecGotoMarker3
        ShortCut = 16435
      end
      item
        Command = ecGotoMarker4
        ShortCut = 16436
      end
      item
        Command = ecGotoMarker5
        ShortCut = 16437
      end
      item
        Command = ecGotoMarker6
        ShortCut = 16438
      end
      item
        Command = ecGotoMarker7
        ShortCut = 16439
      end
      item
        Command = ecGotoMarker8
        ShortCut = 16440
      end
      item
        Command = ecGotoMarker9
        ShortCut = 16441
      end
      item
        Command = ecSetMarker0
        ShortCut = 24624
      end
      item
        Command = ecSetMarker1
        ShortCut = 24625
      end
      item
        Command = ecSetMarker2
        ShortCut = 24626
      end
      item
        Command = ecSetMarker3
        ShortCut = 24627
      end
      item
        Command = ecSetMarker4
        ShortCut = 24628
      end
      item
        Command = ecSetMarker5
        ShortCut = 24629
      end
      item
        Command = ecSetMarker6
        ShortCut = 24630
      end
      item
        Command = ecSetMarker7
        ShortCut = 24631
      end
      item
        Command = ecSetMarker8
        ShortCut = 24632
      end
      item
        Command = ecSetMarker9
        ShortCut = 24633
      end
      item
        Command = ecNormalSelect
        ShortCut = 24654
      end
      item
        Command = ecColumnSelect
        ShortCut = 24643
      end
      item
        Command = ecLineSelect
        ShortCut = 24652
      end
      item
        Command = ecMatchBracket
        ShortCut = 24642
      end>
    Lines.Strings = (
      'Program test;'
      'begin'
      'end.')
    OnSpecialLineColors = edSpecialLineColors
    OnStatusChange = edStatusChange
  end
  object messages: TListBox
    Left = 0
    Top = 349
    Width = 688
    Height = 66
    Align = alBottom
    ItemHeight = 13
    TabOrder = 1
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 415
    Width = 688
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object ce: TPSScriptDebugger
    CompilerOptions = []
    OnCompile = ceCompile
    OnExecute = ceExecute
    OnAfterExecute = ceAfterExecute
    Plugins = <
      item
        Plugin = IFPS3CE_DateUtils1
      end
      item
        Plugin = IFPS3CE_Std1
      end
      item
        Plugin = IFPS3CE_Controls1
      end
      item
        Plugin = IFPS3CE_StdCtrls1
      end
      item
        Plugin = IFPS3CE_Forms1
      end
      item
        Plugin = IFPS3DllPlugin1
      end
      item
        Plugin = IFPS3CE_ComObj1
      end>
    MainFileName = 'Unnamed'
    UsePreProcessor = True
    OnNeedFile = ceNeedFile
    OnIdle = ceIdle
    OnLineInfo = ceLineInfo
    OnBreakpoint = ceBreakpoint
    Left = 592
    Top = 112
  end
  object IFPS3DllPlugin1: TPSDllPlugin
    Left = 560
    Top = 112
  end
  object pashighlighter: TSynPasSyn
    Left = 592
    Top = 64
  end
  object PopupMenu1: TPopupMenu
    Left = 592
    Top = 16
    object BreakPointMenu: TMenuItem
      Caption = '&Set/Clear Breakpoint'
      ShortCut = 116
      OnClick = BreakPointMenuClick
    end
  end
  object MainMenu1: TMainMenu
    Left = 592
    Top = 160
    object File1: TMenuItem
      Caption = '&File'
      object New1: TMenuItem
        Caption = '&New'
        ShortCut = 16462
        OnClick = New1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Open1: TMenuItem
        Caption = '&Open'
        ShortCut = 16463
        OnClick = Open1Click
      end
      object Save1: TMenuItem
        Caption = '&Save'
        ShortCut = 16467
        OnClick = Save1Click
      end
      object Saveas1: TMenuItem
        Caption = 'Save &as'
        OnClick = Saveas1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = '&Exit'
        OnClick = Exit1Click
      end
    end
    object Run1: TMenuItem
      Caption = '&Run'
      object Decompile1: TMenuItem
        Caption = '&Decompile'
        OnClick = Decompile1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object StepOver1: TMenuItem
        Caption = '&Step Over'
        ShortCut = 119
        OnClick = StepOver1Click
      end
      object StepInto1: TMenuItem
        Caption = '&Step Into'
        ShortCut = 118
        OnClick = StepInto1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Reset1: TMenuItem
        Caption = '&Reset'
        ShortCut = 16497
        OnClick = Reset1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Run2: TMenuItem
        Caption = '&Run'
        ShortCut = 120
        OnClick = Run2Click
      end
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'ROPS'
    Filter = 'ROPS Files|*.ROPS'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 200
    Top = 104
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'ROPS'
    Filter = 'ROPS Files|*.ROPS'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 168
    Top = 104
  end
  object IFPS3CE_Controls1: TPSImport_Controls
    EnableStreams = True
    EnableGraphics = True
    EnableControls = True
    Left = 328
    Top = 40
  end
  object IFPS3CE_DateUtils1: TPSImport_DateUtils
    Left = 328
    Top = 72
  end
  object IFPS3CE_Std1: TPSImport_Classes
    EnableStreams = True
    EnableClasses = True
    Left = 328
    Top = 104
  end
  object IFPS3CE_Forms1: TPSImport_Forms
    EnableForms = True
    EnableMenus = True
    Left = 328
    Top = 136
  end
  object IFPS3CE_StdCtrls1: TPSImport_StdCtrls
    EnableExtCtrls = True
    EnableButtons = True
    Left = 328
    Top = 168
  end
  object IFPS3CE_ComObj1: TPSImport_ComObj
    Left = 328
    Top = 200
  end
end
