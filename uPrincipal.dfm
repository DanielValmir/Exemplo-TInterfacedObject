object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Interface vs TObject '#8212' Exemplo Delphi'
  ClientHeight = 480
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object pnlBotoes: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btnSemInterface: TButton
      Left = 8
      Top = 8
      Width = 180
      Height = 25
      Caption = 'Sem Interface (Free manual)'
      TabOrder = 0
      OnClick = btnSemInterfaceClick
    end
    object btnComInterface: TButton
      Left = 196
      Top = 8
      Width = 180
      Height = 25
      Caption = 'Com Interface (ARC automatico)'
      TabOrder = 1
      OnClick = btnComInterfaceClick
    end
    object btnLimpar: TButton
      Left = 384
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Limpar'
      TabOrder = 2
      OnClick = btnLimparClick
    end
  end
  object mmoLog: TMemo
    Left = 0
    Top = 41
    Width = 640
    Height = 439
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
