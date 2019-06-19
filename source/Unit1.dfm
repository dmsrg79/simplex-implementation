object Form1: TForm1
  Left = 279
  Top = 167
  Caption = #1056#1077#1096#1077#1085#1080#1077' '#1079#1072#1076#1072#1095#1080' '#1083#1080#1085#1077#1081#1085#1086#1075#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1080#1088#1086#1074#1072#1085#1080#1103
  ClientHeight = 440
  ClientWidth = 725
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 40
    Width = 12
    Height = 13
    Caption = 'F='
  end
  object Label2: TLabel
    Left = 8
    Top = 12
    Width = 131
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1085#1077#1080#1079#1074#1077#1089#1090#1085#1099#1093':'
  end
  object Label3: TLabel
    Left = 8
    Top = 120
    Width = 129
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1081':'
  end
  object Label4: TLabel
    Left = 8
    Top = 296
    Width = 55
    Height = 13
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090':'
  end
  object Label5: TLabel
    Left = 8
    Top = 408
    Width = 142
    Height = 13
    Caption = #1047#1085#1072#1095#1077#1085#1080#1077' '#1094#1077#1083#1077#1074#1086#1081' '#1092#1091#1085#1082#1094#1080#1080':'
  end
  object Label6: TLabel
    Left = 304
    Top = 112
    Width = 273
    Height = 13
    Caption = #1055#1088#1086#1074#1077#1076#1077#1085#1072' '#1082#1086#1088#1088#1077#1082#1094#1080#1103' '#1080#1089#1093#1086#1076#1085#1099#1093' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1081' '#1074' '#1089#1074#1103#1079#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label7: TLabel
    Left = 304
    Top = 128
    Width = 254
    Height = 13
    Caption = #1089' '#1085#1072#1083#1080#1095#1080#1077#1084' '#1086#1090#1088#1080#1094#1072#1090#1077#1083#1100#1085#1099#1093' '#1089#1074#1086#1073#1086#1076#1085#1099#1093' '#1101#1083#1077#1084#1077#1085#1090#1086#1074
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object SpinEdit1: TSpinEdit
    Left = 144
    Top = 8
    Width = 65
    Height = 22
    MaxValue = 10
    MinValue = 2
    TabOrder = 0
    Value = 2
    OnChange = SpinEdit1Change
  end
  object StringGrid1: TStringGrid
    Left = 32
    Top = 40
    Width = 681
    Height = 65
    ColCount = 2
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 1
    OnSetEditText = StringGrid1SetEditText
  end
  object SpinEdit2: TSpinEdit
    Left = 144
    Top = 112
    Width = 49
    Height = 22
    MaxValue = 10
    MinValue = 1
    TabOrder = 2
    Value = 3
    OnChange = SpinEdit2Change
  end
  object StringGrid2: TStringGrid
    Left = 32
    Top = 144
    Width = 681
    Height = 129
    ColCount = 2
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 3
    OnSelectCell = StringGrid2SelectCell
    OnSetEditText = StringGrid2SetEditText
  end
  object StringGrid3: TStringGrid
    Left = 32
    Top = 320
    Width = 681
    Height = 65
    ColCount = 2
    FixedCols = 0
    RowCount = 2
    TabOrder = 4
  end
  object Button1: TButton
    Left = 328
    Top = 284
    Width = 75
    Height = 25
    Caption = #1055#1086#1089#1095#1080#1090#1072#1090#1100
    TabOrder = 5
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 152
    Top = 406
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 6
  end
  object ComboBox1: TComboBox
    Left = 232
    Top = 112
    Width = 57
    Height = 21
    TabOrder = 7
    OnChange = ComboBox1Change
    OnExit = ComboBox1Exit
  end
  object ComboBox2: TComboBox
    Left = 248
    Top = 8
    Width = 217
    Height = 21
    ItemIndex = 0
    TabOrder = 8
    Text = #1054#1087#1088#1077#1076#1077#1083#1080#1090#1100' '#1084#1080#1085#1080#1084#1072#1083#1100#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
    OnChange = ComboBox2Change
    Items.Strings = (
      #1054#1087#1088#1077#1076#1077#1083#1080#1090#1100' '#1084#1080#1085#1080#1084#1072#1083#1100#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
      #1054#1087#1088#1077#1076#1077#1083#1080#1090#1100' '#1084#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077)
  end
  object ComboBox3: TComboBox
    Left = 552
    Top = 8
    Width = 145
    Height = 21
    TabOrder = 9
    Text = #1055#1088#1080#1084#1077#1088' 1'
    OnChange = ComboBox3Change
    Items.Strings = (
      #1055#1088#1080#1084#1077#1088' 1'
      #1055#1088#1080#1084#1077#1088' 2'
      #1055#1088#1080#1084#1077#1088' 3'
      #1055#1088#1080#1084#1077#1088' 4')
  end
end
