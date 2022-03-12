unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;

    Edit2: TEdit;
    Label4: TLabel;

    Edit3: TEdit;
    Label5: TLabel;

    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  last_row:integer;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var color_:string; //edit1
  volume_: real;   //edit2
  owner_:string;   //edit3
  code, i, flag:integer;
begin
  flag:=0;
  // ввод данных из edit
  if not (Edit1.Text = '') then
     color_:=Edit1.Text
  else begin
      flag:=1;
      showmessage('Пустой цвет');
  end;
  val(Edit2.text,volume_, code);
  if not (code=0) or not (volume_>0) then begin
     flag:=1;
     showmessage('Не то число в объеме');
  end;
  if not (Edit3.Text = '') then
     owner_:=Edit3.Text
  else begin
      flag:=1;
      showmessage('Пустой хозяин');
  end;
  if not (flag = 1) then begin
  // вносим данные в StringGrid
  flag:=0;
  for i:=1 to StringGrid1.RowCount-1 do begin
    if (StringGrid1.Cells[1, i] = color_) and
       (StringGrid1.Cells[2, i] = floattostr(volume_)) and
       (StringGrid1.Cells[3, i] = owner_)
                            then begin
                               showmessage('Такая запись уже есть');
                               flag:=1;
                               continue;
                            end;
  end;
  //добавляем в таблицу
  if (flag=0) then begin
    StringGrid1.RowCount:=StringGrid1.RowCount+1;
    StringGrid1.Cells[0, StringGrid1.RowCount-1]:=inttostr(StringGrid1.RowCount-1);
    StringGrid1.Cells[1, StringGrid1.RowCount-1]:=color_;
    StringGrid1.Cells[2, StringGrid1.RowCount-1]:=floattostr(volume_);
    StringGrid1.Cells[3, StringGrid1.RowCount-1]:=owner_;
    Edit1.Text:='';
    Edit2.Text:='';
    Edit3.Text:='';
  end;
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
var i,j:integer;
temp_color_:string;
temp_volume_: string;
temp_owner_:string;
begin
  if radiobutton1.Checked then // sort by color
     begin
          for i:=1 to StringGrid1.RowCount-1 do begin
              for j:=1 to StringGrid1.RowCount-1 do begin
                  if  StringGrid1.Cells[1, i] <  StringGrid1.Cells[1, j] then begin
                      temp_color_:=StringGrid1.Cells[1, i];
                      temp_volume_:=StringGrid1.Cells[2, i];
                      temp_owner_:=StringGrid1.Cells[3, i];
                      StringGrid1.Cells[1, i]:=StringGrid1.Cells[1, j];
                      StringGrid1.Cells[2, i]:=StringGrid1.Cells[2, j];
                      StringGrid1.Cells[3, i]:=StringGrid1.Cells[3, j];
                      StringGrid1.Cells[1, j]:=temp_color_;
                      StringGrid1.Cells[2, j]:=temp_volume_;
                      StringGrid1.Cells[3, j]:=temp_owner_;
                  end;
              end;
          end;
     end
  else if radiobutton2.Checked then // sort by volume
     begin
          for i:=1 to StringGrid1.RowCount-1 do begin
              for j:=1 to StringGrid1.RowCount-1 do begin
                  if  StringGrid1.Cells[2, i] <  StringGrid1.Cells[2, j] then begin
                      temp_color_:=StringGrid1.Cells[1, i];
                      temp_volume_:=StringGrid1.Cells[2, i];
                      temp_owner_:=StringGrid1.Cells[3, i];
                      StringGrid1.Cells[1, i]:=StringGrid1.Cells[1, j];
                      StringGrid1.Cells[2, i]:=StringGrid1.Cells[2, j];
                      StringGrid1.Cells[3, i]:=StringGrid1.Cells[3, j];
                      StringGrid1.Cells[1, j]:=temp_color_;
                      StringGrid1.Cells[2, j]:=temp_volume_;
                      StringGrid1.Cells[3, j]:=temp_owner_;
                  end;
              end;
          end;
     end
  else if radiobutton3.Checked then // sort by color, volume
     begin
          for i:=1 to StringGrid1.RowCount-1 do begin
              for j:=1 to StringGrid1.RowCount-1 do begin
                  if  StringGrid1.Cells[1, i] <  StringGrid1.Cells[1, j] then begin
                      temp_color_:=StringGrid1.Cells[1, i];
                      temp_volume_:=StringGrid1.Cells[2, i];
                      temp_owner_:=StringGrid1.Cells[3, i];
                      StringGrid1.Cells[1, i]:=StringGrid1.Cells[1, j];
                      StringGrid1.Cells[2, i]:=StringGrid1.Cells[2, j];
                      StringGrid1.Cells[3, i]:=StringGrid1.Cells[3, j];
                      StringGrid1.Cells[1, j]:=temp_color_;
                      StringGrid1.Cells[2, j]:=temp_volume_;
                      StringGrid1.Cells[3, j]:=temp_owner_;
                  end
                  else if  StringGrid1.Cells[1, i] =  StringGrid1.Cells[1, j] then begin
                      if  StringGrid1.Cells[2, i] <  StringGrid1.Cells[2, j] then begin
                          temp_color_:=StringGrid1.Cells[1, i];
                          temp_volume_:=StringGrid1.Cells[2, i];
                          temp_owner_:=StringGrid1.Cells[3, i];
                          StringGrid1.Cells[1, i]:=StringGrid1.Cells[1, j];
                          StringGrid1.Cells[2, i]:=StringGrid1.Cells[2, j];
                          StringGrid1.Cells[3, i]:=StringGrid1.Cells[3, j];
                          StringGrid1.Cells[1, j]:=temp_color_;
                          StringGrid1.Cells[2, j]:=temp_volume_;
                          StringGrid1.Cells[3, j]:=temp_owner_;
                      end;
                  end;
              end;
          end;
     end;
end;

procedure TForm1.Label2Click(Sender: TObject);
begin

end;

procedure TForm1.Label3Click(Sender: TObject);
begin

end;

end.

