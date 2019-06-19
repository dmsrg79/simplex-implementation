unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Spin;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    SpinEdit1: TSpinEdit;
    StringGrid1: TStringGrid;
    Label3: TLabel;
    SpinEdit2: TSpinEdit;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    Label4: TLabel;
    Button1: TButton;
    Label5: TLabel;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    procedure SpinEdit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox1Exit(Sender: TObject);
    procedure StringGrid2SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure StringGrid2SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure ComboBox2Change(Sender: TObject);
  private
    kol_x : Integer;
    kol_ogranich : Integer;
    matrix : array of array of Double;
    function proverka_optinal(naprav:string):Integer;
    function poisk_vivod_bazis(vvod_index : Integer):Integer;
    procedure clear_result;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.SpinEdit1Change(Sender: TObject);
var
  i : Integer;
begin
  kol_X := SpinEdit1.Value;

  StringGrid1.ColCount := kol_X;
  StringGrid2.ColCount := kol_X+2;
  StringGrid3.ColCount := kol_X;

  for i := 0 to kol_X - 1 do
   Begin
    StringGrid1.Cells[i,0] := 'X' + IntToStr(i+1);
    StringGrid2.Cells[i,0] := 'X' + IntToStr(i+1);
    StringGrid3.Cells[i,0] := 'X' + IntToStr(i+1);
   End;

  StringGrid2.Cells[kol_X,0] := 'знак';
  StringGrid2.Cells[kol_X + 1,0] := 'значение';

  clear_result;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  StringGrid2.DefaultRowHeight := ComboBox1.Height;
  ComboBox1.Visible := False;


  ComboBox1.Items.Add('>');
  ComboBox1.Items.Add('>=');
  ComboBox1.Items.Add('=');
  ComboBox1.Items.Add('<');
  ComboBox1.Items.Add('<=');

  ComboBox3.ItemIndex := 0;
  ComboBox3Change(Self);
end;

procedure TForm1.SpinEdit2Change(Sender: TObject);
begin
  kol_ogranich := SpinEdit2.Value;

  StringGrid2.RowCount := kol_ogranich + 1;

  clear_result;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin

  StringGrid2.Cells[StringGrid2.Col, StringGrid2.Row] := ComboBox1.Items[ComboBox1.ItemIndex];
  ComboBox1.Visible := False;
  StringGrid2.SetFocus;
end;

procedure TForm1.ComboBox1Exit(Sender: TObject);
begin

  StringGrid2.Cells[StringGrid2.Col, StringGrid2.Row] := ComboBox1.Items[ComboBox1.ItemIndex];
  ComboBox1.Visible := False;
  StringGrid2.SetFocus;
end;

procedure TForm1.StringGrid2SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  R: TRect;
begin
  if ((aCol = kol_x) AND (aRow <> 0)) then
   begin

    R := StringGrid2.CellRect(aCol, aRow);
    R.Left := R.Left + StringGrid2.Left;
    R.Right := R.Right + StringGrid2.Left;
    R.Top := R.Top + StringGrid2.Top;
    R.Bottom := R.Bottom + StringGrid2.Top;
    ComboBox1.Left := R.Left + 1;
    ComboBox1.Top := R.Top + 1;
    ComboBox1.Width := (R.Right + 1) - R.Left;
    ComboBox1.Height := (R.Bottom + 1) - R.Top;

    ComboBox1.Visible := True;
    ComboBox1.SetFocus;
   end;
  CanSelect := True;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  basiz : array of Integer;
  opor_plan : array of Double;
  znach_cell : string;
  znach_F : Double;
  vvod_index : Integer;
  vivod_index : Integer;
  min_max : string;
  i, j : Integer;
  buff : Double;
begin

  for i := 1 to kol_ogranich do
   if StrToFloat(StringGrid2.Cells[kol_x + 1, i]) < 0 then
    Begin

     Label6.Visible := True;
     Label7.Visible := True;


     for j := 0 to kol_x + 1 do
      if j <> kol_x
       then StringGrid2.Cells[j, i] := FloatToStr(StrToFloat(StringGrid2.Cells[j, i]) * -1)
       else
        Begin
         znach_cell := StringGrid2.Cells[j, i];
         if znach_cell = '<=' then StringGrid2.Cells[j, i] := '>=';
         if znach_cell = '<' then StringGrid2.Cells[j, i] := '>';
         if znach_cell = '>=' then StringGrid2.Cells[j, i] := '<=';
         if znach_cell = '>' then StringGrid2.Cells[j, i] := '<';
        End;
    end;


  SetLength(matrix, kol_ogranich + 1, kol_x + (2 * kol_ogranich) + 1);

  for i := 0 to kol_ogranich do
  for j := 0 to kol_x + (2 * kol_ogranich) do matrix[i, j] := 0;

  SetLength(basiz, kol_ogranich);

  for i := 0 to kol_ogranich - 1 do basiz[i] := 0;

  SetLength(opor_plan, kol_x + (2 * kol_ogranich));

  for i:=0 to kol_x + (2 * kol_ogranich) - 1 do opor_plan[i] := 0;


  for i := 0 to kol_x do
   begin
    for j := 0 to kol_ogranich - 1 do
     begin
      if (i = 0)
       then matrix[j, i] := StrToFloat(StringGrid2.Cells[kol_x + 1, j + 1])
       else matrix[j, i] := StrToFloat(StringGrid2.Cells[i - 1, j + 1]);
     end;
   end;


   for j := 0 to kol_ogranich - 1 do
    begin
      znach_cell := StringGrid2.Cells[kol_x, j + 1];

     if ((znach_cell = '<') or (znach_cell = '<='))
      then
       Begin
        matrix[j, kol_x + j + 1] := 1;

       end;

     if ((znach_cell = '>') or (znach_cell = '>='))
      then matrix[j, kol_x + j + 1] := -1;
    end;


   for j := 0 to kol_ogranich - 1 do
    begin
     matrix[j, kol_x + kol_ogranich + 1 + j] := 1;
     basiz[j] := kol_x + kol_ogranich + j + 1;
    End;



   znach_F := 0;
   for j := 0 to kol_x + (2 * kol_ogranich) - 1 do
    Begin
     for i := 0 to kol_ogranich - 1 do
       if ((j + 1) = basiz[i]) then opor_plan[j] := matrix[i, 0];

     if (j < kol_x)
      then znach_cell := StringGrid1.Cells[j, 1]
      else znach_cell := '0';

     znach_F := znach_F + (StrToFloat(znach_cell) * opor_plan[j]);


     matrix[kol_ogranich, j + 1] := StrToFloat(znach_cell) * (-1);
    end;

   matrix[kol_ogranich, 0] := znach_F;




   if (ComboBox2.ItemIndex = 0)
    then min_max := 'min'
    else min_max := 'max';


   vvod_index := proverka_optinal(min_max);
   while vvod_index <> 0 do
    Begin

     vivod_index := poisk_vivod_bazis(vvod_index);


     buff := matrix[vivod_index, vvod_index];
     for j := 0 to kol_x + (2 * kol_ogranich) do
      matrix[vivod_index, j] := matrix[vivod_index, j] / buff;


     for i := 0 to kol_ogranich do
      Begin
       if (i <> (vivod_index)) then
        Begin
         buff := matrix[i, vvod_index] * (-1);
         For j := 0 to kol_x + (2 * kol_ogranich) do
          Begin
           matrix[i, j] := matrix[i, j] + (matrix[vivod_index, j] * buff);
          end;
        end;
      end;


     basiz[vivod_index] := vvod_index;


     vvod_index := proverka_optinal(min_max);
    end;


   for i := 1 to kol_x do
    Begin
     StringGrid3.Cells[i - 1, 1] := '0';
     for j := 0 to kol_ogranich - 1 do
      if basiz[j] = i then StringGrid3.Cells[i - 1, 1] := FloatToStr(matrix[j, 0]);
    end;
    
   buff := matrix[kol_ogranich, 0];
   Edit1.Text := FloatToStr(buff);

end;

function TForm1.proverka_optinal(naprav: string): Integer;
var
  j : Integer;
  max, min : Double;
  index : Integer;
  buff : Double;
begin
  max := 0; min := 0; index := 0;
  if naprav = 'min' then
   for j := 1 to kol_x + (2 * kol_ogranich) do
    Begin
     buff := matrix[kol_ogranich, j];
     if ((buff > 0) and (buff > max))
      then
       Begin
        max := matrix[kol_ogranich, j];
        index := j;
       end;
    End;

  if naprav = 'max' then
   for j := 1 to kol_x + (2 * kol_ogranich) do
    Begin
     buff := matrix[kol_ogranich, j];
     if ((buff < 0) and (buff < min))
      then
       Begin
        min := matrix[kol_ogranich, j];
        index := j;
       end;
    End;
    
  Result := index;
end;

function TForm1.poisk_vivod_bazis(vvod_index: Integer): Integer;
var
  i : Integer;
  min : Double;
  index : integer;
begin
  Min := -1; i := 0;
  while min = -1 do
   begin
    if matrix[i, vvod_index] > 0
     then min := matrix[i, 0]/matrix[i, vvod_index];
    i := i + 1; 
   end;
   
  index := i - 1;
  For i := 0 to kol_ogranich - 1 do
   begin
    if matrix[i, vvod_index] > 0 then
     if ((matrix[i, 0]/matrix[i, vvod_index]) < min)
      then
       begin
        min := matrix[i, 0]/matrix[i, vvod_index];
        index := i;
       end;
   end;

  Result := index; 
end;

procedure TForm1.ComboBox3Change(Sender: TObject);
begin
  if ComboBox3.ItemIndex = 0 then
   Begin

    SpinEdit1.Value := 2;
    SpinEdit2.Value := 3;
    ComboBox2.ItemIndex := 0;
    StringGrid1.Cells[0,1] := '10';
    StringGrid1.Cells[1,1] := '-15';

    StringGrid2.Cells[0,1] := '-1';
    StringGrid2.Cells[1,1] := '1';
    StringGrid2.Cells[2,1] := '<=';
    StringGrid2.Cells[3,1] := '2';

    StringGrid2.Cells[0,2] := '-1';
    StringGrid2.Cells[1,2] := '3';
    StringGrid2.Cells[2,2] := '<=';
    StringGrid2.Cells[3,2] := '10';

    StringGrid2.Cells[0,3] := '5';
    StringGrid2.Cells[1,3] := '1';
    StringGrid2.Cells[2,3] := '<=';
    StringGrid2.Cells[3,3] := '30';

    SpinEdit1Change(Self);
    SpinEdit2Change(Self);

    clear_result;
   end;

  if ComboBox3.ItemIndex = 1 then
   Begin
    SpinEdit1.Value := 3;
    SpinEdit2.Value := 3;
    ComboBox2.ItemIndex := 1;
    StringGrid1.Cells[0,1] := '3';
    StringGrid1.Cells[1,1] := '5';
    StringGrid1.Cells[2,1] := '4';

    StringGrid2.Cells[0,1] := '0,1';
    StringGrid2.Cells[1,1] := '0,2';
    StringGrid2.Cells[2,1] := '0,4';
    StringGrid2.Cells[3,1] := '<=';
    StringGrid2.Cells[4,1] := '1100';

    StringGrid2.Cells[0,2] := '0,05';
    StringGrid2.Cells[1,2] := '0,02';
    StringGrid2.Cells[2,2] := '0,02';
    StringGrid2.Cells[3,2] := '<=';
    StringGrid2.Cells[4,2] := '120';

    StringGrid2.Cells[0,3] := '3';
    StringGrid2.Cells[1,3] := '1';
    StringGrid2.Cells[2,3] := '2';
    StringGrid2.Cells[3,3] := '<=';
    StringGrid2.Cells[4,3] := '8000';

    SpinEdit1Change(Self);
    SpinEdit2Change(Self);

    clear_result;
   end;

  if ComboBox3.ItemIndex = 2 then
   Begin
    SpinEdit1.Value := 2;
    SpinEdit2.Value := 3;
    ComboBox2.ItemIndex := 1;
    StringGrid1.Cells[0,1] := '3';
    StringGrid1.Cells[1,1] := '4';

    StringGrid2.Cells[0,1] := '1';
    StringGrid2.Cells[1,1] := '1';
    StringGrid2.Cells[2,1] := '<=';
    StringGrid2.Cells[3,1] := '550';

    StringGrid2.Cells[0,2] := '2';
    StringGrid2.Cells[1,2] := '3';
    StringGrid2.Cells[2,2] := '<=';
    StringGrid2.Cells[3,2] := '1200';

    StringGrid2.Cells[0,3] := '12';
    StringGrid2.Cells[1,3] := '30';
    StringGrid2.Cells[2,3] := '<=';
    StringGrid2.Cells[3,3] := '9600';

    SpinEdit1Change(Self);
    SpinEdit2Change(Self);

    clear_result;
   end;

  if ComboBox3.ItemIndex = 3 then
   Begin
    SpinEdit1.Value := 2;
    SpinEdit2.Value := 4;
    ComboBox2.ItemIndex := 1;
    StringGrid1.Cells[0,1] := '1';
    StringGrid1.Cells[1,1] := '2';

    StringGrid2.Cells[0,1] := '1';
    StringGrid2.Cells[1,1] := '2';
    StringGrid2.Cells[2,1] := '>=';
    StringGrid2.Cells[3,1] := '2';

    StringGrid2.Cells[0,2] := '1';
    StringGrid2.Cells[1,2] := '1';
    StringGrid2.Cells[2,2] := '>=';
    StringGrid2.Cells[3,2] := '4';

    StringGrid2.Cells[0,3] := '1';
    StringGrid2.Cells[1,3] := '-1';
    StringGrid2.Cells[2,3] := '<=';
    StringGrid2.Cells[3,3] := '2';

    StringGrid2.Cells[0,4] := '0';
    StringGrid2.Cells[1,4] := '1';
    StringGrid2.Cells[2,4] := '<=';
    StringGrid2.Cells[3,4] := '6';

    SpinEdit1Change(Self);
    SpinEdit2Change(Self);

    clear_result;
   end; 
end;

procedure TForm1.clear_result;
var
  i : Integer;
begin
  for i := 0 to kol_x - 1 do StringGrid3.Cells[i, 1] := '';
  Edit1.Text := '';


  Label6.Visible := false;
  Label7.Visible := false;
end;

procedure TForm1.StringGrid2SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  clear_result;
end;

procedure TForm1.StringGrid1SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  clear_result;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  clear_result;
end;

end.
