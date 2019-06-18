object frmPrompt: TfrmPrompt
  Left = 192
  Top = 122
  Caption = 'Desenvolvido por Icaro.Martins'
  ClientHeight = 311
  ClientWidth = 456
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    456
    311)
  PixelsPerInch = 96
  TextHeight = 13
  object mmoConsole: TMemo
    Left = 8
    Top = 8
    Width = 313
    Height = 265
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object edtComando: TEdit
    Left = 8
    Top = 280
    Width = 361
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 1
    Text = 'ping mga-oswaldo'
    OnKeyPress = edtComandoKeyPress
  end
  object Button1: TButton
    Left = 373
    Top = 280
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Executar'
    TabOrder = 2
    OnClick = Button1Click
  end
  object lbxComandos: TListBox
    Left = 328
    Top = 8
    Width = 121
    Height = 265
    Anchors = [akTop, akRight, akBottom]
    ItemHeight = 13
    Items.Strings = (
      'ping mga-oswaldo'
      'ping www.google.com.br'
      'tracert mga-oswaldo'
      'tracert www.google.com.br'
      'taskkill /f /im calc.exe'
      'dir c:'
      'net view \\mga-oswaldo')
    TabOrder = 3
    OnClick = lbxComandosClick
  end
end
