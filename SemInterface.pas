unit SemInterface;

// SEM TInterfacedObject: classe TObject pura.
// Cada uso exige try/finally + Free manual. Esquecer = vazamento de memoria.

interface

uses
  System.SysUtils;

type
  TRelatorioManual = class
  strict private
    FNome: string;
  public
    /// <summary>Metodo para criar instancia com nome do relatorio.</summary>
    constructor Create(const pNome: string);
    /// <summary>Destrutor — visivel no console para provar quando ocorre.</summary>
    destructor Destroy; override;
    /// <summary>Metodo para gerar o relatorio.</summary>
    procedure Gerar;
  end;

implementation

uses
  uLog;

{ TRelatorioManual }

constructor TRelatorioManual.Create(const pNome: string);
begin
  inherited Create;
  FNome := pNome;
  Log(Format('  [TRelatorioManual.Create] "%s" criado', [FNome]));
end;

destructor TRelatorioManual.Destroy;
begin
  Log(Format('  [TRelatorioManual.Destroy] "%s" destruido', [FNome]));
  inherited;
end;

procedure TRelatorioManual.Gerar;
begin
  Log(Format('  [TRelatorioManual.Gerar] gerando relatorio "%s"', [FNome]));
end;

end.
