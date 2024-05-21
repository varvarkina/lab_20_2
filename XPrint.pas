{
��� ��������� XPrint ���������� ����������� ��������� ��������� �������� 
�� ����� � �������� ����� ��������� ������ �� INPUT ������ �� ����� 10 ��������. �� �������� ��� ������ �������� ����� ���������.
���� � ������ ������������ ���������������� �������, �� �������� �� ������ � ��������� ������ ���������.
�������� ��� ����������������� ������� ������ � ���� ���������. �� ����������� �������������� ������, �� ������� ������� ������ ��������� ���.
}
PROGRAM XPrint(INPUT, OUTPUT);
CONST
  LineLength = 50;
  SymbLength = 5;
  MatrixSize = LineLength * SymbLength;
  MaxInput = 10;
TYPE
  StringMatrix = SET OF 1..MatrixSize;  
  
PROCEDURE Matrix(VAR SetOfSymbols: StringMatrix; VAR F: TEXT);
VAR
  Symb: CHAR;
  SymbNum: INTEGER;
  FileCh: CHAR;
  Position: INTEGER;
BEGIN
  SetOfSymbols := [];
  SymbNum := 1;
  WHILE (NOT EOLN(INPUT)) AND (SymbNum <= MaxInput)
  DO
    BEGIN
      READ(INPUT, Symb);
      RESET(F);
      READ(F, FileCh);
      WHILE (FileCh <> Symb) AND (NOT EOF(F))
      DO
        BEGIN
          READLN(F);
          IF NOT EOF(F)
          THEN
            READ(F, FileCh)
        END;  
      IF FileCh = Symb
      THEN
        BEGIN
          WHILE NOT EOLN(F)
          DO
            BEGIN
              READ(F, Position);
              CASE Position OF
                1..5: Position := Position + SymbLength * 
                (SymbNum - 1) + 0 * (LineLength - SymbLength);
                6..10: Position := Position + SymbLength * 
                (SymbNum - 1) + 1 * (LineLength - SymbLength); 
                11..15: Position := Position + SymbLength * 
                (SymbNum - 1) + 2 * (LineLength - SymbLength);
                16..20: Position := Position + SymbLength * 
                (SymbNum - 1) + 3 * (LineLength - SymbLength);
                21..25: Position := Position + SymbLength * 
                (SymbNum - 1) + 4 * (LineLength - SymbLength)
              END;   
              SetOfSymbols := SetOfSymbols + [Position]
            END
        END;
      SymbNum := SymbNum + 1;
      CLOSE(F)            
    END
END;   

PROCEDURE Print(VAR SetOfSymbols: StringMatrix);
VAR
  I: INTEGER;
BEGIN
  IF SetOfSymbols <> []
  THEN
    FOR I := 1 TO MatrixSize
    DO
      BEGIN
        IF (I IN SetOfSymbols) 
        THEN
          WRITE(OUTPUT, '#')
        ELSE
          WRITE(OUTPUT, ' '); 
        IF (I MOD 5 = 0) AND (I MOD LineLength <> 0)
        THEN
          WRITE(OUTPUT, ' ');   
        IF I MOD LineLength = 0
        THEN
          WRITELN(OUTPUT) 
      END 
  ELSE
    WRITELN(OUTPUT, 'Try symbols: "A", "G", "O"')
END;

PROCEDURE SymbolsPrint;
VAR
  SetOfSymbols: StringMatrix;
  F: TEXT;   
BEGIN
  ASSIGN(F, 'F.txt');
  Matrix(SetOfSymbols, F);
  Print(SetOfSymbols)     
END;

BEGIN
  SymbolsPrint
END.    
