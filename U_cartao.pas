unit U_cartao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmCartao = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    lbNumCart: TLabel;
    txtNumCart: TEdit;
    txtNomCart: TEdit;
    lbNomeCart: TLabel;
    lbData: TLabel;
    cbMes: TComboBox;
    cbAno: TComboBox;
    lbCodSeg: TLabel;
    txtCvv: TEdit;
    Panel3: TPanel;
    btnAdc: TPanel;
    btnCancel: TPanel;
    procedure Panel2Click(Sender: TObject);
    procedure btnAdcClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCartao: TfrmCartao;

implementation

{$R *.dfm}

uses U_compra, U_confirmarCompra;

procedure TfrmCartao.btnAdcClick(Sender: TObject);
begin
  if txtNumCart.Text = '' then
  begin
    ShowMessage('Número do cartão em branco');
    txtNumCart.SetFocus;
  end
  else if txtNomCart.Text = '' then
  begin
    ShowMessage('Nome do cartão em branco');
    txtNomCart.SetFocus;
  end
  else if txtCvv.Text = '' then
  begin
    ShowMessage('Código de segurança em branco');
    txtCvv.SetFocus;
  end
  else if (StrToInt(cbMes.Text) < StrToInt(FormatDateTime('mm', now))) and (StrToInt(cbAno.Text) = StrToInt(FormatDateTime('yyyy', Now))) then
  begin
    ShowMessage('Data de expiração inválida');
    cbMes.SetFocus;
  end
  else if (StrToInt(cbAno.Text) < StrToInt(FormatDateTime('yyyy', now))) then
  begin
    ShowMessage('Data de expiração inválida');
    cbAno.SetFocus;
  end
  else
  begin
    frmConfCompra.ShowModal;
    frmCartao.Close;
  end;
end;

procedure TfrmCartao.btnCancelClick(Sender: TObject);
begin
  frmCompra.Show;
  frmCartao.Close;
end;

procedure TfrmCartao.Panel2Click(Sender: TObject);
begin
  frmCompra.ShowModal;
  frmCartao.Close;
end;

end.
