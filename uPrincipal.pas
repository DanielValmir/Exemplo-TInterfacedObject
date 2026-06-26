unit uPrincipal;

interface

uses
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  System.Classes;

type
  TfrmPrincipal = class(TForm)
    mmoLog: TMemo;
    pnlBotoes: TPanel;
    btnSemInterface: TButton;
    btnComInterface: TButton;
    btnLimpar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSemInterfaceClick(Sender: TObject);
    procedure btnComInterfaceClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  System.SysUtils,
  uLog,
  SemInterface,
  ComInterface;

{$R *.dfm}

{ TfrmPrincipal }

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  uLog.LogProc :=
    procedure(const pTexto: string)
    begin
      mmoLog.Lines.Add(pTexto);
    end;
end;

procedure TfrmPrincipal.btnSemInterfaceClick(Sender: TObject);
var
  lRel: TRelatorioManual;
begin
  Log('=== SEM TInterfacedObject — Free manual obrigatorio ===');
  Log('  >> inicio de TestarSemInterface');
  lRel := TRelatorioManual.Create('Vendas');
  try
    lRel.Gerar;
  finally
    lRel.Free;   // sem isso: vazamento de memoria
  end;
  Log('  >> fim de TestarSemInterface');
  Log('Observe: Destroy apareceu DENTRO do try/finally, antes do "fim".');
  Log('');
end;

procedure TfrmPrincipal.btnComInterfaceClick(Sender: TObject);
var
  lRel: IRelatorio;   // variavel de INTERFACE — ARC cuida do tempo de vida
begin
  Log('=== COM TInterfacedObject — liberacao automatica por ARC ===');
  Log('  >> inicio de TestarComInterface');
  lRel := TRelatorio.Create('Vendas');
  lRel.Gerar;
  // nenhum Free — ao sair de escopo a contagem cai a zero e Destroy e chamado
  Log('  >> fim de TestarComInterface -- destrutor ja foi chamado?');
  Log('Observe: Destroy apareceu ANTES do "fim" — automatico, sem Free.');
  Log('');
end;

procedure TfrmPrincipal.btnLimparClick(Sender: TObject);
begin
  mmoLog.Clear;
end;

end.
