# Delphi TInterfacedObject — Exemplo Prático

Exemplo em Delphi/Pascal do **gerenciamento automático de tempo de vida** via `TInterfacedObject` e contagem de referência (ARC — Automatic Reference Counting).

Inclui dois projetos que demonstram o mesmo conceito:
- **Console** (`InterfaceExemplo`) — saída no terminal, ideal para ver o timing exato
- **Form VCL** (`InterfaceVCL`) — interface gráfica com botões e Memo para visualizar o log

---

## O problema

Toda classe `TObject` exige gerenciamento manual de memória. Esquecer o `Free` não causa erro de compilação — só um vazamento silencioso em produção:

```pascal
// SEM TInterfacedObject — Free obrigatorio em todo uso
var lRel: TRelatorioManual;
begin
  lRel := TRelatorioManual.Create('Vendas');
  try
    lRel.Gerar;
  finally
    lRel.Free;   // remova isso: sem aviso, sem erro, com vazamento
  end;
end;
```

## A solução

Com `TInterfacedObject`, declare a variável como **interface** — o compilador controla o tempo de vida. Ao sair de escopo, a contagem de referência cai a zero e `Destroy` é chamado automaticamente:

```pascal
// COM TInterfacedObject — sem Free, sem try/finally
var lRel: IRelatorio;   // variavel de INTERFACE, nao de classe
begin
  lRel := TRelatorio.Create('Vendas');
  lRel.Gerar;
end;  // Destroy chamado aqui, automaticamente
```

O `destructor Destroy` nos dois exemplos registra no log o momento exato da liberação, tornando o comportamento **visível**.

---

## Arquivos

| Arquivo | Descrição |
|---|---|
| `SemInterface.pas` | `TRelatorioManual` (TObject puro) — exige `try/finally` + `Free` |
| `ComInterface.pas` | `IRelatorio` + `TRelatorio` (TInterfacedObject) — ARC automático |
| `uLog.pas` | Callback de log atribuível — `Writeln` no console, `Memo` no Form |
| `uPrincipal.pas/dfm` | Form VCL com dois botões e Memo para visualizar o log |
| `InterfaceVCL.dpr` | Projeto VCL — abrir no Delphi e rodar |

---

## Saída esperada (console ou Memo)

```
=== SEM TInterfacedObject — Free manual obrigatorio ===
  >> inicio de TestarSemInterface
  [TRelatorioManual.Create] "Vendas" criado
  [TRelatorioManual.Gerar] gerando relatorio "Vendas"
  [TRelatorioManual.Destroy] "Vendas" destruido
  >> fim de TestarSemInterface
Observe: Destroy apareceu DENTRO do try/finally, antes do "fim".

=== COM TInterfacedObject — liberacao automatica por ARC ===
  >> inicio de TestarComInterface
  [TRelatorio.Create] "Vendas" criado
  [TRelatorio.Gerar] gerando relatorio "Vendas"
  [TRelatorio.Destroy] "Vendas" destruido AUTOMATICAMENTE
  >> fim de TestarComInterface -- destrutor ja foi chamado?
Observe: Destroy apareceu ANTES do "fim" — automatico, sem Free.
```

O `Destroy` do `TInterfacedObject` aparece **antes** do `fim` — sem nenhuma chamada a `Free` no código.

---

## Observação importante

ARC só funciona quando a variável é do **tipo da interface**:

```pascal
var lRel: IRelatorio;        // ARC ativo — Destroy automatico
var lRel: TRelatorio;        // ARC inativo — Free manual continua necessario
```

Misturar as duas formas para o mesmo objeto pode causar *double-free*. Escolha um ou outro por uso.
